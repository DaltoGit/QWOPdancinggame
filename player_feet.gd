extends Node2D

const mSpeed: float=50.0
const fSpeed: float=1.2
const fallDistance: float=50.0

var lFoot=null
var rFoot=null

func _ready() -> void:
	lFoot=get_node("left")
	rFoot=get_node("right")
	return

func _process(delta):
	var lMovement: Vector2=Input.get_vector("lLeft", "lRight", "lUp", "lDown")
	var rMovement: Vector2=Input.get_vector("rLeft", "rRight", "rUp", "rDown")
	
	var feetposvector: Vector2=lFoot.position-rFoot.position
	if feetposvector.length_squared()>fallDistance**2: print("you lost!")
	
	lFoot.velocity=feetposvector*fSpeed+lMovement*mSpeed
	rFoot.velocity=(-feetposvector)*fSpeed+rMovement*mSpeed
	
	lFoot.move_and_slide()
	rFoot.move_and_slide()
	return
