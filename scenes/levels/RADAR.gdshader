shader_type canvas_item;


void fragment() {
	float radius = 1.0;
	vec2 center = vec2(0.5,0.5);
	vec2 coords = (UV-center);
	float dist = length(coords);
	float circ_radii = radius/float(2);
	
	if (dist > circ_radii){
		discard;
	}
}

