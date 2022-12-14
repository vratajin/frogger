extends Node2D
var lives:int = 3

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func canRespawnPlayer() -> bool:
	return lives > 0

func onPlayerDied():
	lives -= 1
	if lives < 0:
		lives = 0
	print(lives)
	$LivesValue.text = str(lives)
	#$HUD.updateScore(lives)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LivesValue.text = str(lives)
	#$HUD.updateScore(lives)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
