
function stepHit(curStep:Int) {
    if (curStep >= 256 && curStep <= 512) {
		var currentBeat:Float = (Conductor.songPosition / 1000)*(Conductor.bpm/60);
		camHUD.angle = 5 * Math.sin((currentBeat/6) * Math.PI);
		FlxG.camera.angle = 2 * Math.sin((currentBeat/6) * Math.PI);
		if (curStep % 8 == 0) {
			for (i in 0...4) { 
				FlxTween.globalManager.completeTweensOf(playerStrums.members[i]);
                playerStrums.members[i].y+=20;
				FlxTween.tween(playerStrums.members[i], {y: 50}, 0.3, {ease: FlxEase.backOut});
			}
		}
	}
    switch (curStep) {
		case 256:stage.getSprite('bgt').visible = true;
		FlxG.camera.flash(FlxColor.WHITE, 1);
        case 512:FlxTween.tween(camHUD, {angle: Math.floor(camHUD.angle/360)*360+360}, 3, {ease: FlxEase.circOut});
		FlxTween.tween(FlxG.camera, {angle: Math.floor(FlxG.camera.angle/360)*360+360}, 3, {ease: FlxEase.circOut});
        case 768:stage.getSprite('bgt').loadGraphic(Paths.image('stages/triad/majin'));
		FlxG.camera.flash(FlxColor.WHITE, 1);
        scripts.get('bgMove').cancel();
        scripts.get('bgMove').start(0.005, function(tmr:FlxTimer) {
		stage.getSprite('bgt').x += 4;
		stage.getSprite('bgt').y += 3;
		tmr.reset(0.005);
	});
	}
}

function onCameraMove(e)
    strumLines.members[curCameraTarget].characters[0].isPlayer == true ? defaultCamZoom = 0.75 : defaultCamZoom = 0.9;