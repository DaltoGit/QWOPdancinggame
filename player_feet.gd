extends Node2D

const speed: float=50.0

var feet=[null, null]
var currentFoot: int=0

func _ready() -> void:
	feet=[get_node("left"), get_node("right")]
	return

func _process(delta):
	var movement: Vector2=Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_accept"):
		currentFoot=int(not currentFoot)
	feet[currentFoot].position+=movement*delta*speed
	return
