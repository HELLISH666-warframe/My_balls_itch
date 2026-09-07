function beatHit(curBeat:Int) {
	switch(curBeat){
		case 88: defaultCamZoom = 1;
		case 92: defaultCamZoom = 1.2;
		case 96: FlxG.camera.flash(FlxColor.WHITE, 0.2);
		case 100: defaultCamZoom = 1.5;
		case 112: defaultCamZoom = 0.9;
	}
	if (curBeat >= 96 && curBeat < 100) dad.playAnim('um',true);
	else if (curBeat >= 100 && curBeat < 112) dad.playAnim('err',true);
}