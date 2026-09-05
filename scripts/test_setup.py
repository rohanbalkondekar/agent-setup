#!/usr/bin/env python3
"""Exercise setup scripts with temporary runtime homes and stubbed plugin CLIs."""
import os
from pathlib import Path
import subprocess
import tempfile

REPO = Path(__file__).resolve().parents[1]


def main():
    with tempfile.TemporaryDirectory(prefix="agent-setup-test-") as tmp:
        root = Path(tmp)
        home = root / "home"
        home.mkdir()
        bin_dir = root / "bin"
        bin_dir.mkdir()
        calls = root / "plugin-calls"
        for cli in ("claude", "codex"):
            stub = bin_dir / cli
            stub.write_text('#!/bin/sh\nprintf "called\\n" >> "$PLUGIN_CALLS"\n')
            stub.chmod(0o755)
        env = dict(os.environ, HOME=str(home), CODEX_HOME=str(home / ".codex"),
                   PRIME_AGENT_CODING_AGENT_DIR=str(home / ".prime/agent"),
                   AGENT_SETUP_PLUGINS="", AGENT_SETUP_GLOBAL="1",
                   AGENT_SETUP_SKILLS="redpen prove-it", PLUGIN_CALLS=str(calls),
                   PATH=f"{bin_dir}:{os.environ['PATH']}")

        def run(script, *args, ok=True, **overrides):
            result = subprocess.run(["bash", str(REPO / "scripts" / script), *map(str, args)],
                                    env=env | overrides, text=True, capture_output=True)
            assert (result.returncode == 0) == ok, result.stdout + result.stderr
            return result

        # Invalid selections must fail before even creating a runtime directory.
        run("install.sh", ok=False, AGENT_SETUP_SKILLS="redpen missing-skill")
        run("install.sh", ok=False, AGENT_SETUP_SKILLS="../redpen")
        assert list(home.iterdir()) == []

        skill = home / ".codex/skills/redpen"
        skill.mkdir(parents=True)
        (skill / "custom.txt").write_text("keep me")
        run("install.sh")
        assert not calls.exists(), "Empty plugin override must skip all plugin calls"
        backups = list(skill.parent.glob("redpen.backup.*/original/custom.txt"))
        assert len(backups) == 1 and backups[0].read_text() == "keep me"
        assert skill.resolve() == REPO / "plugins/core/skills/redpen"
        run("install.sh")
        assert len(list(skill.parent.glob("redpen.backup.*"))) == 1
        run("verify.sh")

        # Private globals remain intact when global linking is disabled.
        global_file = home / ".codex/AGENTS.md"
        global_file.unlink()
        global_file.write_text("private instructions")
        run("install.sh", AGENT_SETUP_GLOBAL="0")
        assert global_file.read_text() == "private instructions"
        result = run("verify.sh", ok=False)
        assert "Verification failed at line" in result.stderr

        # A broken skill link must fail verification even without globals.
        skill.unlink()
        skill.symlink_to(root / "missing")
        run("verify.sh", ok=False, AGENT_SETUP_GLOBAL="0")
        run("install.sh", AGENT_SETUP_GLOBAL="0")
        assert skill.resolve() == REPO / "plugins/core/skills/redpen"

        workspace = root / "workspace with spaces"
        run("install-scope.sh", "personal", workspace)
        assert (workspace / "AGENTS.md").resolve() == REPO / "profiles/base/AGENTS.md"
        assert (workspace / "CLAUDE.md").resolve() == (workspace / "AGENTS.md").resolve()
        (workspace / "AGENTS.md").unlink()
        (workspace / "AGENTS.md").write_text("repository rules")
        run("install-scope.sh", "work", workspace)
        assert (workspace / "AGENTS.md").read_text() == "repository rules"
        run("install-scope.sh", "unknown", root / "invalid", ok=False)
        assert not (root / "invalid").exists()

        # The updater must leave unreviewed work alone before contacting Git.
        clone = root / "checkout"
        clone.mkdir()
        subprocess.run(["git", "init", "-q", str(clone)], check=True)
        (clone / "scripts").mkdir()
        (clone / "scripts/update.sh").write_text((REPO / "scripts/update.sh").read_text())
        result = subprocess.run(["bash", str(clone / "scripts/update.sh")],
                                env=env, text=True, capture_output=True)
        assert result.returncode != 0 and "local changes" in result.stderr
    print("Setup regression checks passed (temporary homes; no network calls).")


if __name__ == "__main__":
    main()
