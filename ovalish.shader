shader_type canvas_item;

uniform vec4 color: hint_color;

void fragment() {
	vec2 dd = UV - vec2(0.5);
	float d = dot(dd,dd);
	float a = atan(UV.x - 0.5, UV.y - 0.5);
	float thr = 0.25 + 0.01 * cos(a * 31.0) + 0.02 * sin(a * 11.0);
	COLOR = vec4(color.rgb, 1.0 - smoothstep(thr - 0.01, thr, d));
}
