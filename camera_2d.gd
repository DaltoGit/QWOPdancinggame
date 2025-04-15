extends Camera2D

func _on_feet_move_camera(midpoint) -> void:
	position.y=midpoint.y
	return
