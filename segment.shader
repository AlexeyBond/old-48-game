shader_type canvas_item;

render_mode blend_add;

void fragment() {
	float k = COLOR.r;
	float t = 2.0 / COLOR.g;

	float ds = length((vec2(0.5, 0.25) - UV) * vec2(1, 2));
	float de = length((vec2(0.5, 0.75) - UV) * vec2(1, 2));
	
	float dl0 = abs(UV.x - 0.5);
	float dl = (UV.y < 0.25 || UV.y > 0.75) ? min(ds, de) : dl0;
	
	float d = mix(ds / k, dl, k) * t;

	COLOR = vec4(max(0.0, (1.0 - d)) - max(0, 1.0 - ds * t), 0,0,1);
}
