extends Camera2D

var lFoot=null
var rFoot=null

func _ready() -> void:
	lFoot=get_parent().get_node("left")
	rFoot=get_parent().get_node("right")
	return

func _process(delta):
	var midpoint: Vector2=(lFoot.position+rFoot.position)/2
	
	position=midpoint
	return
