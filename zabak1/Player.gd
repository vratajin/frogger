extends Area2D
var isJumping:bool = false
export var speed:float = 20
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		isJumping = true
	
	if isJumping:
		position.y -= speed * delta
