shader_type canvas_item;

uniform sampler2D gradient:hint_default_black;
uniform float mix_amount = 1.0;
vec4 multiply(vec4 base, vec4 blend){
	return base * blend;
}
vec4 color_burn(vec4 base, vec4 blend){
	return 1.0 - (1.0 - base) / blend;
}

void fragment() {
	vec4 input_color = texture(TEXTURE,UV);
	float grayscale_value = dot(input_color.rgb, vec3(0.299,0.587,0.114));
	//vec3 sampled_color = texture(gradient,vec2(grayscale_value,0.0)).rgb;
	vec3 sampled_color = texture(gradient,vec2(grayscale_value,0.0)*mix_amount).rgb;
	COLOR.rgb =  multiply(input_color,vec4(sampled_color,input_color.a)).rgb;
	COLOR.a = input_color.a;
}


