extends Label

func _ready():
	text="points: 0"

func _on_feet_movement_finished(midpoint, premidpoint, running, dist) -> void:
	text="points: "+str(int(-dist))
