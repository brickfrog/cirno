# The Cirno palette

> Cirno is the ice fairy of the Touhou Project — brash, a little dim, and
> unmistakably *blue*. The palette is pulled straight from the wallpaper in this
> repo: a midnight starfield with a chibi Cirno in the corner. Four sampled
> colours anchor everything else.

![Cirno palette — dark](../assets/palette-dark.png)
![Cirno palette — light](../assets/palette-light.png)

## Anchors (sampled from `wallpaper/cirno.jpeg`)

| role | hex | where it comes from |
|------|-----|---------------------|
| ice (brand) | `#21b3dc` → `#7ad6f0` | Cirno's eyes — lifted for contrast on dark |
| ribbon (accent) | `#6d1b32` → `#ec5a72` | her bow — the one warm note, brightened |
| starlight | `#ccf3ff` → `#d4e4f5` | the stars; softened into the foreground |
| sky | `#11235a` | the dominant night-sky blue; the background hue |

`palette/cirno.json` is the **single source of truth**. Regenerate and
re-validate it any time with:

```sh
python3 scripts/build_palette.py   # writes cirno.json, checks WCAG AA
python3 scripts/swatches.py        # re-renders the preview images
```

## Design notes — the color theory

**One cool base, one warm accent.** The whole theme lives in the blue half of
the wheel (hues ~190–230°). To keep it from going flat and monochrome, a single
complementary warm — the red ribbon (~350°) — does all the "stop / error /
attention" work. Because it's the *only* warm in the field, it reads instantly
without ever needing to be loud. Mint (~150°) and gold (~45°) fill the remaining
syntactic roles with just enough hue separation to stay legible.

**Desaturated, low-luminance background.** The sampled sky (`#11235a`) is too
saturated and bright to stare at for hours, so the actual editor background sits
darker and cooler (`#0e1525`, ~12% luminance). The vivid sky blue is demoted to
a *surface/selection* colour, where its energy is welcome.

**Accents tuned to contrast, not vibes.** Every accent was checked against the
background it actually renders on. On dark, all clear **WCAG AA (4.5:1)** as
foreground text — most clear AAA. The lone exception is `comment`, deliberately
parked at AA-large (~3.8:1) so it recedes without becoming unreadable. The light
variant ("Cirno Day") darkens every accent until it clears AA on snow-paper.

**ANSI stays usable.** Cyan (6) is the signature ice; red (1) is the ribbon.
The other twelve are spaced far enough in hue that a 16-colour TUI never
confuses green for cyan or blue for magenta — a real risk for an all-blue theme.

## Backgrounds & surfaces (dark)

| token | hex | use |
|-------|-----|-----|
| `crust` | `#070c18` | window border, deepest wells |
| `mantle` | `#0a1120` | sidebars, inactive panels, status bar |
| `base` | `#0e1525` | **main editor / terminal background** |
| `surface0` | `#16203a` | current line, subtle panels |
| `surface1` | `#1f2c4a` | selection, borders |
| `surface2` | `#2b3c60` | active selection, scrollbar |
| `overlay0–2` | `#3d5277` · `#536b91` · `#6a82a8` | gutter, faint UI, legible UI text |

## Foreground (dark)

| token | hex | use |
|-------|-----|-----|
| `text` | `#d4e4f5` | main text |
| `subtext1` / `subtext0` | `#bdcfe6` · `#a3b6d2` | secondary text, punctuation |
| `comment` | `#5f7299` | comments (muted, italic) |

## Accents (dark)

| token | hex | named for | typical syntax role |
|-------|-----|-----------|---------------------|
| `ice` | `#7ad6f0` | her eyes | **functions, links, cursor, primary UI** |
| `frost` | `#ace6f7` | frost | bright cyan, special chars |
| `cyan` | `#4cc6ea` | — | deeper ice |
| `teal` | `#5fccc6` | frost on glass | builtins, macros, escapes, namespaces |
| `sky` | `#6fb2ee` | the daytime sky | operators, properties, info |
| `blue` | `#5b90e4` | her dress | ANSI blue |
| `sapphire` | `#3aa9dd` | — | links / URLs |
| `periwinkle` | `#9fb6f2` | dusty horizon | parameters |
| `mauve` | `#b78ee2` | frost violet | **keywords, storage** |
| `ribbon` | `#ec5a72` | her bow | **errors, tags, the warm pop** |
| `flare` | `#f4849a` | — | bright red |
| `peach` | `#eca06a` | horizon glow | numbers, constants |
| `gold` | `#e8cd86` | starlight cream | **types, warnings, attributes** |
| `cream` | `#f2dda0` | — | bright yellow |
| `mint` | `#84ddb2` | frost-on-leaves | **strings, additions, success** |
| `spring` | `#a4ebc8` | — | bright green |

## Semantic role map

The same role map drives every editor port (`roles` in `cirno.json`):

| role | colour | · | role | colour |
|------|--------|---|------|--------|
| keyword | `mauve` | · | string | `mint` |
| function | `ice` | · | number / constant | `peach` |
| type / class | `gold` | · | operator | `sky` |
| property | `sky` | · | parameter | `periwinkle` |
| tag | `ribbon` | · | attribute | `gold` |
| comment | `comment` | · | builtin / macro | `teal` |
| punctuation | `subtext0` | · | link | `sapphire` |
| error | `ribbon` | · | warning | `gold` |
| info | `sky` | · | hint | `teal` |
| added | `mint` | · | removed | `ribbon` |
| changed | `gold` | · | cursor | `ice` |
