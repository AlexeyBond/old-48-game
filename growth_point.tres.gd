extends Node2D

var max_turn = 1.0
var prev_segment = null

var min_length = 10
var max_length = 30

var child_probability = 0.2

var segment_thickness = 0.5

var growth_speed = 1000;

var min_depth = -30

func get_child_segment_thickness():
	return segment_thickness * 0.9

func get_direction():
	return Vector2(0, 1)
	
func is_alive():
	return true

func child_gp_capacity():
	return 10

func can_grow():
	return true

var Segment = load('res://segment.tscn')
var AutoGrowthPoint = load('res://auto_growth_point.tscn')

func try_spawn_child():
	if rand_range(0, 1) > child_probability:
		return
	var a = max_turn + rand_range(0, max_turn * 2.0)
	if rand_range(0, 1) > 0.5:
		a = -a
	var d = get_direction().rotated(a)
	
	var cgp = AutoGrowthPoint.instance()
	cgp.position = position
	
	cgp.direction = d
	cgp.segments = child_gp_capacity()
	cgp.segment_thickness = get_child_segment_thickness()

	get_parent().add_child(cgp)
	
	cgp.connect('on_take_water', self, 'emit_take_water');

signal on_take_water;

func emit_take_water():
	emit_signal("on_take_water")

func grow():
	var direction = get_direction().rotated(rand_range(-max_turn, max_turn)).normalized()
	var distance = rand_range(min_length, max_length);
	
	var next_pos = position + direction * distance

	if next_pos.y < min_depth:
		return

	var res = get_world_2d().direct_space_state.intersect_ray(
		position,
		next_pos
	);

	if 'position' in res:
		var cp = res['position']
		
		var d = cp.distance_to(position)

		if d < (min_length / 2):
			return

		next_pos = position + direction * d * 0.9
		
	if 'collider' in res:
		var cs: Node2D = res['collider'].get_parent()
		if cs.is_in_group('water'):
			var taking = cs.take()
			if taking:
				emit_take_water()

	var segment = Segment.instance();
	get_parent().add_child(segment);
	
	segment.setup(position, next_pos, segment_thickness);
	
	prev_segment = segment;
	
	position = next_pos

func _process(delta):
	if not prev_segment:
		if can_grow():
			grow()
		return

	var growth = min(
		1.0,
		prev_segment.growth + delta * growth_speed / prev_segment.length
	)
	prev_segment.set_growth(growth)

	if growth >= 1.0:
		if is_alive():
			if can_grow():
				try_spawn_child()
				grow()
		else:
			get_parent().remove_child(self)
