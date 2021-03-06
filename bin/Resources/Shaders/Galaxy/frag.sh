uniform vec2 iResolution;
uniform float iGlobalTime;

void main()
{
	vec2 uv = (gl_FragCoord.xy / iResolution) - .5;
	float t = iGlobalTime * .1 + ((.25 + .05 * sin(iGlobalTime * .1))/(length(uv.xy) + .07)) * 2.2;
	float si = sin(t);
	float co = cos(t);

	float v1, v2, v3;
	v1 = v2 = v3 = 0.0;
	
	float s = 0.0;
	for (int i = 0; i < 50; i++)
	{
		vec3 p = s * vec3(uv, 0.0);

		p.xy = vec2(p.x*co + p.y*si, p.x*-si + p.y*co);

		p += vec3(.22, .3, s - 1.5 - sin(iGlobalTime * .13) * .1);
		for (int i = 0; i < 8; i++)	p = abs(p) / dot(p,p) - 0.659;
		v1 += dot(p,p) * .0015 * (1.8 + sin(length(uv.xy * 13.0) + .5  - iGlobalTime * .2));
		v2 += dot(p,p) * .0013 * (1.5 + sin(length(uv.xy * 14.5) + 1.2 - iGlobalTime * .3));
		v3 += length(p.xy*10.) * .0003;
		s  += .035;
	}
	
	float len = length(uv);
	v1 *= smoothstep(.7, .0, len);
	v2 *= smoothstep(.5, .0, len);
	v3 *= smoothstep(.9, .0, len);
	
	vec3 col = vec3( v3 * (1.5 + sin(iGlobalTime * .2) * .4),
					(v1 + v3) * .3,
					 v2) + smoothstep(0.2, .0, len) * .85 + smoothstep(.0, .6, v3) * .3;

	gl_FragColor=vec4(min(pow(abs(col), vec3(1.2)), 1.0), 1.0);
}