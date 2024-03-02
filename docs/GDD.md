# Executive Summary

The player must defend their possition, limited to moving vertically and shooting straight ahead. Increasing numbers of enemies come from the other side of the screen, shooting toward the player. The player must survive as long as possible, scoring points by defeating enemies. Powerups can give the player a temporary edge.

## Game Concept

The player defends against an endless stream of enemies, gradually increasing in difficulty.

## Genre

Arcade survival, like Galaga or Space Invaders.

## Target Audience

HackUSU judges & my beautiful wife

## Project Scope

The project is for a 24-hour hackathon, so the scope is limited. The MVP for this project is to have the following prioritized list of items implemented:

- [x] Player movement
- [x] Enemy movement
- [x] Player attack (projectile shooting)
- [x] Enemy attack (projectile shooting)
- [x] Enemy Spawning
- [x] Projectile Collision
	- [x] Projectile Enemy collision
	- [x] Projectile Player collision
	- [x] Projectile Powerup collision
- [x] Score
- [x] Game Over
- [x] Restart
- [x] Main Menu
- [x] Powerups & Powerup spawning
- [ ] Player collision
	- [x] Player and Enemy head-on (left-right) collision
	- [ ] Player and Enemy side (up-down) collision
	- [x] Player and Powerup collision

The above items were completed faster than I anticipated. Here is the next list of things to do:
	
- [ ] Particle Effects
	- [x] Player Defeat
	- [x] Enemy Defeat
	- [x] Powerup Collected
	- [ ] Powerup applied to player
	- [x] Powerup lost
	- [ ] Enemy leaves screen
	- [ ] Player projectile leaves screen
- [ ] Sound Effects
	- [ ] Player Defeat
	- [ ] Enemy Defeat
	- [ ] Enemy Shoot
	- [ ] Player Shoot
	- [ ] Powerup collected
	- [ ] Powerup applied to player
	- [ ] Powerup lost
	- [ ] Menu Button Selected
- [ ] Background Audio
	- [ ] Menu
	- [ ] Gameplay

# Gameplay


## Objectives

Survive as long as possible to score as high as possible.

## Game Progressions

Enemies and Powerups spawn at a linear increasing rate.

There are no waves or levels, a la Halo Reach's final level "Lone Wolf"

## User Interface

The main menu simply presents the player with a "Play!" button to start the game.
When the player is defeated, a game over screen appears above the running game. The player is presented with their score and prompted to restart the game.

# Mechanics


## Player Movement

The player can move vertically at a fixed rate using "W" and "S" or "Up" and "Down". Player movement speed is increased when a powerup is active.

## Player Shooting

The player can shoot by pressing the space bar. The player can hold the spacebar for the "maximum" fire rate, or they can rapidly press the spacebar for more precision. The player can shoot as fast as they can press the spacebar. When a powerup is active, the held fire rate is doubled. 

## Enemy Movement

Enemies are given a fixed momentum in the x direction when they spawn. This value will be randomized within reason. 

Enemies are also given a random y momentum when they spawn with a wider range of possible values. When an enemy collides with the top or bottom of the screen, they "bounce" (-y momentum)

Ideally, though likely not part of a MVP, enemies' y momentum will "target" the player when they are near the left side of the screen, though this should not be 100% accurate. In other words, as enemies get further to the left of the screen, they should veer toward the player.

## Enemy Shooting

Enemies will fire a burst of 3 projectiles at reasonably random intervals, with a minimum cooldown and maximum delay. The enemy will fire in the general direction of the player with the following rules

- When the enemy and player have roughly the same y value, within 15% of the height of the game, the enemy will fire straight ahaid (projectile y momentum = 0)
- When the enemy is above the player by greater than 15% the height of the game (enemy y < player y - 0.15*height), then the enemy will shoot slightly down (projectile y momentum > 0)
- When the enemy is below the player by greater than 15% the height of the game (enemy y > player y + 0.15*height), then the enemy will shoot slightly up (projectile y momentum < 0)


## Enemy Spawning

Enemies will spawn slowly at first, but the spawn rate will linearly increase by a set interval. 

For example, enemies may initially spawn at a rate of 0.5 per second with the rate increasing by 0.5 per second every 10 seconds (reaching 10 per second after 195 seconds or ~3 minutes)

## Player Defeat

The player is "hit" when they collide with an enemy projectile or when a left-right collision with an enemy occurs.

When the player has an active powerup and is hit, the powerup goes away.

If the player is hit and has no active powerup, the player is defeated (See [Game Over](#game-over)).

When the player is defeated, a particle effect is created, the player entity is removed, and the game transitions to the game over state.

## Enemy Defeat

An enemy is "hit" when they collide with a player's projectile or when an up-down collision with the player occurs.

When an enemy is hit, they are defeated. When they are defeated, a particle effect is created, the enemy entity is removed, and the player's score is increased.

## Powerups

Powerups spawn with 1/10 the frequency of enemies. When a powerup collides with a player projectile or collides with the player, the player is given the powerup's effects.

Powerup effects do not stack, only one at a time.

The powerup has the following effects

- Double player movement speed
- Double player held key fire rate
- Allow player to be hit without defeat (See [Player Defeat](#player-defeat))

The powerup's effect dissapears after 5 seconds.

To show that a powerup is active, the player's asset changes in some way that is TBD.

## Game Over

Whe the player is defeated, the game is over. Alongside events described in the [Player Defeat Sction](#player-defeat), the following happens

- Enemies and powerups stop spawning.
- The score is locked in and cannot change.
- A UI appears that:
	- Shows the user their final score and congradulates them.
	- Prompts the player to restart the game with the "R" key. See [User Interface](#user-interface)

## Score

The score is increased when an enemy is defeated and when a powerup is collected.

- When an enemy is defeated, the score increases by 15
- When a powerup is collected, the score increases by 20

The score cannot be changed in the game over state. When the game is restarted, either by doing so from the game over state or from the menu, the score is set to 0.

# Assets


## Sprites

The following entities need sprites

- Player
- Enemy
- Powerup
- Player Projectile
- Enemy Projectile
- [Particle Effects](#particle-effects)

These sprites will be created as pixel art.

## Particle Effects

The following events create particle effects. Unique particle assets should be used for each event.

- Player Defeat
- Enemy Defeat
- Powerup collision
- Powerup aquired
- Powerup lost

## Audio

For the MVP, no audio is necessary. In an ideal product, the following events would have unique sound effects

- Player defeat
- Enemy Defeat
- Powerup aquired
- Powerup lost
- Starting and restaring the game
- Score milestones.

Sound effects can be found [here](https://mixkit.co/free-sound-effects/arcade/) and [here](https://pixabay.com/sound-effects/search/arcade/)
