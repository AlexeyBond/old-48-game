extends 'res://growth_point.tres.gd';

func is_alive():
	return true

var direction

func can_grow():
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	direction = Vector2(horizontal, vertical).normalized()
	
	return direction.length_squared() > 0.5

func get_direction():
	return direction


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
