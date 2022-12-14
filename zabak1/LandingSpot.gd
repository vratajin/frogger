extends ObstacleBase
signal playerLanded

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func onFrogLanded() -> bool:
	$AnimatedSprite.visible = true
	emit_signal("playerLanded")
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

