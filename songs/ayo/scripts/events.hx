import openfl.display.BlendMode;
var time:Float = 0;
var fxtwo = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
var rain = new CustomShader("rain");

function update(elapsed:Float){time += elapsed;
rain.iTime = time;}

function postCreate() {
	FlxG.camera.color = 0xFFAAAAAA;
	if (FlxG.save.data.rain) {
	FlxG.camera.addShader(rain);
	rain.zoom = 35;
	rain.raindropLength = 0.075;
	rain.opacity = 0.2;
	}
	//stage.getSprite("graadienter").screenCenter();
	stage.getSprite("graadienter").active = false;
	stage.getSprite("graadienter").antialiasing = true;
	stage.getSprite("graadienter").visible = false;
	stage.getSprite("graadienter").blend = BlendMode.ADD;
	fxtwo.scale.set(1.5, 1.5);
	fxtwo.updateHitbox();
	fxtwo.antialiasing = true;
	fxtwo.screenCenter();
	fxtwo.alpha = 0.25;
	fxtwo.scrollFactor.set(0, 0);
	add(fxtwo);
}

function stepHit(curStep) {
	if (curStep % 8 == 0) {
		FlxTween.globalManager.completeTweensOf(stage.getSprite("graadienter"));
		stage.getSprite("graadienter").y += 40;
		FlxTween.tween(stage.getSprite("graadienter"), {y: stage.getSprite("graadienter").y - 40}, 0.4, {ease: FlxEase.backOut});
	}
	switch (curStep) {
		case 1: camGame.fade(0xFF000000, 12.8, true);
		case 128: defaultCamZoom = 0.7;
		camGame.color = FlxColor.WHITE;
		stage.getSprite("graadienter").alpha = 1;
		stage.getSprite("graadienter").visible = true;
		fxtwo.visible = false;
		stage.getSprite("bgLol").visible = false;
		//triggerEventNote('Change Bars Size', '12', '1');
		FlxG.camera.flash(FlxColor.WHITE, 1);
		case 384: stage.getSprite("graadienter").alpha = 1;
		stage.getSprite("graadienter").visible = false;
		defaultCamZoom = 0.8;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		case 786: defaultCamZoom = 1;
		camGame.color = FlxColor.GRAY;
		fxtwo.visible = true;
		stage.getSprite("bgLol").visible = true;
		FlxG.camera.flash(FlxColor.BLACK, 1);
		case 1024:
		defaultCamZoom = 0.9;
		fxtwo.visible = false;
		stage.getSprite("bgLol").visible = false;
		FlxG.camera.flash(FlxColor.WHITE, 1);		
		//case 1148:
		//	FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
		case 1152: defaultCamZoom = 1;
		case 1264: defaultCamZoom = 0.9;
		case 1280: defaultCamZoom = 0.7;
		camGame.color = FlxColor.WHITE;
		stage.getSprite("graadienter").alpha = 1;
		stage.getSprite("graadienter").visible = true;
		//triggerEventNote('Change Bars Size', '12', '1');
		FlxG.camera.flash(FlxColor.WHITE, 1);
	}
}