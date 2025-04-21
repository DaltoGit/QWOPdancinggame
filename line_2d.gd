extends Line2D

@export var length := 15
@export var trailspeed := 750
var point := Vector2()
@onready var foot: Node=get_parent().get_parent().get_parent()

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
		
		if foot.velocity.length_squared()>trailspeed**2: add_point(point)
		else: clear_points()

		while get_point_count()>length:
			remove_point(0)
