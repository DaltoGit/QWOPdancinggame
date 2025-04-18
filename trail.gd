extends Node2D

var line: Node
var points: Array=[]

func _ready():
	line=get_node("Line2D")
	get_parent().get_parent().movement_finished.connect(movement_finished)

func movement_finished(midpoint, premidpoint, distance):
	pass
