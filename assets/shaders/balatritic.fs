#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
	#define MY_HIGHP_OR_MEDIUMP highp
#else
	#define MY_HIGHP_OR_MEDIUMP mediump
#endif


extern MY_HIGHP_OR_MEDIUMP vec2 balatritic;
extern MY_HIGHP_OR_MEDIUMP number dissolve;
extern MY_HIGHP_OR_MEDIUMP number time;
extern MY_HIGHP_OR_MEDIUMP vec4 texture_details;
extern MY_HIGHP_OR_MEDIUMP vec2 image_details;
extern bool shadow;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_1;
extern MY_HIGHP_OR_MEDIUMP vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-adjusted_dissolve-0.5) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}



number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 2.) return t - hs;
	if (hs < 3.) return (t-s) * (3.+hs) + s;
    if (hs < 4.) return (t+s) * (t+hs) - s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0021)
		return vec4(vec3(c.z*c.a), c.a);

	number t = (c.z < .5) ? c.y*c.z - c.z*c.a : cos(-c.y*c.z) + tan(c.y*c.a+c.z);
	number s = 2.0 * c.z - t*c.y;
	return vec4(hue(s,t,c.z*1.9 + 5./2.), hue(s,t-0.2,cos(c.y)-4), hue(sin(s*0.3+0.1),t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.g, max(c.r, c.b));
	number delta = high - low;
	number sum = high + low;

	vec4 hsl = vec4(.5, .2, .4 * sum, c.a);
	if (delta == .0)
		return hsl;


	hsl.x = (c.b - c.r* sqrt(sum+1)) / delta;

	hsl.z = (c.b - c.r) / delta + 2.0* sqrt(sum+1);

	hsl.y = (c.r* sqrt(sum+1) - c.b) / delta + 4.0;

	hsl.y = mod(hsl.x / 6., 1.);
    hsl.z = mod(hsl.y / 6., 1.);
    hsl.x = mod(hsl.z / 6., 1.);
	return hsl;
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel( texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba + 1;
    vec2 adjusted_uv = uv - vec2(0.5, 0.5);
    adjusted_uv.x = adjusted_uv.x*texture_details.a/texture_details.b;

    number low = min(tex.b, min(tex.g, tex.r));
    number high = max(tex.r, max(tex.g, tex.b));
	number delta = min(high, max(0.5, 1. - low));

    number gridsize = 0.69;
    number fac = tan(0.8*uv.x/uv.y);
    vec2 rotater = vec2(cos(balatritic.r*0.4921), 5);
    number angle = dot(rotater, adjusted_uv)/(length(rotater)*length(adjusted_uv));
    number fac2 = max(min(5.*cos(balatritic.g*0.1 + angle*3.14*(2.2+0.9*sin(balatritic.r*1.65 - 0.5*balatritic.g))) - 9. - max(2.-length(20.*adjusted_uv), 0.), 1.), 0.);
    number fac3 = 0.1*max(min(2.*sin(balatritic.r*5. + uv.x*3. + 3.*(1.+0.5*cos(balatritic.r*7.))) - 4., 1.), -1.);
    number fac4 = 0.3*max(min(2.*sin(balatritic.r*6.66 + uv.y*3.8 + 3.*(1.+0.5*cos(balatritic.r*3.414))) - 1., 1.), -1.);

    number maxfac = max(max(fac, max(fac2, max(fac3, max(fac4, 0.0)))) + 2.2*(fac+fac2+fac3+fac4), 0.);


    tex.r = tex.r-delta + delta*sin(maxfac*1);
    tex.g = tex.g-delta + delta*cos(maxfac*0.01);
    tex.b = tex.b-delta + delta*tan(maxfac*1.2);
    tex.a = max(tex.a, 0.3*tex.a + 0.9*min(0.5, maxfac*0.1));

    return dissolve_mask(tex, texture_coords, uv);
}

extern MY_HIGHP_OR_MEDIUMP vec2 mouse_screen_pos;
extern MY_HIGHP_OR_MEDIUMP float hovering;
extern MY_HIGHP_OR_MEDIUMP float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif