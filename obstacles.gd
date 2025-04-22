extends Node2D

const obstacleAmount: int=4
const obstacleHeight: int=12
var obstacles=[]
var distance: int=0
var difficulty: int=0

func _ready():
	for i in range(obstacleAmount):
		obstacles.append(load("res://obstacles/" + str(i) + ".tscn"))
	var feet: Node = get_parent().get_node("Feet/Feet")
	feet.movement_finished.connect(on_movement_finished)
	return

func loadobstacle():
	var newobstacle: PackedScene=obstacles[clamp(int(randfn(difficulty,obstacleAmount/2)),0,obstacleAmount-1)]
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

func on_movement_finished(midpoint, premidpoint, run, dis):
	difficulty=int(-dis/400)
	print(difficulty)
	if midpoint.y>premidpoint.y:
		distance+=1
		if distance==obstacleHeight:
			loadobstacle()
			distance=0
		get_node("obstacles").position.y=distance*16
	
	if get_node("obstacles/old/obstacle"):
		if get_node("obstacles/old/obstacle/kill").process_mode==PROCESS_MODE_INHERIT: 
			for i in get_node("obstacles/old/obstacle/kill").get_overlapping_bodies():
				if i.name=="left" or i.name=="right":
					get_parent().get_node("Feet/Feet").die()
