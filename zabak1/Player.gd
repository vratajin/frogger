extends Area2D

export var jumpDist:float = 100
export var jumpSpeed:float = 50
var jumpAccu:float = 0
var jumping:bool = false
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_node("/root"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	if Input.is_action_pressed("jump"):
		if not jumping:
			jumping = true
			jumpAccu = 0
			$AnimatedSprite.play("jump")
		
	if jumping:
		var jumpDelta = delta * jumpSpeed
		#var jumpDelta = jumpSpeed
		if jumpAccu + jumpDelta >= jumpDist:
			jumpDelta = jumpDist - jumpAccu
			jumping = false
			$AnimatedSprite.play("idle")
		else:
			jumpAccu += jumpDelta
		position.y -= jumpDelta
