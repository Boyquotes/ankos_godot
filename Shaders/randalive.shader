shader_type canvas_item;
render_mode blend_disabled, unshaded;

// black opaque
uniform vec4 alive = vec4(0,0,0,1);
// black transparent
uniform vec4 dead = vec4(0,0,0,0);

// Random number generator.
float rand(vec2 p) {
	// e^pi (Gelfond's constant)
	// 2^sqrt(2) (Gelfond–Schneider constant)
	vec2 K1 = vec2( 23.14069263277926, 2.665144142690225 );
	return fract(cos(dot(p,K1)) * 12345.6789); // ver3
}

void fragment(){
	vec2 coords = UV - mod(UV, TEXTURE_PIXEL_SIZE);
	if (rand(coords) > 0.5){
		COLOR = dead;
	} else {
		COLOR = alive;
	}
}