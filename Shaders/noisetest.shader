shader_type canvas_item;
render_mode blend_disabled, unshaded;

const vec4 black = vec4(0, 0, 0, 1);
const vec4 white = vec4(1, 1, 1, 1);

// Random number generator.
float rand(vec2 coords) {
	return fract(sin(dot(coords, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	// Randomize the color a bit, to make it more interesting.
	vec4 here = texture(TEXTURE, UV);
	vec2 coords = UV - mod(UV, TEXTURE_PIXEL_SIZE);
	COLOR = mix(COLOR, here, rand(coords) * 0.99);
}