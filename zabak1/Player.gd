extends Area2D

export var jumpDist:float = 100
export var jumpSpeed:float = 50
var speedActual:float
var distActual:float
var jumpAccu:Vector2
var jumping:bool = false
var collidingObstacle:Node
var sittingOffset:Vector2
var velocity:Vector2
signal playerDied(pos)

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed(5)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(delta)
	
	if not jumping:
		speedActual = jumpSpeed
		distActual = jumpDist
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if Input.is_action_pressed("ui_left"):
			$AnimatedSprite.rotation_degrees = -90
			if collidingObstacle and collidingObstacle.direction == -1:
				speedActual = jumpSpeed + collidingObstacle.speed
				distActual = (speedActual / jumpSpeed) * jumpDist
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.rotation_degrees = 90
			if collidingObstacle and collidingObstacle.direction == 1:
				speedActual = jumpSpeed + collidingObstacle.speed
				distActual = (speedActual / jumpSpeed) * jumpDist
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite.rotation_degrees = 0
		if Input.is_action_pressed("ui_down"):
			$AnimatedSprite.rotation_degrees = 180
	if velocity:
		if not jumping:
			jumping = true
			jumpAccu = Vector2.ZERO
			$AnimatedSprite.play("jump")
			$SoundHop.play()
		
	if jumping:
		var jumpDelta = delta * speedActual * velocity
		if (jumpAccu + jumpDelta).length() >= distActual:
			jumpDelta = (velocity * distActual) - jumpAccu
			jumping = false
			$AnimatedSprite.play("idle")
			if collidingObstacle:
				sittingOffset = position - collidingObstacle.position
			else:
				die(position)
		else:
			jumpAccu += jumpDelta
		position += jumpDelta
	else:
		if collidingObstacle:
			position = collidingObstacle.position + sittingOffset
		


func die(pos: Vector2):
	emit_signal("playerDied",position)
	queue_free()
	
	

func _on_Player_area_entered(area: Area2D) -> void:
	collidingObstacle = area
	print("_on_Player_area_entered")

func _on_Player_area_exited(area: Area2D) -> void:
	if area == collidingObstacle:
		collidingObstacle = null
	print("_on_Player_area_exited")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	die(position)
