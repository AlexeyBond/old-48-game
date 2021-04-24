extends 'res://growth_point.tres.gd';

func is_alive():
	return true

var direction

func can_grow():
	var horizontal = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vertical = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	direction = Vector2(horizontal, vertical)
	
	var res = direction.length_squared() > 0.5

	return res

func get_direction():
	return direction.normalized()

func _process(delta):
	var active = abs(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	) + abs(
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	);

	print('v =', $AudioStreamPlayer2D.volume_db)
	print (direction)
	if active > 0:
		$AudioStreamPlayer2D.volume_db = min(
			$AudioStreamPlayer2D.volume_db + delta * 20, 19
		)
	else:
		$AudioStreamPlayer2D.volume_db = max(
			$AudioStreamPlayer2D.volume_db - min(delta * 20, 0.5), -40
		)
	print('v`=', $AudioStreamPlayer2D.volume_db, ' ', $AudioStreamPlayer2D.volume_db - min(delta * 20, 0.5))
