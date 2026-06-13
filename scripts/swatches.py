#!/usr/bin/env python3
"""Render palette swatch images for the README from palette/cirno.json."""
import json, os
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
J = json.load(open(os.path.join(ROOT, "palette", "cirno.json")))

def font(sz):
    for p in ("/usr/share/fonts/TTF/DejaVuSans.ttf",
              "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
              "/usr/share/fonts/dejavu/DejaVuSans.ttf"):
        if os.path.exists(p):
            return ImageFont.truetype(p, sz)
    return ImageFont.load_default()

def fmono(sz):
    for p in ("/usr/share/fonts/TTF/DejaVuSansMono.ttf",
              "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf",
              "/usr/share/fonts/dejavu/DejaVuSansMono.ttf"):
        if os.path.exists(p):
            return ImageFont.truetype(p, sz)
    return ImageFont.load_default()

def lum(h):
    h = h.lstrip("#"); r, g, b = (int(h[i:i+2], 16) for i in (0, 2, 4))
    return (0.299*r + 0.587*g + 0.114*b) / 255

def ink(bg):
    return "#0a0a0a" if lum(bg) > 0.55 else "#f0f4fa"

ORDER = ["base","mantle","crust","surface0","surface1","surface2","overlay0",
         "overlay1","overlay2","text","subtext1","subtext0","comment",
         "ice","frost","cyan","teal","sky","blue","sapphire","periwinkle",
         "mauve","ribbon","flare","peach","gold","cream","mint","spring"]

def render(variant, path):
    p = J["variants"][variant]
    cols, rows = 5, 6
    cw, ch = 220, 92
    pad = 24
    title_h = 70
    W = cols*cw + pad*2
    H = title_h + rows*ch + pad
    bg = p["base"] if variant == "dark" else p["base"]
    img = Image.new("RGB", (W, H), bg)
    d = ImageDraw.Draw(img)
    fbig, fname, fhex = font(34), font(18), fmono(15)
    d.text((pad, 20), f"Cirno{'' if variant=='dark' else ' Day'}", font=fbig,
           fill=p["ice"])
    sub = "dark — midnight, ice & one red ribbon" if variant == "dark" else "light — fresh snow at high noon"
    d.text((pad+220, 32), sub, font=fname, fill=p["comment"])
    for i, name in enumerate(ORDER):
        c = p[name]
        col, row = i % cols, i // cols
        x = pad + col*cw
        y = title_h + row*ch
        d.rounded_rectangle([x+6, y+6, x+cw-6, y+ch-6], radius=12, fill=c)
        t = ink(c)
        d.text((x+20, y+20), name, font=fname, fill=t)
        d.text((x+20, y+46), c.upper(), font=fhex, fill=t)
    img.save(path)
    print("wrote", os.path.relpath(path, ROOT))

def render_ansi(path):
    """A compact terminal-style swatch of the 16 ANSI colors over both variants."""
    a = J["ansi"]["dark"]
    order = ["black","red","green","yellow","blue","magenta","cyan","white",
             "bright_black","bright_red","bright_green","bright_yellow",
             "bright_blue","bright_magenta","bright_cyan","bright_white"]
    cell = 70; pad = 20
    W = 8*cell + pad*2
    H = 2*cell + pad*2 + 40
    p = J["variants"]["dark"]
    img = Image.new("RGB", (W, H), p["base"])
    d = ImageDraw.Draw(img)
    d.text((pad, 14), "ANSI 16", font=font(22), fill=p["ice"])
    fm = fmono(13)
    for i, k in enumerate(order):
        c = a[k]
        col, row = i % 8, i // 8
        x = pad + col*cell
        y = pad + 36 + row*cell
        d.rounded_rectangle([x+4, y+4, x+cell-4, y+cell-4], radius=8, fill=c)
        d.text((x+10, y+cell-22), str(i), font=fm, fill=ink(c))
    img.save(path)
    print("wrote", os.path.relpath(path, ROOT))

if __name__ == "__main__":
    out = os.path.join(ROOT, "assets")
    os.makedirs(out, exist_ok=True)
    render("dark", os.path.join(out, "palette-dark.png"))
    render("light", os.path.join(out, "palette-light.png"))
    render_ansi(os.path.join(out, "ansi.png"))
