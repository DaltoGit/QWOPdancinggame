extends Node2D

const mSpeed: float=10.0
const fSpeed: float=0.00000001
const fallDistance: float=60.0
const friction: float=0.99995

func _input(event):
	if running == false:
		if event.is_action_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://main.tscn")


signal lose
signal movement_finished

var cFoot: bool=false
var midpoint: Vector2
var premidpoint: Vector2
var height: int=0
var distance: float=0.0
var running: bool=true
@export var debug := true

var lFoot: Node
var rFoot: Node

func die():
	running=false
	get_parent().get_node("Camera2D/alive").hide()
	get_parent().get_node("Camera2D/dead").show()

func _ready() -> void:
	lFoot=get_node("left")
	rFoot=get_node("right")
	get_parent().get_node("Camera2D/alive").show()
	get_parent().get_node("Camera2D/dead").hide()
	return

func calculateFriction(vel: Vector2) -> Vector2:
	var vellength=vel.length_squared()
	if vellength<1:
		return Vector2.ZERO
	vellength=sqrt(vellength-1)*friction
	return vel.normalized()*vellength

func collisionstuff(foot: Node):
	for i in foot.get_slide_collision_count():
		var collision=foot.get_slide_collision(i)
		var norm: Vector2=collision.get_normal()
		var tempvec: Vector2
		tempvec.y = norm.x
		tempvec.x = norm.y
		if tempvec.x<0: tempvec.x*=-1
		if tempvec.y<0: tempvec.y*=-1
		foot.velocity*=tempvec

func _process(delta):
	var inputvector: Vector2=Input.get_vector("lLeft", "lRight", "lUp", "lDown")
	if Input.is_action_just_pressed("ui_accept"): cFoot=not cFoot
	
	var feetposvector: Vector2=lFoot.position-rFoot.position
	
	if feetposvector.length_squared()>fallDistance**2 and not debug: die()
	
	var averagespeed: float=(lFoot.velocity.length_squared()+rFoot.velocity.length_squared())
	var lMovement: Vector2=feetposvector*fSpeed*averagespeed
	var rMovement: Vector2=(-feetposvector)*fSpeed*averagespeed
	
	if cFoot: 
		rMovement+=inputvector*mSpeed
		rFoot.get_node("outline").show()
		lFoot.get_node("outline").hide()
	else: 
		lMovement+=inputvector*mSpeed
		rFoot.get_node("outline").hide()
		lFoot.get_node("outline").show()
	lFoot.velocity+=lMovement
	rFoot.velocity+=rMovement
	lFoot.velocity=calculateFriction(lFoot.velocity)
	rFoot.velocity=calculateFriction(rFoot.velocity)
	
	if running:
		lFoot.move_and_slide()
		rFoot.move_and_slide()
		collisionstuff(lFoot)
		collisionstuff(rFoot)
	
	premidpoint=(lFoot.position+rFoot.position)/2
	if premidpoint.y<=-16: 
		height+=1
		lFoot.position.y+=16
		rFoot.position.y+=16
	midpoint=(lFoot.position+rFoot.position)/2
	distance=midpoint.y-height*16
	movement_finished.emit(midpoint, premidpoint, running, distance)
	return
