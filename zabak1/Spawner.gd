extends Node2D

var screenSize:Vector2
export var spawnTrajectoryCount:int = 4
export var spawnTrajectoryGap:int = 15

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



func getSpawnLocation(index) -> Vector2:
	var loc:Vector2 = Vector2(screenSize.x, index * spawnTrajectoryGap)
	return loc
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport().size
	print(getSpawnLocation(3))


func _draw():
	for i in range(spawnTrajectoryCount):
		var from:Vector2 = getSpawnLocation(i)
		var to:Vector2 = from
		to.x = 0
		draw_line(from, to, Color.aqua)
	#draw_line

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
