extends Node2D

const obstacleAmount: int=4
const obstacleHeight: int=12
var feet: Node
var obstacles=[]
var distance: int=0
var difficulty: int=0

func _ready():
	for i in range(obstacleAmount):
		obstacles.append(load("res://obstacles/" + str(i) + ".tscn"))
	feet = get_parent().get_node("Feet")
	feet.movement_finished.connect(on_movement_finished)
	return

func loadobstacle():
	var newobstacle: PackedScene=obstacles[clamp(int(randfn(difficulty,obstacleAmount/4)),0,obstacleAmount-1)]
	var oldobstacle: Node=get_node("obstacles/old/obstacle")
	if oldobstacle:
		get_node("obstacles/old").remove_child(oldobstacle)
	var movobstacle: Node=get_node("obstacles/new/obstacle")
	if movobstacle:
		get_node("obstacles/new").remove_child(movobstacle)
		get_node("obstacles/old").add_child(movobstacle)
	var obstacle=newobstacle.instantiate()
	obstacle.name="obstacle"
	get_node("obstacles/new").add_child(obstacle)

func on_movement_finished(midpoint, premidpoint, dis):
	if midpoint.y>premidpoint.y:
		distance+=1
		if distance==obstacleHeight:
			loadobstacle()
			distance=0
		get_node("obstacles").position.y=distance*16
