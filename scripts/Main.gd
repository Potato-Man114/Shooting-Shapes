extends Node

@export var enemy_scene: PackedScene
@export var hard_enemy_scene: PackedScene
@export var enemy_projectile_scene: PackedScene
@export var player_projectile_scene: PackedScene
@export var powerup_scene: PackedScene
@export var min_enemy_speed = 50.0
@export var max_enemy_speed = 100.0
@export var powerup_speed = 75
@export var enemy_projectile_speed = 150.0
@export var enemy_projectile_y_speed = 20
@export var player_projectile_speed = Vector2(250, 0)
@export var enemy_spawn_change = 50
@export var hard_enemy_spawn_percentage = 15

var screen_size
var score = 0
var playing =  false
var game_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size
	$Player.process_input = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (playing):
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = !get_tree().paused
			if get_tree().paused:
				$HUD.show_pause_menu()
			else:
				$HUD.hide_pause_menu()

func game_over():
	Input.start_joy_vibration(0, 0.2, 0.5, 0.2)
	playing = false
	$EnemyTimer.stop()
	$PowerupSpawnTimer.stop()
	$HUD.show_game_over(game_time)
	$GameTimer.stop()

func new_game():
	playing = true
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("enemy_projectiles", "queue_free")
	get_tree().call_group("player_projectiles", "queue_free")
	get_tree().call_group("powerups", "queue_free")
	score = 0
	game_time = 0.0
	$GameTimer.start()
	$Player.start($PlayerStartPosition.position)
	$EnemyTimer.set_spawn_rate($EnemyTimer.initial_rate_per_second)
	$EnemyTimer.start()
	$PowerupSpawnTimer.set_spawn_rate($PowerupSpawnTimer.initial_rate_per_second)
	$PowerupSpawnTimer.start()
	$HUD.update_score(score)

func _on_powerup_spawn_timer_timeout():
	var powerup = powerup_scene.instantiate()
	var powerup_spawn_location = $EnemyPath/PathFollow2D
	powerup_spawn_location.progress_ratio = randf()
	powerup.position = powerup_spawn_location.position
	powerup.velocity = Vector2(-powerup_speed, 0.0)
	powerup.connect("collected", powerup_collected)
	
	add_child(powerup)
	
	
func _on_enemy_timer_timeout():
	# 50% chance of actually spawning an enemy
	if (randi_range(0, 100) <= enemy_spawn_change):
		return
	var enemy = null
	var y_velocity = null
	if (randi_range(0, 100) <= hard_enemy_spawn_percentage):
		enemy = hard_enemy_scene.instantiate()
		y_velocity = -50 if randi_range(0, 100) % 2 == 0 else 50
	else:
		enemy = enemy_scene.instantiate()
		y_velocity = 0
	
	var enemy_spawn_location = $EnemyPath/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.position = enemy_spawn_location.position
	var velocity = Vector2(-randf_range(min_enemy_speed, max_enemy_speed), y_velocity)
	enemy.velocity = velocity
	
	enemy.connect("shoot", enemy_shot)
	enemy.connect("defeat", update_score)
	enemy.connect("leave_screen", update_score)
	add_child(enemy)
	
func enemy_shot(x, y):
	var velocity = get_enemy_shot_velocity(x, y)
	var shot = enemy_projectile_scene.instantiate()
	
	shot.position = Vector2(x, y)
	shot.velocity = velocity
	
	add_child(shot)
	
	
func get_enemy_shot_velocity(_x, y):
	var y_velocity = 0
	if (y < $Player.position.y - screen_size.y * 0.05):
		y_velocity = enemy_projectile_y_speed
	elif (y > $Player.position.y + screen_size.y * 0.05):
		y_velocity = -enemy_projectile_y_speed
	return Vector2(-enemy_projectile_speed, y_velocity);

func _on_player_shoot(x, y):
	var shot = player_projectile_scene.instantiate()
	shot.position = Vector2(x, y)
	shot.velocity = player_projectile_speed
	shot.connect("leave_screen", player_shot_leave_screen)
	add_child(shot)

func player_shot_leave_screen(score_change):
	update_score(score_change)
	
func update_score(score_change):
	if (!playing):
		return
	score += score_change
	score = 0 if score < 0 else score
	$HUD.update_score(score)

func powerup_collected(score_change):
	$Player.powerup()
	update_score(score_change)


func _on_game_timer_timeout():
	game_time += $GameTimer.wait_time
