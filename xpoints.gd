extends Label

@onready var plabel=get_parent().get_parent().get_node("alive/Label")

func _process(delta: float) -> void:
	text="You got "+str(plabel.points)+" points"
