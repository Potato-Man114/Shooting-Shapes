extends Timer

@export var rate_increate_per_second = 0.03
@export var initial_rate_per_second = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	wait_time = 1 / initial_rate_per_second


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_timeout():
	wait_time = 1 / ((1 / wait_time) + rate_increate_per_second)

func set_spawn_rate(rate):
	wait_time = 1 / rate
