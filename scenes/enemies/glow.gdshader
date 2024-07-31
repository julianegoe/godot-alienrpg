shader_type canvas_item;
uniform vec4 target_color: source_color;
uniform vec4 glow_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); 
uniform float glow_intensity: hint_range(0.0, 10.0, 0.1);

void fragment() {
	vec4 pixel = texture(TEXTURE, UV);
	float color_distance = distance(pixel.rgb, target_color.rgb);
	if (color_distance < 0.4) {
		COLOR = pixel * vec4(target_color) * glow_intensity;
	}
}