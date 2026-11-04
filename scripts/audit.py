#!/usr/bin/env python3
"""Fail on content that should never reach a skill library.

A pattern scan cannot prove a file is safe. It catches the obvious cases and
hidden text; reading upstream diffs before moving a pin is still required.
"""
import re, sys
from pathlib import Path

RULES = {
    "prompt-injection": r"(?i)ignore (all |any )?(previous|prior|above) (instructions|prompts)"
                        r"|(do not|don't|never) (tell|inform|mention (this )?to) the user"
                        r"|without (telling|informing|asking) the user",
    "remote-exec": r"(?i)(curl|wget)\s[^|\n]*\|\s*(sudo\s+)?(ba|z)?sh\b|base64\s+(-d|--decode)\s*\|",
    "secret-paths": r"(?i)~/\.ssh|~/\.aws|id_rsa|\.claude/\.credentials|\.npmrc",
    "agent-config": r"(?i)bypassPermissions|dangerously-skip-permissions|~/\.claude/settings",
}
HIDDEN = re.compile("[​-‏‪-‮⁠-⁤\U000e0000-\U000e007f]")
ALLOWED_SUFFIXES = {".md", ".css", ".txt"}


def audit_tree(root):
    root, problems = Path(root), []
    for f in sorted(p for p in root.rglob("*") if p.is_file()):
        rel = f.relative_to(root)
        if f.suffix.lower() not in ALLOWED_SUFFIXES:
            problems.append(f"{rel}: disallowed file type")
            continue
        text = f.read_text(encoding="utf8", errors="replace")
        if HIDDEN.search(text):
            problems.append(f"{rel}: hidden unicode")
        for n, line in enumerate(text.splitlines(), 1):
            for rule, pattern in RULES.items():
                if re.search(pattern, line):
                    problems.append(f"{rel}:{n}: {rule}: {line.strip()[:100]}")
    return problems


if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "skills/frontend/library"
    found = audit_tree(target)
    print("\n".join(found) or "clean")
    sys.exit(1 if found else 0)
