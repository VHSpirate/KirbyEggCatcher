shader_type canvas_item;

uniform vec2 inner_center;
uniform vec2 inner_size;

void fragment() {
    vec2 relative_pos = FRAGCOORD.xy - inner_center;
    if (abs(relative_pos.x) > inner_size.x / 2.0 || abs(relative_pos.y) > inner_size.y / 2.0) {
        discard; // Discard the pixel if it's outside the inner screen
    }
}
