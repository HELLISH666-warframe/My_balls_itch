import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
var rain = new CustomShader("rain");
var time:Float = 0;
var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); 
function postCreate() iconP1.setIcon('oldbf');

function update(elapsed:Float){time += elapsed;
	rain.iTime = time;
}

function stepHit(curStep:Int) {
	iconP2.alpha = (2-(health)-0.25)/2+0.2;
	iconP1.alpha = (health-0.25)/2+0.2;
	switch(curStep) {
		case 1:
		FlxTween.tween(healthBar, {alpha: 0}, 0.3, {ease: FlxEase.circOut});
		FlxTween.tween(healthBarBG, {alpha: 0}, 0.3, {ease: FlxEase.circOut});
		case 256: defaultCamZoom = 1;
		case 288: defaultCamZoom = 0.65;
		if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);
		rain.zoom = 40;
		rain.raindropLength = 0.1;
		rain.opacity = 0.25;
		}
		evilTrail.color = FlxColor.RED;
		insert(members.indexOf(dad)-1, evilTrail);
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxTween.tween(stage.getSprite("firebg"), {alpha: 1}, 1, {ease: FlxEase.circOut});
		FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, {type: FlxTween.LOOPING});
		case 544: defaultCamZoom = 0.8;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxTween.tween(stage.getSprite("firebg"), {alpha: 0}, 1, {ease: FlxEase.circOut});
		FlxTween.cancelTweensOf(stage.getSprite("satan"));
		FlxTween.angle(stage.getSprite("satan"), 0, stage.getSprite("satan").angle+359.99, 3, {ease: FlxEase.circOut});
		rain.opacity=0;
		case 864: defaultCamZoom = 0.9;
		case 896: defaultCamZoom = 1;
		case 912: defaultCamZoom = 1.05;
		case 928: /*missval = false;*/
		defaultCamZoom = 0.65;
		rain.raindropLength=0.08;
		rain.opacity=0.25;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxTween.tween(stage.getSprite("firebg"), {alpha: 1}, 1, {ease: FlxEase.circOut});
		FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, {type: FlxTween.LOOPING});
		case 992: defaultCamZoom = 0.9;
		case 1056: defaultCamZoom = 0.65;
		case 1184: defaultCamZoom = 0.8;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		/*missval = true;*/
		if (FlxG.save.data.rain) FlxG.camera.removeShader(rain);
		FlxTween.tween(stage.getSprite("firebg"), {alpha: 0}, 1, {ease: FlxEase.circOut});
		FlxTween.cancelTweensOf(stage.getSprite("satan"));
		FlxTween.angle(stage.getSprite("satan"), 0, stage.getSprite("satan").angle+359.99, 3, {ease: FlxEase.circOut});
	}
}