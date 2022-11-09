extends Node2D

var screenSize:Vector2
export var spawnTrajectoryCount:int = 4
export var spawnTrajectoryGap:int = 15
export var spawnTrajectoryOffset:int = 60

var obstacle = preload("res://Obstacle1.tscn")
var player = preload("res://Player.tscn")
var deadFrog = preload("res://DeadFrog.tscn")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



func getSpawnLocation(index) -> Vector2:
	var spawnX:int = screenSize.x
	if index % 2 == 1:
		spawnX = 0
	var loc:Vector2 = Vector2(spawnX, spawnTrajectoryOffset + index * spawnTrajectoryGap)
	return loc
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport().size
	respawnPlayer()
	


func respawnPlayer():
	var playerLocX:int = screenSize.x /2
	var playerLocY:int = spawnTrajectoryOffset + (spawnTrajectoryGap * spawnTrajectoryCount)
	var spawnLocation:Vector2 = Vector2(playerLocX, playerLocY)
	var instance = player.instance()
	instance.position = spawnLocation
	add_child(instance)
	instance.connect("playerDied", self, "onPlayerDied")
	
func onPlayerDied():
	var instance = deadFrog.instance()
	#instance.position = position
	add_child(instance)
	respawnPlayer()
	
func _draw():
	for i in range(spawnTrajectoryCount):
		var from:Vector2 = getSpawnLocation(i)
		var to:Vector2 = from
		to.x = screenSize.x / 2
		draw_line(from, to, Color.aqua)
	#draw_line

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	var spawnIndex:int = randi() % spawnTrajectoryCount
	var spawnLocation:Vector2 = getSpawnLocation(spawnIndex)
	var instance = obstacle.instance()
	instance.position = spawnLocation
	add_child(instance)
	var dir:bool = spawnLocation.x == 0
	instance.init(not dir)
