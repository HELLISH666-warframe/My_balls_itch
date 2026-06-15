import flixel.addons.effects.FlxTrail;
importScript("data/scripts/bloodbleed-shit");
var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); 
function postCreate() {
	insert(members.indexOf(dad)-1, evilTrail).color = FlxColor.RED;
	for (i in cpuStrums.members) i.noteAngle=0;
	SCREWYOU = true;
}
function stepHit(curStep:Int) {
    iconP2.alpha = (2-(health)-0.25)/2+0.2;
    iconP1.alpha = (health-0.25)/2+0.2;
    switch (curStep) {
        case 1|518|540: defaultCamZoom = 0.9;
        case 253: defaultCamZoom = 1.2;
		case 258: windowmovebath = cameramoveblood = true;
		for (i in 0...4)FlxTween.tween(cpuStrums.members[i],{x: cpuStrums.members[i].x + 1250, angle: cpuStrums.members[i].angle + 359},1,{ease: FlxEase.linear});
		for (i in 0...4)FlxTween.tween(playerStrums.members[i],{x: playerStrums.members[i].x - 300},1, {ease: FlxEase.linear});
        case 409|575: defaultCamZoom = 1.1;
        case 413|528: defaultCamZoom = 0.95;    
        case 513|639|1039: defaultCamZoom = 0.85;
        case 535: defaultCamZoom = 1;
        case 582: defaultCamZoom = 1.05;
        case 592: defaultCamZoom = 0.98;
        case 599: defaultCamZoom = 1.15;
        case 768: defaultCamZoom = 1.1;
        FlxTween.tween(stage.getSprite("firebg"), {alpha: 1}, 1, {ease: FlxEase.quadInOut});
		windowmovebath = cameramoveblood = true;
		case 1056: windowmovebath = false;
	}
	if (curStep >= 254 && curStep <= 518) {
		if (fx.alpha < 0.6) fx.alpha += 0.05;            
		if (curStep == 256) {
			FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 1.5, {ease: FlxEase.quadIn, 
				onComplete: function(twn:FlxTween) {
					FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, {type: FlxTween.LOOPING});
				}} 
			);
		}
		FlxG.camera.shake(0.01, 0.1);
		camHUD.shake(0.001, 0.15);
	} else if (curStep >= 768 && curStep <= 1040) {
		if (fx.alpha > 0) fx.alpha -= 0.05;
		if (curStep == 768) {
			FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.75, {ease: FlxEase.quadIn, 
				onComplete: function(twn:FlxTween) {
					FlxTween.angle(stage.getSprite("satan"), 0, 359.99, 0.35, {type: FlxTween.LOOPING});
				}} 
			);
		}
		FlxG.camera.shake(0.015, 0.1);
		camHUD.shake(0.0015, 0.15);
	} else {
		if (curStep == 519 || curStep == 1041)
			FlxTween.cancelTweensOf(stage.getSprite("satan"));
			if (stage.getSprite("satan").angle != 0) FlxTween.angle(stage.getSprite("satan"), stage.getSprite("satan").angle, 359.99, 0.5, {ease: FlxEase.quadIn});
			if (fx.alpha > 0.3) fx.alpha -= 0.05;
		}
	Estatic.alpha = (((2-health)/3)+0.2);
	if (curStep == 518) {
		FlxTween.cancelTweensOf(FlxG.camera);
		FlxTween.cancelTweensOf(camHUD);
		FlxTween.tween(camHUD, {angle: Math.floor(camHUD.angle/360)*360+360}, 3, {ease: FlxEase.circOut});
		FlxTween.tween(FlxG.camera, {angle: Math.floor(FlxG.camera.angle/360)*360+360}, 3, {ease: FlxEase.circOut});
		windowmovebath = cameramoveblood = false;
	}
}
//I hate how the transforamtueidsghdbf shit looks with this timeing
function onDadHit(e) if (curStep >= 498 && curStep <= 512) e.cancelAnim();