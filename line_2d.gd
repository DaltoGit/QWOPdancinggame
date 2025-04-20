extends Line2D

@export var length := 50
var point := Vector2()

func _on_feet_movement_finished(midpoint, premidpoint, running, dist) -> void:
	
	global_position = Vector2.ZERO
	global_rotation = 0
	
	point=to_local(get_parent().global_position)
	
	if running:
		if midpoint>premidpoint:
			for i in range(get_point_count()):
				var pointpos: Vector2=get_point_position(i)
				pointpos.y+=16
				set_point_position(i,pointpos)

		add_point(point) 

		while get_point_count()>length:
			remove_point(0)
