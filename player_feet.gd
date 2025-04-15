extends Node2D

const mSpeed: float=10.0
const fSpeed: float=0.035
const fallDistance: float=60.0

signal lose
signal move_camera

var cFoot: bool=false
var midpoint: Vector2
var height: int=0
var distance: int=0

var lFoot: Node
var rFoot: Node

func _ready() -> void:
	lFoot=get_node("left")
	rFoot=get_node("right")
	return

func _process(delta):
	var inputvector: Vector2=Input.get_vector("lLeft", "lRight", "lUp", "lDown")
	if Input.is_action_just_pressed("ui_accept"): cFoot=not cFoot
	
	var feetposvector: Vector2=lFoot.position-rFoot.position
	if feetposvector.length_squared()>fallDistance**2: lose.emit()
	
	var lMovement: Vector2=feetposvector*fSpeed
	var rMovement: Vector2=(-feetposvector)*fSpeed
	
	if cFoot: rMovement+=inputvector*mSpeed
	else: lMovement+=inputvector*mSpeed
	lFoot.velocity+=lMovement
	rFoot.velocity+=rMovement
	
	lFoot.move_and_slide()
	rFoot.move_and_slide()
	
	midpoint=(lFoot.position+rFoot.position)/2
	if midpoint.y<=-16: 
		height+=1
		lFoot.position.y+=16
		rFoot.position.y+=16
	elif midpoint.y>0:
		height-=1
		lFoot.position.y-=16
		rFoot.position.y-=16
	midpoint=(lFoot.position+rFoot.position)/2
	move_camera.emit(midpoint)
	return
