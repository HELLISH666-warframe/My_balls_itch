var rain = new CustomShader("rain");
var time:Float = 0;
var funnyDSidesSpin:Bool = false;
function postCreate() if (FlxG.random.int(1, 1000) == 69) iconP2.setIcon('peak-dsides');
function update(elapsed:Float) {		
    if (funnyDSidesSpin) iconP2.angle += 180*elapsed;
    time += elapsed;
	rain.iTime = time;
}
function onDadHit(e) if (funnyDSidesSpin) dad.angle = FlxG.random.int(0,359);
function stepHit(){
	switch(curStep){
		case 768:
		funnyDSidesSpin = true;
		case 1037:
		funnyDSidesSpin = false;
		FlxTween.tween(dad, {angle: Math.floor(dad.angle/360)*360}, 0.8, {ease: FlxEase.expoOut});
		FlxTween.tween(iconP2, {angle: Math.floor(iconP2.angle/360)*360}, 0.8, {ease: FlxEase.expoOut});
		case 1315:
		if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);
			rain.zoom = 35; rain.raindropLength = 0.075; rain.opacity = 0.2;}
		defaultCamZoom += 0.1;
		fxtwo = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
		fxtwo.scale.set(0.75, 0.75);
		fxtwo.updateHitbox();
		fxtwo.antialiasing = true;
		fxtwo.screenCenter();
		fxtwo.alpha = 0.2;
		fxtwo.scrollFactor.set(0,0);
		fxtwo.camera = camHUD;
		add(fxtwo);
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);

		for(i in [stage.getSprite("conall_sky"),stage.getSprite("conall_bgBehind"),
			stage.getSprite("conall_bg"),stage.getSprite("conall_bucket")]) i.destroy();
        for(i in [stage.getSprite("wasted_sky"),stage.getSprite("wasted_bgBehind"),
			stage.getSprite("wasted_bg"),stage.getSprite("wasted_bucket")]) i.visible = true;
	}
}