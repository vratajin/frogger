extends Area2D

export var jumpDist:float = 100
export var jumpSpeed:float = 50
var jumpAccu:float = 0
var jumping:bool = false
var collidingObstace:Node
var sittingOffset:Vector2

signal playerDied

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed(5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	if Input.is_action_pressed("jump"):
		if not jumping:
			jumping = true
			jumpAccu = 0
			$AnimatedSprite.play("jump")
			collidingObstace = null
		
	if jumping:
		var jumpDelta = delta * jumpSpeed
		#var jumpDelta = jumpSpeed
		if jumpAccu + jumpDelta >= jumpDist:
			jumpDelta = jumpDist - jumpAccu
			jumping = false
			$AnimatedSprite.play("idle")
			if collidingObstace:
				sittingOffset = position - collidingObstace.position
			else:
				print("player died")
				emit_signal("playerDied")
				queue_free()
		else:
			jumpAccu += jumpDelta
		position.y -= jumpDelta
	else:
		if collidingObstace:
			position = collidingObstace.position + sittingOffset
		


func _on_Player_area_entered(area: Area2D) -> void:
	collidingObstace = area
	print("_on_Player_area_entered")

func _on_Player_area_exited(area: Area2D) -> void:
	print("_on_Player_area_exited")
