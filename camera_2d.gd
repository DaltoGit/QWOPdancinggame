extends Camera2D


func _on_feet_movement_finished(midpoint, premidpoint, running, dist) -> void:
	if premidpoint.y*8<position.y: position.y=midpoint.y*8
	return
