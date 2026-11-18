shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	
	// If active is true, show pure white. If false, show the normal texture colors.
	vec3 final_rgb = active ? vec3(1.0) : tex_color.rgb;
	
	// Combine the RGB with the texture's alpha, and multiply by COLOR.a 
	// so your fade-out animation (transparency) still works!
	COLOR = vec4(final_rgb, tex_color.a * COLOR.a);
}