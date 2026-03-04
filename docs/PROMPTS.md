# PROMPTS.md (GenAI Asset Replacement)

This document records the prompts + iterations used to generate the final assets for the Bubble Bobble clone replacement.

## Tool / Model Used
- Tool: ChatGPT Image Generation (OpenAI ImageGen / DALL·E via ChatGPT)
- Version: Not shown in UI (unknown)
- Date range: 2026-03-04 (America/Toronto)
- Seeds/settings: Not provided by the tool (N/A)

---

## Asset: Player Character (Idle / Front View)
- Prompt (verbatim):
  "generate me the following image:
  2D pixel art game character, cute sci-fi creature hero, original design, simple readable silhouette, transparent background, front view, consistent proportions, 32x32 or 48x48 sprite, no text, no logos"
- Iterations: 1
- Seeds/settings: N/A
- Notes:
  - Character style established (cute sci-fi hero, readable silhouette).
  - Transparent background worked.

---

## Asset: Player Run Cycle (4-frame spritesheet)
- Prompt v1 (verbatim):
  "based on this character, give me this:
  4-frame run cycle spritesheet, frames aligned, consistent character size, transparent background, pixel art"
- Result issues:
  - Frames were identical / no real run animation.
- Iteration v2 (feedback):
  "these 4 tiles are identical. they should create a running animation. redo this so that it loops correctly and the character actually runs"
- Iterations total: 2 (requested redo once)
- Seeds/settings: N/A
- Notes:
  - Common GenAI problem: animation frames inconsistent or duplicated.
  - Required manual review + potential cleanup (align frames, ensure consistent bounding box).

---

## Asset: Enemy Robot (Side View)
- Prompt v1 (verbatim):
  "make:
  2D pixel art enemy robot, original design, readable silhouette, transparent background, no logos, side view"
- Result issues:
  - Background was not truly transparent (checker/gradient look).
- Iteration v2 (feedback):
  "make the background transparent"
- Iterations total: 2
- Seeds/settings: N/A
- Notes:
  - Transparency control is inconsistent; may require manual alpha cleanup in Photoshop.
  - Ensure Godot import settings preserve crisp pixel edges.

---

## Asset: Sci-fi Cave Tileset (16x16 tiles)
- Prompt v1 (verbatim):
  "make:
  pixel art tile, sci-fi cave theme, 16x16 tiles, seamless edges, includes solid block tile and a few decorative variants, consistent palette, no text"
- Result issues:
  - Background not truly transparent.
- Iteration v2 (feedback):
  "make the background transparent"
- Result issues (after):
  - Still not delivered as a true 16x16-per-tile sprite sheet; required manual slicing/downscaling.
- Iterations total: 2
- Seeds/settings: N/A
- Notes:
  - GenAI often outputs “tileset-looking art” rather than a strict pixel-grid tilesheet.
  - Manual step needed: downscale with Nearest Neighbor + slice to 16x16 in Godot/Photoshop.

---

## Asset: Evil Bubble (semi-transparent interior)
- Prompt (verbatim):
  "give me a semi-transparent bubble, transparent background, evil. the inside should be semi transparent (alpha of ~0.3)"
- Iterations: 1
- Seeds/settings: N/A
- Notes:
  - Transparency/alpha target (~0.3) may need manual adjustment to match gameplay readability.