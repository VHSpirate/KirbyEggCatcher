shader_type canvas_item;

uniform sampler2D mask_texture : hint_default_black;
uniform vec3 blend_color1 : source_color; // Color for the first blend mode (Hue)
uniform vec3 blend_color2 : source_color; // Color for the second blend mode (Subtract)


vec3 subtract(vec3 base, vec3 blend) {
    return max(base - blend, 0.0);
}

vec3 rgb2hsl(vec3 c) {
    float max = max(max(c.r, c.g), c.b);
    float min = min(min(c.r, c.g), c.b);
    vec3 hsl = vec3(0.0, 0.0, (max + min) / 2.0);

    if (max == min) {
        hsl.r = hsl.g = 0.0;
    } else {
        float d = max - min;
        hsl.g = (hsl.b > 0.5) ? d / (2.0 - max - min) : d / (max + min);
        if (max == c.r) {
            hsl.r = (c.g - c.b) / d + (c.g < c.b ? 6.0 : 0.0);
        } else if (max == c.g) {
            hsl.r = (c.b - c.r) / d + 2.0;
        } else {
            hsl.r = (c.r - c.g) / d + 4.0;
        }
        hsl.r /= 6.0;
    }
    return hsl;
}

float hue2rgb(float p, float q, float t) {
    if (t < 0.0) t += 1.0;
    if (t > 1.0) t -= 1.0;
    if (t < 1.0/6.0) return p + (q - p) * 6.0 * t;
    if (t < 1.0/2.0) return q;
    if (t < 2.0/3.0) return p + (q - p) * (2.0/3.0 - t) * 6.0;
    return p;
}

vec3 hsl2rgb(vec3 hsl) {
    vec3 rgb;
    if (hsl.y == 0.0) {
        rgb = vec3(hsl.z);
    } else {
        float q = hsl.z < 0.5 ? hsl.z * (1.0 + hsl.y) : hsl.z + hsl.y - hsl.z * hsl.y;
        float p = 2.0 * hsl.z - q;
        rgb.r = hue2rgb(p, q, hsl.x + 1.0/3.0);
        rgb.g = hue2rgb(p, q, hsl.x);
        rgb.b = hue2rgb(p, q, hsl.x - 1.0/3.0);
    }
    return rgb;
}

vec3 hueBlend(vec3 base, vec3 blend) {
    vec3 baseHSL = rgb2hsl(base);
    vec3 blendHSL = rgb2hsl(blend);
    return hsl2rgb(vec3(blendHSL.r, baseHSL.g, baseHSL.b));
}



void fragment() {
    // Sample the mask texture
    vec4 mask = texture(mask_texture, SCREEN_UV);

    // Apply the Subtract blend mode
    vec3 after_subtract_blend = subtract(COLOR.rgb, blend_color2);

    // Apply the Hue blend mode
    vec3 after_hue_blend = hueBlend(after_subtract_blend, blend_color1);

    // Blend based on the mask's red channel
    COLOR.rgb = mix(COLOR.rgb, after_hue_blend, mask.r);
}


