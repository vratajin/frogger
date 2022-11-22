extends Node2D

var screenSize:Vector2
export var trajectoryCount:int = 4
export var trajectoryGap:int = 15
export var trajectoryOffset:int = 60
export var drawTrajectories:bool = false;
#export var obstacleScenes:PackedScene = []
var obstacleLog1:PackedScene = preload("res://ObstacleLog1.tscn")
var obstacleLily:PackedScene = preload("res://ObstacleWaterlily.tscn")
var player = preload("res://Player.tscn")
var deadFrog = preload("res://DeadFrog.tscn")
var spawnTrajectories = []
var obstacles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport().size
	respawnPlayer()
	for i in range(0, trajectoryCount):
		spawnTrajectories.append([])
	obstacles.append(obstacleLily)
	obstacles.append(obstacleLog1)
	

func getSpawnLocation(index) -> Vector2:
	var spawnX:int = screenSize.x
	if index % 2 == 1:
		spawnX = 0
	var loc:Vector2 = Vector2(spawnX, trajectoryOffset + index * trajectoryGap)
	return loc
	


	
func getSpawnLocInLine(index:int, line: Array) ->Vector2:
	var lastPos: Vector2	= getSpawnLocation(index)
	var spawnLocation:Vector2 = Vector2.INF
	var spawnOffset:int
	if line.size() != 0:
		var obst = line[-1]
		spawnOffset = obst.getHalfLength()
		lastPos = line[-1].position
	if index % 2 == 1:
		if lastPos.x < screenSize.x:
			spawnLocation = lastPos + Vector2(spawnOffset,0)
	else:
		if lastPos.x > 0:
			spawnLocation = lastPos - Vector2(spawnOffset,0)
	return spawnLocation
	
func spawnLoop():
	var index:int = 0
	for trajectory in spawnTrajectories:
		var spawnLocation:Vector2 = getSpawnLocInLine(index, trajectory)
		if spawnLocation != Vector2.INF:
			var obstacle = obstacles[randi() % obstacles.size()-1]
			var instance = obstacle.instance()
			var spawnOffset = Vector2(instance.getHalfLength() + 100,0)
			if index % 2 == 1:
				instance.position = spawnLocation + spawnOffset
				instance.init(1)
			else:
				instance.position = spawnLocation - spawnOffset
				instance.init(0)
			add_child(instance)
			trajectory.append(instance)
		index = index+1
	
	

func respawnPlayer():
	var playerLocX:int = screenSize.x /2
	var playerLocY:int = trajectoryOffset + (trajectoryGap * trajectoryCount)
	var spawnLocation:Vector2 = Vector2(playerLocX, playerLocY)
	var instance = player.instance()
	instance.position = spawnLocation
	add_child(instance)
	instance.connect("playerDied", self, "onPlayerDied")
	
func onPlayerDied(pos):
	var instance = deadFrog.instance()
	instance.position = pos
	add_child(instance)
	respawnPlayer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawnLoop()
	
func _draw():
	if not drawTrajectories:
		return
	for i in range(trajectoryCount):
		var from:Vector2 = getSpawnLocation(i)
		var to:Vector2 = from
		to.x = screenSize.x / 2
		draw_line(from, to, Color.aqua)
