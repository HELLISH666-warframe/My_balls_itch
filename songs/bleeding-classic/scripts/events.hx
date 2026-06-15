import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
var bloodshedTrail = null;
function resetTrail() {
	remove(bloodshedTrail);
	bloodshedTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); //nice
	bloodshedTrail.color = FlxColor.RED;
	insert(members.indexOf(dad)-1, bloodshedTrail);
}
function postCreate() {
	iconP1.setIcon('oldbf');
}

function stepHit(curStep:Int) {
	iconP2.alpha = (2-(health)-0.25)/2+0.2;
	iconP1.alpha = (health-0.25)/2+0.2;
	switch (curStep) {
		case 248|760: FlxG.sound.play(Paths.sound('vine'));
		case 256: defaultCamZoom += 0.1;
		case 384: defaultCamZoom += 0.15;
		case 512: defaultCamZoom -= 0.25;
		case 664: defaultCamZoom += 0.3;
		case 672: defaultCamZoom -= 0.3;
		case 768: FlxTween.tween(stage.getSprite("firebg"), {alpha: 1}, 1, {ease: FlxEase.quadInOut});
		defaultCamZoom += 0.1;
		case 832: defaultCamZoom += 0.1;
		case 896: defaultCamZoom += 0.1;
		case 1024: defaultCamZoom += 0.1;
		case 1040: defaultCamZoom -= 0.2;
		case 1168: defaultCamZoom -= 0.1;
		case 1296: defaultCamZoom -= 0.1;
	}
	if (curStep >= 256 && curStep <= 512) {
		if (fx.alpha < 0.6) fx.alpha += 0.05;			
		if (curStep == 256) {
			FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 1.5, { 
				ease: FlxEase.quadIn, 
				onComplete: function(twn:FlxTween) {
					FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, {type: FlxTween.LOOPING});
				}} 
			);
		}
		FlxG.camera.shake(0.01, 0.1);
		camHUD.shake(0.001, 0.15);
	}
	else if (curStep >= 768 && curStep <= 1296) {
		if (fx.alpha > 0) fx.alpha -= 0.05;
		if (curStep == 768) {
			FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, { 
				ease: FlxEase.quadIn, 
				onComplete: function(twn:FlxTween) {
					FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.35, {type: FlxTween.LOOPING});
				}} 
			);
		}
		FlxG.camera.shake(0.015, 0.1);
		camHUD.shake(0.0015, 0.15);
	} else {
		if (curStep == 1297 || curStep == 614)
			FlxTween.cancelTweensOf(stage.getSprite("satan"));
		if (stage.getSprite("satan").angle != 0) FlxTween.angle(stage.getSprite("satan"), stage.getSprite("satan").angle, 359.99, 0.5, {ease: FlxEase.quadIn});
		if (fx.alpha > 0.3) fx.alpha -= 0.05;
	}
}