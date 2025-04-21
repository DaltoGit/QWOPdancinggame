extends Label

var points: int

func _ready():
	text="points: 0"

func _on_feet_movement_finished(midpoint, premidpoint, running, dist) -> void:
	points=int(-dist/10)
	text="points: "+str(points)
