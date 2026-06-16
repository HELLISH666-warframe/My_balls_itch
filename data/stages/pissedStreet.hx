function postCreate() {
	fog.screenCenter();
	fog.camera = camHUD;
	remove(fog);
}