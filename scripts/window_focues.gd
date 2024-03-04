extends Node

var focused := true

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			focused = false
		NOTIFICATION_APPLICATION_FOCUS_IN:
			focused = true

func input_is_action_pressed(action: StringName) -> bool:
	if focused:
		return Input.is_action_pressed(action)
	return false
	
func input_get_axis(negative_direction: StringName, positive_direction: StringName) -> float:
	if focused:
		return Input.get_axis(negative_direction, positive_direction)
	return false
