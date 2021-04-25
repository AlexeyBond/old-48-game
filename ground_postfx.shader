shader_type canvas_item;

render_mode skip_vertex_transform;

uniform vec4 ground_color1: hint_color;
uniform vec4 ground_color2: hint_color;
uniform vec4 ground_color3: hint_color;
uniform vec4 root_color1: hint_color;
uniform vec4 root_color2: hint_color;
uniform vec4 stone_color1: hint_color;
uniform vec4 stone_color2: hint_color;

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
	
	vec4 g = mix(
		ground_color1,
		mix(
			ground_color2,
			ground_color3,
			smoothstep(0.8, 0.9, n.r)
		),
		smoothstep(0.5, 0.6, n.r)
	);

	float thr = 0.1 + 0.4 * pow(abs(sin(TIME * 3.0 - length(vec2(0.5) - UV) * 8.0)), 6);

	vec4 r = mix(root_color1, root_color2, smoothstep(thr + 0.4, thr + 0.5, root));

	COLOR = mix(g, r, smoothstep(thr - 0.1, thr + 0.1, root));
	
	vec4 n2 = texture(noise, nc * 3.0);
	vec4 s = mix(stone_color1, stone_color2, n2.r);
	
	COLOR = mix(COLOR, s, sample.g);
	COLOR *= vec4(vec3(0.5), 1);
}
