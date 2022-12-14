extends "res://ObstacleBase.gd"

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randTime:float = rand_range(6,14)
	$Timer.wait_time = randTime
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	if isSolid:
		$AnimatedSprite.play('submerge')
	else:
		$AnimatedSprite.play('surface')


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "submerge":
		isSolid = false
		$Timer.wait_time = 2
		$Timer.start()
	if $AnimatedSprite.animation == "surface":
		$AnimatedSprite.animation = "swim"
		isSolid = true
		$Timer.stop()
