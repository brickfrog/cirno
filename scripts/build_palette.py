#!/usr/bin/env python3
"""
build_palette.py: the single source of truth for the Cirno theme.

Cirno is the ice fairy of Touhou. The palette is pulled directly from the
project wallpaper (wallpaper/cirno.jpeg): a midnight-navy starfield with a
chibi Cirno in the corner. The colours sampled from the image anchor it:

    eye cyan ...... #21b3dc   ->  the brand colour ("ice")
    ribbon red .... #6d1b32   ->  the one warm accent ("ribbon")
    starlight ..... #ccf3ff   ->  the foreground tint
    sky (dominant)  #11235a   ->  the background hue

Run this to regenerate palette/cirno.json and to verify every accent clears
WCAG AA against the background it sits on. No third-party deps.
"""
import json, os, sys

# --------------------------------------------------------------------------
# Dark variant ("Cirno"): night sky over snow.
# A cool, low-saturation navy base so long sessions don't fatigue the eyes,
# starlight-blue text, ice-cyan as the primary accent, and the red ribbon as
# the single warm complement. Hue families are spaced far enough apart that
# the ANSI 16 stay distinguishable despite the icy bias.
# --------------------------------------------------------------------------
DARK = {
    "name": "Cirno",
    "appearance": "dark",
    # backgrounds, darkest -> lightest (the night sky + its surfaces)
    "crust":     "#070c18",  # deepest; window borders, behind-the-gutter
    "mantle":    "#0a1120",  # sidebars, inactive panels
    "base":      "#0e1525",  # main editor / terminal background (midnight)
    "surface0":  "#16203a",  # current-line, subtle panels
    "surface1":  "#1f2c4a",  # selection, borders
    "surface2":  "#2b3c60",  # active selection, scrollbars
    "overlay0":  "#3d5277",  # disabled text, faint UI
    "overlay1":  "#536b91",  # line numbers
    "overlay2":  "#6a82a8",  # subtle but legible UI text
    # foreground (starlight on snow)
    "text":      "#d4e4f5",  # main text
    "subtext1":  "#bdcfe6",
    "subtext0":  "#a3b6d2",
    "comment":   "#5f7299",  # muted slate; recedes but stays readable
    # accents
    "ice":       "#7ad6f0",  # PRIMARY: Cirno's eyes (functions / links / cursor)
    "frost":     "#ace6f7",  # bright cyan
    "cyan":      "#4cc6ea",  # deeper ice
    "teal":      "#5fccc6",  # frost-on-glass green-cyan
    "sky":       "#6fb2ee",  # daytime sky blue
    "blue":      "#5b90e4",  # her dress
    "sapphire":  "#3aa9dd",  # between blue and cyan
    "periwinkle":"#9fb6f2",  # the dusty mauve horizon, lifted
    "mauve":     "#b78ee2",  # frost violet (magenta family)
    "ribbon":    "#ec5a72",  # RED: her bow; errors, the warm pop
    "flare":     "#f4849a",  # bright red
    "peach":     "#eca06a",  # warm horizon glow (rare; constants)
    "gold":      "#e8cd86",  # cream starlight (warnings, strings-alt)
    "cream":     "#f2dda0",  # bright yellow
    "mint":      "#84ddb2",  # frost green (strings, success)
    "spring":    "#a4ebc8",  # bright green
}

# --------------------------------------------------------------------------
# Light variant ("Cirno Day"): the same fairy at high noon over fresh snow.
# Pale icy paper, deep-navy ink, and the accents darkened just enough to clear
# AA on a light field while keeping the same identity.
# --------------------------------------------------------------------------
LIGHT = {
    "name": "Cirno Day",
    "appearance": "light",
    "crust":     "#c3d2e6",
    "mantle":    "#d7e3f1",
    "base":      "#eef4fb",  # snow-paper background
    "surface0":  "#e2ebf6",
    "surface1":  "#d2deee",
    "surface2":  "#bccde4",
    "overlay0":  "#90a3c0",
    "overlay1":  "#7388a8",
    "overlay2":  "#5d7295",
    "text":      "#16233d",  # midnight ink
    "subtext1":  "#283955",
    "subtext0":  "#3c4d6c",
    "comment":   "#6c7f9f",
    "ice":       "#0c6f93",  # primary, darkened for light bg
    "frost":     "#0d7193",
    "cyan":      "#0c7799",
    "teal":      "#0c7d74",
    "sky":       "#2d6fc4",
    "blue":      "#2f5fcf",
    "sapphire":  "#11688f",
    "periwinkle":"#5163b8",
    "mauve":     "#8a4fc0",
    "ribbon":    "#c4243f",  # the bow
    "flare":     "#a81049",
    "peach":     "#9e4f17",
    "gold":      "#835f08",  # dark gold so it reads on white
    "cream":     "#6f5000",
    "mint":      "#0f7e51",
    "spring":    "#0c7e50",
}

