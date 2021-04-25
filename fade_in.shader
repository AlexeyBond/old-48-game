shader_type canvas_item;

uniform float t;

void fragment() {
	COLOR.a = mix(1.0, 0.0, smoothstep(0.5, 1.0, t));
}
