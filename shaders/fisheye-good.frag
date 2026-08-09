#pragma header
uniform float MAX_POWER; // negative : anti fish eye. positive = fisheye

//Inspired by http://stackoverflow.com/questions/6030814/add-fisheye-effect-to-images-at-runtime-using-opengl-es
void main()//Drag mouse over rendering area
{

	vec2 uv = openfl_TextureCoordv;
	uv.y -= 0.5;
	uv.y /= 1 + pow(abs(openfl_TextureCoordv.y * 2 - 1), 2);
	uv.y += 0.5;
	gl_FragColor = flixel_texture2D(bitmap, uv);
}
