shader_type canvas_item;
render_mode blend_disabled, unshaded;

// black opaque
uniform vec4 alive = vec4(0,0,0,1);
// black transparent
uniform vec4 dead = vec4(0,0,0,0);

// Random number generator.
float rand(vec2 coords) {
	return fract(sin(dot(coords, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	vec2 coords = UV - mod(UV, TEXTURE_PIXEL_SIZE);
	if (rand(coords) > 0.5){
		COLOR = alive;
	} else {
		COLOR = dead;
	}
}