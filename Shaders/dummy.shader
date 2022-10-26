shader_type canvas_item;
render_mode blend_disabled, unshaded;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	COLOR.r += 0.01;
	COLOR;
}