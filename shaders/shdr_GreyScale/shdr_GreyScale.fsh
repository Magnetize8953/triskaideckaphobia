varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 texColour = texture2D( gm_BaseTexture, v_vTexcoord );
    float grey = dot(texColour.rgb, vec3(0.299, 0.587, 0.114));
    gl_FragColor = vec4(grey, grey, grey, texColour.a);
}