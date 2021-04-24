shader_type canvas_item;
render_mode skip_vertex_transform;

uniform vec4 col1 : hint_color;
uniform vec4 col2 : hint_color;

varying vec2 p;
uniform vec2 xoffsets;


void vertex() {
	p = (WORLD_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
    VERTEX = (EXTRA_MATRIX * (WORLD_MATRIX * vec4(VERTEX, 0.0, 1.0))).xy;
}

void fragment() {
	float o = xoffsets.x + UV.x * xoffsets.y;

	float k1 = sin(o * 0.001 + UV.y * 20.0 * sin(o * 0.0002));
	COLOR = mix(col1, col2, k1);
	
	float ke = (
		sin(o * 0.03) +
		cos(o * 0.032) +
		cos(o * 0.0134543453) +
		(cos(o * 0.231243254542) + cos(o * 0.152432) + cos(o * 0.1111111111) + cos(o * 0.38325)) * 0.25
		)/4.0;
	COLOR.a = step(1.0, (1.0 - UV.y) * 100.0 + ke);
}
