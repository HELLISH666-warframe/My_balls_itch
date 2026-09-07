var mosaic = new CustomShader('mosaic');

function create(){
	camGame.addShader(mosaic);
	camHUD.addShader(mosaic);
	mosaic.uBlocksize=4;
}