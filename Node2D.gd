extends 'res://growth_point.tres.gd'

var segments = 10
var direction = Vector2(0, 1)

func is_alive():
	segment_thickness = 0.9 * segment_thickness
	segments = segments - 1
	return segments >= 0

func get_direction():
	return direction

func child_gp_capacity():
	return min(1, segments)
