# Shooting Shapes

The player defends against an endless stream of enemies, gradually increasing in difficulty.

## Contributors

- Matthew Hill

## How To Play

### Download Executable

Go to the [project releases on GitHub](https://github.com/Potato-Man114/Shooting-Shapes/releases) and download the .exe file associated with the latest release.

### Run w/ Godot Debug Engine

1. Download [Godot 4.2](https://godotengine.org/download/windows/)
1. Clone this repository
1. Open the project in Godot
1. Click the "Run" button in the upper-left corner.

## Other Documentation


[Game Design Document](docs/GDD.md)

[Sources](docs/sources.md), which list software and assets used that were not created by the contributors listed above.

## Lessons Learned

1. This was my first time using Godot and the time was limited, so code organization feel by the wayside. In future Godot projects, I need to make sure that many of my entities have their basic functionality abstracted away so that variations can be created easilty.
    - For example, `Enemy` and `HardEnemy` are very similar, and most of the code is copied from one to the other. Inheritance or Composition would have been a better strategy.