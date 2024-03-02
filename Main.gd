extends Node

@export var enemy_scene: PackedScene
@export var enemy_projectile_scene: PackedScene
@export var player_projectile_scene: PackedScene
@export var min_enemy_speed = 50.0
@export var max_enemy_speed = 100.0
@export var enemy_projectile_speed = 150.0
@export var enemy_projectile_y_speed = 20
@export var player_projectile_speed = Vector2(250, 0)

var screen_size
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$EnemyTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("enemy_projectiles", "queue_free")
	score = 0
	$Player.start($PlayerStartPosition.position)
	$EnemyTimer.start()
	$HUD.update_score(score)

func _on_powerup_spawn_timer_timeout():
	#TODO: this
	pass # Replace with function body.


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	
	var enemy_spawn_location = $EnemyPath/PathFollow2D
	enemy_spawn_location.progress_ratio = randf()
	
	enemy.position = enemy_spawn_location.position
	
	var velocity = Vector2(-randf_range(min_enemy_speed, max_enemy_speed), 0.0)
	
	enemy.velocity = velocity
	
	enemy.connect("shoot", enemy_shot)
	
	add_child(enemy)
	
func enemy_shot(x, y):
	var velocity = get_enemy_shot_velocity(x, y)
	var shot = enemy_projectile_scene.instantiate()
	
	shot.position = Vector2(x, y)
	shot.velocity = velocity
	
	add_child(shot)
	
	
func get_enemy_shot_velocity(x, y):
	#TODO: y value
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
	add_child(shot)






