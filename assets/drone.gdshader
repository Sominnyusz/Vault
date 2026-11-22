shader_type canvas_item;

uniform vec3 flash_color : source_color = vec3(1.0, 1.0, 1.0);
uniform bool active = false;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	
	if (active) {
		// FLASH
		COLOR = vec4(flash_color, original_color.a * COLOR.a);
	} else {
		// NORMAL
		vec4 final_color = original_color * COLOR;
		final_color.rgb = pow(final_color.rgb, vec3(1.0 / 2.2));
		COLOR = final_color;
	}
}