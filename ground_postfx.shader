shader_type canvas_item;

render_mode skip_vertex_transform;

uniform vec4 ground_color1: hint_color;
uniform vec4 ground_color2: hint_color;
uniform vec4 ground_color3: hint_color;
uniform vec4 root_color1: hint_color;

uniform sampler2D noise;

varying vec2 nc;

uniform vec2 screen_size;
uniform vec2 screen_offset;

void vertex() {
	// Recovering world coordinates of the fragment. Some fucking magic goes here. Don't touch.
	nc = 0.5 * (inverse(WORLD_MATRIX) * vec4(screen_offset, 0, 1)).xy / screen_size + UV;
    VERTEX = UV * screen_size;
}

void fragment() {
	vec4 sample = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 n = texture(noise, nc);
	float root = sample.r;
	
	vec4 g = ground_color1;

	vec4 r = root_color1;

	float thr = 0.5;

	COLOR = n + mix(g, r, smoothstep(thr - 0.1, thr + 0.1, root));
	COLOR *= vec4(vec3(0.5), 1);
}
