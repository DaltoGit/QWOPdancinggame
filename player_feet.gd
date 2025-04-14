extends Node2D

const mSpeed: float=10.0
const fSpeed: float=0.005
const fallDistance: float=50.0

var cFoot=false

var lFoot=null
var rFoot=null

func _ready() -> void:
	lFoot=get_node("left")
	rFoot=get_node("right")
	return

func _process(delta):
	var inputvector: Vector2=Input.get_vector("lLeft", "lRight", "lUp", "lDown")
	
	var feetposvector: Vector2=lFoot.position-rFoot.position
	if feetposvector.length_squared()>fallDistance**2: print("you lost!")
	
	var lMovement: Vector2=feetposvector*fSpeed
	var rMovement: Vector2=(-feetposvector)*fSpeed
	
	if Input.is_action_just_pressed("ui_accept"): cFoot=not cFoot
	
	if cFoot: rMovement+=inputvector*mSpeed
	else: lMovement+=inputvector*mSpeed
	
	lFoot.velocity+=lMovement
	rFoot.velocity+=rMovement
	
	lFoot.move_and_slide()
	rFoot.move_and_slide()
	return
