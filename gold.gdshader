shader_type canvas_item;
render_mode blend_mix;

// Uniforms: User-defined parameters
uniform bool Enabled = false;                // Control to enable or disable the effect
uniform float toggle_duration : hint_range(0.05, 1.0) = 0.5;  // Duration for the toggling effect

void fragment() {
    // Determine the current state of the effect based on elapsed time and toggle duration
    bool isEffectActive = Enabled && mod(TIME, 2.0 * toggle_duration) < toggle_duration;

    // Define the custom color constant
    vec4 customColor = vec4(0.956863, 0.580392, 0.239216, 1.000000);

    // Retrieve the original color of the pixel
    vec4 originalColor = COLOR;

    // Calculate the effect: Divide custom color by the inverse of the original color
    vec3 effectColor = customColor.rgb / (vec3(1.0) - originalColor.rgb);

    // Decide the output color: If the effect is active, use the effect color, otherwise use the original color
    if (isEffectActive) {
        COLOR.rgb = effectColor;
    } else {
        COLOR.rgb = originalColor.rgb;
    }
}
