# Jackdaw-style RPG Video Content Kit

A faceless YouTube content package modelled on **[@JackdawJPG](https://www.youtube.com/@JackdawJPG)** —
calm, British, lore-obsessed RPG video-essays ("where modern RPGs get lovingly overanalysed").
All scripts are evergreen *opinion/analysis* (no unverified news), and all generated visuals are
*original* space-opera imagery — never real game footage or trademarked characters.

## Contents

| File | What it is |
|------|------------|
| `channel-analysis.md` | Breakdown of the reference channel: pillars, scenarios, hook formula, tone |
| `5-minute-essay-script.md` | Full 5-min long-form video: 20-shot script, voiceover, per-shot AI prompts |
| `shorts-manifest.md` | 5 vertical YouTube Shorts: titles, VO scripts, and the Higgsfield job → file map |
| `assemble/teaser_assemble.sh` | One-command ffmpeg build for the 16:9 teaser |
| `assemble/shorts_assemble.sh` | One-command ffmpeg build for the 5 vertical Shorts |

## Production stack

- **Visuals:** Higgsfield → text-to-video.
  - *Seedance 2.0* (1080p) is the highest quality but requires a **Pro/Ultimate plan** (~9 credits/sec).
  - *Kling 3.0 Turbo* (1080p) works on the starter plan and is far cheaper (**~2 credits/sec**) — used for the teaser + Shorts.
- **Narration:** Higgsfield `text2speech_v2` (ElevenLabs engine), preset voice **"Alistair"** (British male). ~1 credit/line.
- **Music:** not available via Higgsfield (speech-only). Add a royalty-free bed at edit time.
- **Assembly:** ffmpeg (the `assemble/` scripts). Final stitch must run where the Higgsfield CDN is reachable.

## Rough credit economics

| Deliverable | Model | Approx credits |
|---|---|---|
| 5-min essay (~20 clips) on Kling Turbo | kling3_0_turbo | ~600 |
| 5-min essay (~20 clips) on Seedance 2.0 | seedance_2_0 | ~2,700 (needs paid plan) |
| One ~16–24s teaser | kling3_0_turbo | ~50 |
| One vertical Short (2 clips + VO) | kling3_0_turbo | ~33 |

## Workflow to ship

1. Generate clips + voiceovers in Higgsfield (prompts/scripts are in the markdown files).
2. Download the assets from your Higgsfield account.
3. Rename per the manifest, run the matching `assemble/*.sh`.
4. Drop a music bed under the voiceover, upload.
