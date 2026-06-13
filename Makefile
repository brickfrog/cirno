.PHONY: all build swatches validate clean

# Regenerate the palette + previews and validate every theme file.
all: build swatches validate

# Rebuild palette/cirno.json from scripts/build_palette.py (asserts WCAG AA).
build:
	python3 scripts/build_palette.py

# Re-render assets/*.png from the canonical palette.
swatches:
	python3 scripts/swatches.py

# Parse every structured theme file + check palette consistency.
validate:
	python3 scripts/validate.py

clean:
	rm -rf scripts/__pycache__