# --------------------------------------------------------------------------
# ANSI 16 mapping, shared by every terminal port so all of them agree.
# cyan(6) is deliberately the signature ice; red(1) is the ribbon.
# --------------------------------------------------------------------------
def ansi(p):
    return {
        "black":          p["surface0"], "bright_black":   p["overlay0"],
        "red":            p["ribbon"],   "bright_red":     p["flare"],
        "green":          p["mint"],     "bright_green":   p["spring"],
        "yellow":         p["gold"],     "bright_yellow":  p["cream"],
        "blue":           p["blue"],     "bright_blue":    p["sky"],
        "magenta":        p["mauve"],    "bright_magenta": p["periwinkle"],
        "cyan":           p["ice"],      "bright_cyan":    p["frost"],
        "white":          p["subtext1"], "bright_white":   p["text"],
    }

# --------------------------------------------------------------------------
# Semantic roles: how the palette maps onto syntax, shared by all editors.
# --------------------------------------------------------------------------
def roles(p):
    return {
        "bg":            p["base"],
        "bg_dim":        p["mantle"],
        "bg_float":      p["crust"],
        "cursor_line":   p["surface0"],
        "selection":     p["surface1"],
        "fg":            p["text"],
        "fg_dim":        p["subtext0"],
        "comment":       p["comment"],
        "keyword":       p["mauve"],
        "function":      p["ice"],
        "type":          p["gold"],
        "string":        p["mint"],
        "number":        p["peach"],
        "constant":      p["peach"],
        "operator":      p["sky"],
        "variable":      p["text"],
        "property":      p["sky"],
        "parameter":     p["periwinkle"],
        "tag":           p["ribbon"],
        "attribute":     p["gold"],
        "punctuation":   p["subtext0"],
        "preproc":       p["teal"],
        "link":          p["sapphire"],
        "error":         p["ribbon"],
        "warning":       p["gold"],
        "info":          p["sky"],
        "hint":          p["teal"],
        "ok":            p["mint"],
        "added":         p["mint"],
        "changed":       p["gold"],
        "removed":       p["ribbon"],
    }

# --------------------------------------------------------------------------
# WCAG contrast validation.
# --------------------------------------------------------------------------
def _lin(c):
    c /= 255.0
    return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4
def _lum(h):
    h = h.lstrip("#")
    r, g, b = (int(h[i:i+2], 16) for i in (0, 2, 4))
    return 0.2126*_lin(r) + 0.7152*_lin(g) + 0.0722*_lin(b)
def contrast(fg, bg):
    a, b = _lum(fg), _lum(bg)
    hi, lo = max(a, b), min(a, b)
    return (hi + 0.05) / (lo + 0.05)

ACCENTS = ["ice","frost","cyan","teal","sky","blue","sapphire","periwinkle",
           "mauve","ribbon","flare","peach","gold","cream","mint","spring",
           "text","subtext1","subtext0","comment"]

def validate(p):
    bg = p["base"]
    worst, fails = 99.0, []
    for k in ACCENTS:
        c = contrast(p[k], bg)
        worst = min(worst, c)
        # comments only need AA-large (3.0); real text needs AA (4.5)
        floor = 3.0 if k == "comment" else 4.5
        if c < floor:
            fails.append(f"{k} {p[k]} {c:.2f} < {floor}")
    return worst, fails

def build():
    out = {
        "$schema": "https://json-schema.org/draft-07/schema#",
        "meta": {
            "name": "Cirno",
            "description": "An ice-fairy theme in midnight navy, starlight blue, "
                           "ice-cyan, and a single red ribbon. From the Touhou "
                           "character Cirno; colours sampled from the wallpaper.",
            "author": "justin@justin.vc",
            "url": "https://github.com/brickfrog/cirno",
            "license": "MIT",
        },
        "variants": {"dark": DARK, "light": LIGHT},
        "ansi": {"dark": ansi(DARK), "light": ansi(LIGHT)},
        "roles": {"dark": roles(DARK), "light": roles(LIGHT)},
    }
    return out

if __name__ == "__main__":
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    data = build()
    dest = os.path.join(root, "palette", "cirno.json")
    with open(dest, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")

    print(f"wrote {os.path.relpath(dest, root)}")
    ok = True
    for name, p in (("dark", DARK), ("light", LIGHT)):
        worst, fails = validate(p)
        status = "OK " if not fails else "FAIL"
        print(f"  [{status}] {p['name']:10s} ({name}): worst accent contrast "
              f"vs base = {worst:.2f}:1")
        for fl in fails:
            ok = False
            print(f"         ! {fl}")
    sys.exit(0 if ok else 1)
