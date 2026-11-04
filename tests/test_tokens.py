#!/usr/bin/env python3
"""Check the theming recipe's contrast at every 10 degrees of hue, in both themes."""
import math, re, sys
from pathlib import Path

DOC = Path(__file__).resolve().parent.parent / "skills/frontend/references/theming.md"
PAIRS = [("foreground", "background", 4.5), ("muted-foreground", "background", 4.5),
         ("muted-foreground", "muted", 4.5), ("primary-foreground", "primary", 4.5),
         ("primary", "background", 3.0)]


def to_linear_srgb(l, c, h):
    a, b = c * math.cos(math.radians(h)), c * math.sin(math.radians(h))
    l_, m_, s_ = (l + .3963377774 * a + .2158037573 * b) ** 3, \
                 (l - .1055613458 * a - .0638541728 * b) ** 3, \
                 (l - .0894841775 * a - 1.2914855480 * b) ** 3
    rgb = (4.0767416621 * l_ - 3.3077115913 * m_ + .2309699292 * s_,
           -1.2684380046 * l_ + 2.6097574011 * m_ - .3413193965 * s_,
           -.0041960863 * l_ - .7034186147 * m_ + 1.7076147010 * s_)
    return [min(1, max(0, v)) for v in rgb]


def luminance(lch):
    r, g, b = to_linear_srgb(*lch)
    return .2126 * r + .7152 * g + .0722 * b


def contrast(x, y):
    hi, lo = sorted((luminance(x), luminance(y)), reverse=True)
    return (hi + .05) / (lo + .05)


def theme(block):
    return {k: (float(l), float(c)) for k, l, c in
            re.findall(r"--([\w-]+): oklch\(([\d.]+) ([\d.]+) var\(--brand-hue\)\)", block)}


css = DOC.read_text()
themes = {"light": theme(css[css.index(":root {"):css.index(".dark {")]),
          "dark": theme(css[css.index(".dark {"):css.index("@theme inline {")])}
worst = {}
for name, tokens in themes.items():
    for fg, bg, need in PAIRS:
        for hue in range(0, 360, 10):
            ratio = contrast((*tokens[fg], hue), (*tokens[bg], hue))
            key = (name, fg, bg, need)
            if key not in worst or ratio < worst[key][0]:
                worst[key] = (ratio, hue)

failed = False
for (name, fg, bg, need), (ratio, hue) in worst.items():
    ok = ratio >= need
    failed |= not ok
    print(f"{'ok  ' if ok else 'FAIL'} {name:5} {fg:19} on {bg:11} worst {ratio:5.2f} at hue {hue:3} (need {need})")
sys.exit(1 if failed else 0)
