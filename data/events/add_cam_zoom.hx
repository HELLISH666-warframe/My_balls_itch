function onEvent(_) {
	if (_.event.name == 'add_cam_zoom') {
		FlxG.camera.zoom += Std.parseFloat(_.event.params[0]);
		camHUD.zoom += Std.parseFloat(_.event.params[1]);
	}
}