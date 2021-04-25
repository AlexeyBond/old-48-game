shader_type canvas_item;

uniform vec4 color1: hint_color;

void fragment() {
	float f = abs(0.5 - UV.x + (UV.y - 1.0) * 0.2 * sin(TIME + UV.y));
	float t = 0.05 * UV.y;

	COLOR = mix(color1, vec4(0), smoothstep(t - 0.04, t, f));
}
