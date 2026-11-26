# 🐧 Aziz Adventures

**The Explorer Update — v0.2**

A little penguin. A big adventure.

An original 2D platformer for Linux, built with Godot and GDScript. Play offline, collect crystals, explore seven worlds, challenge five guardians, earn trophies and sharpen your speedrun times.

## Features

- Seven distinct stages with secret areas and unique scenery
- Five guardians with different movement and attack patterns
- 16 achievements, including AZIZ THE LEGEND (Platinum)
- Normal and LEGENDARY difficulty
- Cosmetic scarves and Normal-only upgrades earned through play
- Separate personal-best times for each difficulty
- Local saves, keyboard and gamepad support
- Optional sound effects, no music or online services

## Run from source

Use Godot 4.7.2 (the engine version used to develop and test v0.2). Install Godot separately, then run:

```bash
godot --path game
```

Or launch through the supplied script:

```bash
bash play.sh
```

## Controls

| Action | Keyboard | Controller |
|---|---|---|
| Move | A/D or arrow keys | Left stick / D-pad |
| Jump | Space / W / Up | A / Cross |
| Dash | Shift / X | X / Square or R1 |
| Pause | Esc | Start |
| Fullscreen | F11 | — |
| Mute | M | — |

Crystals are banked after clearing a stage. Unlock scarves and abilities in the shop. In LEGENDARY you have one heart, and ability upgrades are disabled. Green guardian cores are vulnerable; orange represents an active shield.

## Test

```bash
godot --headless --path game -- --self-test
```

The automated test checks terrain gaps, movement, enemies, secret paths, guardian attacks, trophy and shop logic, both difficulties, records, and save compatibility. Graphical presentation and physical controllers still require manual play testing.

## Project layout

- `game/project.godot` — engine settings
- `game/game.tscn` — main scene
- `game/game.gd` — game systems, stage data, procedural graphics and effects
- `play.sh` — local launcher

Game progress is stored locally using Godot's user data directory. The Godot engine is a separate dependency and is not included in this repository.
