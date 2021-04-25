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
	
var erase_depth = -100

func _process(delta):
	var active = abs(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	) + abs(
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	);

	if active > 0:
		$AudioStreamPlayer2D.volume_db = min(
			$AudioStreamPlayer2D.volume_db + delta * 20, 5
		)
		$Timer.stop()
		$Timer.start(20)
	else:
		$AudioStreamPlayer2D.volume_db = max(
			$AudioStreamPlayer2D.volume_db - min(delta * 20, 0.5), -40
		)
		
	self.min_depth = max(self.min_depth, self.position.y - 1000)
		
	var ed = max(erase_depth, self.min_depth - 1000)
	
	if ed != erase_depth:
		erase_depth = ed
		
		for seg in get_tree().get_nodes_in_group('root_segments'):
			if seg.position.y < erase_depth:
				seg.get_parent().remove_child(seg)


func _on_Timer_timeout():
	get_tree().change_scene("res://main.tscn")
