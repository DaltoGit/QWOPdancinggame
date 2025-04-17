extends Camera2D


func _on_feet_movement_finished(midpoint, premidpoint, distance) -> void:
	if premidpoint.y<position.y: position.y=midpoint.y
	return
