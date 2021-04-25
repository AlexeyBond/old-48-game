shader_type canvas_item;

uniform vec4 color: hint_color;

void fragment() {
	vec2 dd = UV - vec2(0.5);
	float d = dot(dd,dd);
	COLOR = mix(color, vec4(0), smoothstep(0.2, 0.25, d));
}
