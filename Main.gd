extends Node

@export var enemy_scene: PackedScene
@export var min_enemy_speed = 50.0
@export var max_enemy_speed = 200.0
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$EnemyTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("enemies", "queue_free")
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
	
	add_child(enemy)
