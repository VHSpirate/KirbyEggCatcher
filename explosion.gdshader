shader_type canvas_item;

uniform float shake_intensity: hint_range(0.0, 0.5) = 0.05;  // Controls how intense the shake is
uniform float shake_speed: hint_range(0.0, 70.0) = 20.0;    // Controls how fast the shake is

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 st = SCREEN_UV;
    
    // Shake based on a sin function
    float xOffset = sin(TIME * shake_speed) * shake_intensity;
    float yOffset = sin(TIME * shake_speed * 0.8) * shake_intensity; // 0.8 to make vertical shake slightly different

    // Offset the UV coordinates
    st.x += xOffset;
    st.y += yOffset;

    COLOR = texture(SCREEN_TEXTURE, st);
}
