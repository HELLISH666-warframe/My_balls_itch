function create() {
	boyfriend.alpha = 0;
	defaultCamZoom += 0.2;
}

function update(elapsed:Float) {
	camHUD.x = FlxMath.lerp(camHUD.x, 0, 0.2 / (60 / Options.framerate));
	camHUD.y = FlxMath.lerp(camHUD.y, 0, 0.2 / (60 / Options.framerate));
}

function beatHit(curBeat:Int) {
	if(curBeat>=0){
	for (i=>cam in [camHUD, camGame]) {
		//FlxTween.globalManager.completeTweensOf(portrait);
		FlxTween.cancelTweensOf(cam);
		var offset = 1;
		cam.angle = curBeat % 2 == 0 ? -3 + (offset * 0.5) : 3 - (offset * 0.5);
		cam.zoom += 0.05;
		camHUD.x = curBeat % 2 == 0 ? 10 - (20 * offset) : -10 + (20 * offset);
		camHUD.y += 10 - (20 * offset);
		FlxTween.tween(cam, {angle: 0}, Conductor.crochet / 1000, {ease: FlxEase.circOut});
	}
	for (i in 0...4){
		for (strumLine in strumLines){
		FlxTween.globalManager.completeTweensOf(strumLine);
		strumLine.members[i].y+=25;
		FlxTween.tween(strumLine.members[i], {y: strumLine.members[i].y-25}, 0.3, {ease: FlxEase.quartOut});}
	}
	}
}

/*function beatHit() {
for (i=>cam in [camHUD, camGame]) {
	FlxTween.cancelTweensOf(cam);
	var offset = 1;
	cam.angle = curBeat % 2 == 0 ? -3 + (offset * 0.5) : 3 - (offset * 0.5);
	cam.zoom += 0.05;
	camHUD.x = curBeat % 2 == 0 ? 10 - (20 * offset) : -10 + (20 * offset);
	FlxTween.tween(cam, {angle: 0}, Conductor.crochet / 1000, {ease: FlxEase.circOut});
	}
}*/