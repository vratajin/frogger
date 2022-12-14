class_name ObstacleBase
extends Area2D

export var speed:int = 20
var direction:int = 1
var isSolid:bool = true

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
func init(dir):
	if dir:
		direction = -1
		rotation_degrees = 180

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func isObstacle() -> bool:
	return true

func getHalfLength() ->int:
	return $CollisionShape2D.shape.extents.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * delta * speed

func onFrogLanded() -> bool:
	return false

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
