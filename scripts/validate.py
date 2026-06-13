#!/usr/bin/env python3
"""
validate.py — sanity-check every theme file in the repo.

Parses all structured formats (TOML / JSON / JSONC / tmTheme / YAML), balances
CSS/rasi braces, and confirms every hex used is a real Cirno palette colour (or
a small allowlist of intentional tints). Exits non-zero on any failure so it can
gate CI.
"""
import glob, json, os, re, sys, tomllib, plistlib, collections

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(ROOT)
ok = True

def check(label, fn):
    global ok
    try:
        fn(); print(f"  ok   {label}")
    except Exception as e:
        ok = False; print(f"  FAIL {label}: {e}")

print("structured formats:")
for f in sorted(glob.glob("themes/**/*.toml", recursive=True)):
    check(f, lambda f=f: tomllib.load(open(f, "rb")))
for f in sorted(glob.glob("themes/**/*.json", recursive=True)) + ["palette/cirno.json"]:
    check(f, lambda f=f: json.load(open(f)))
for f in sorted(glob.glob("themes/**/*.jsonc", recursive=True)):
    def chk(f=f):
        s = open(f).read()
        s = re.sub(r"/\*.*?\*/", "", s, flags=re.S)
        s = re.sub(r"(^|\s)//[^\n]*", "", s)
        json.loads(s)
    check(f, chk)
for f in sorted(glob.glob("themes/**/*.tmTheme", recursive=True)):
    check(f, lambda f=f: plistlib.load(open(f, "rb")))
try:
    import yaml
    for f in sorted(glob.glob("themes/**/*.yml", recursive=True)):
        check(f, lambda f=f: yaml.safe_load(open(f)))
except ImportError:
    print("  --   (pyyaml not installed; skipping YAML)")
for f in sorted(glob.glob("themes/**/*.css", recursive=True)) + sorted(glob.glob("themes/**/*.rasi", recursive=True)):
    def chk(f=f):
        s = open(f).read()
        assert s.count("{") == s.count("}"), f"brace mismatch {s.count('{')}/{s.count('}')}"
    check(f, chk)

print("\npalette consistency:")
J = json.load(open("palette/cirno.json"))
allowed = set()
for v in ("dark", "light"):
    for hx in J["variants"][v].values():
        if isinstance(hx, str) and hx.startswith("#"):
            allowed.add(hx.lower().lstrip("#"))
# intentional non-token tints (diff backgrounds, MD3 text, urgency washes, doc examples)
allowed |= {
    "08111f", "ffffff", "000000", "131b2e", "1b2740", "233151", "224a64",
    "bfe4f0", "e8eff8", "dde7f3", "2a1622", "5a2230", "102a20", "2f6a4d",
    "2b1722", "4a2330", "dbe7f6", "f6dde2", "f3ecd5", "2a2418", "0e2030",
    "04070f", "ff5577",
}
five = re.compile(r"#([0-9a-fA-F]{5})(?![0-9a-fA-F])")
bad = collections.defaultdict(set)
for f in glob.glob("themes/**/*", recursive=True):
    if not os.path.isfile(f) or f.endswith((".png", ".jpeg", ".jpg", ".md")):
        continue
    try:
        txt = open(f, encoding="utf-8").read()
    except Exception:
        continue
    for m in five.finditer(txt):
        bad[f].add("5-digit:" + m.group(0))
    # only flag hex that is explicitly colour-prefixed (#rrggbb) to avoid matching
    # identifiers/UUIDs; alpha forms (#rrggbbaa) check their 6-digit base
    for m in re.finditer(r"#([0-9a-fA-F]{6})(?:([0-9a-fA-F]{2}))?(?![0-9a-fA-F])", txt):
        if m.group(1).lower() not in allowed:
            bad[f].add(m.group(1).lower())
if bad:
    ok = False
    for f, v in sorted(bad.items()):
        print(f"  FAIL {f}: {sorted(v)}")
else:
    print("  ok   every #hex is a Cirno colour")

print("\n" + ("ALL CHECKS PASS ❄️" if ok else "FAILURES — see above"))
sys.exit(0 if ok else 1)
