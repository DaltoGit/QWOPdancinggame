extends Node2D

const mSpeed: float=50.0
const fSpeed: float=1.2
const fallDistance: float=50.0

var feet=[null, null]
var currentFoot: int=0

func _ready() -> void:
	feet=[get_node("left"), get_node("right")]
	return

func _process(delta):
	var movement: Vector2=Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_accept"):
		currentFoot=int(not currentFoot)
	feet[0].velocity=Vector2(0,0)
	feet[1].velocity=Vector2(0,0)
	feet[currentFoot].velocity+=movement*mSpeed
	var feetposvector: Vector2=feet[0].position-feet[1].position
	if feetposvector.length_squared()>fallDistance**2: print("you lost!")
	feet[0].velocity+=feetposvector*fSpeed
	feet[1].velocity+=(-feetposvector)*fSpeed
	feet[0].move_and_slide()
	feet[1].move_and_slide()
	return
