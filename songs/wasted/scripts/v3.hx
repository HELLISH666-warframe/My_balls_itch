import openfl.display.BlendMode;
var fgfxtwo = new FlxSprite().loadGraphic(Paths.image('stages/pissedStreet/fog'));
var time:Float = 0;
var rain = new CustomShader("rain");
var glitch = new CustomShader("glitchsmh");
var chrom = new CustomShader("chromatic aberration");
var god = new CustomShader('godray');

var camOverlay = new FlxCamera();

function postCreate() {
	camOverlay.bgColor = 0;
	FlxG.cameras.add(camOverlay,false);
	fgfxtwo.scale.set(3, 3);
	fgfxtwo.alpha = 0.5;
	fgfxtwo.scrollFactor.set(0.4, 0.4);
	add(fgfxtwo);			
	fgfxtwo.visible = false;
	fxtwo = new FlxSprite().loadGraphic(Paths.image('stages/pissedStreet/fog'));
	fxtwo.scale.set(2, 2);
	for(i in [fgfxtwo,fxtwo]){
		i.updateHitbox();
		i.antialiasing = true;
		i.screenCenter();
		i.color = FlxColor.BLACK;
	}
	fxtwo.alpha = 0.2;
	fxtwo.scrollFactor.set(0.8, 0.8);
	fxtwo.blend = BlendMode.OVERLAY;
	if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);rain.zoom = 32;
	rain.raindropLength = 0.03;rain.opacity = 0.125;}
	for (i in cpuStrums.members){allStrums.push(i);}
    for (i in playerStrums.members) {allStrums.push(i);}
}
var moveing:Bool = false;
var allStrums = [];
function update(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	rain.iTime = time;
	glitch.iTime = time;
	if(FlxG.save.data.god) god.iTime = time;
	if (moveing) {
		for (i in 0...8){ 
		var member = allStrums[i];
		member.y += Math.sin((curStep+i*2)/4)/2;//Todo:MAKE_THIS_NOT_FPS_BASED.
		}
	boyfriend.y += Math.sin(curStep/6)/2;
	dad.y -= Math.sin(curStep/6)/2;
	gf.y += Math.sin(curStep/4)/2;
	gf.angle += 0.7;
	boyfriend.angle += Math.sin(curStep/8)/6;
	dad.angle -= Math.sin(curStep/8)/6;
	}
}
function stepHit(curStep){	
	if (curStep >= 320 && curStep < 576||curStep >= 832 && curStep < 1088){
		for (i in 0...4) { 
			for (guh in [playerStrums, cpuStrums]) {
				if (curStep % 4 == 0) {
					FlxTween.globalManager.completeTweensOf(guh.members[i]);
					Options.downscroll ? guh.members[i].y-=20 :guh.members[i].y+=20;
					FlxTween.tween(guh.members[i], {y: 50}, 0.3, {ease: FlxEase.backOut});
				}
			}
		}
	}
	switch(curStep) {
		case 192: defaultCamZoom = 0.9;
		cameraSpeed = 8;
		case 320: defaultCamZoom = 0.95;
		//penile injection
		fgfxtwo.visible = true;
		rain.zoom=35;
		rain.raindropLength=0.075;
		rain.opacity=0.2;
		add(fxtwo);
		cameraSpeed = 0.2;
		fxtwo.camera = camOverlay;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		case 576: rain.zoom=32;
		rain.raindropLength=0.03;
		rain.opacity=0.125;
		fgfxtwo.visible = false;
		fxtwo.visible = false;
		cameraSpeed = 1;
		defaultCamZoom = 0.8;
		case 816: defaultCamZoom = 0.9;
		case 836: defaultCamZoom = 0.95;
		cameraSpeed = 0.2;
		fxtwo.visible = true;
		fgfxtwo.visible = true;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		rain.zoom=40;
		rain.raindropLength=0.1;
		rain.opacity=0.25;
		case 1088: fgfxtwo.visible = false;
		cameraSpeed = 1;
		defaultCamZoom = 0.9;
		camGame.alpha = 0;
		rain.opacity=0;
		camHUD.alpha=0;
		case 1104: camHUD.alpha=1;
		cameraSpeed = 8;
		camGame.alpha = 1;
		defaultCamZoom = 0.75;
		dad.scale.set(1.2,1.2);
		boyfriend.x += 120;
		dad.x -= 120;
		if(FlxG.save.data.crt) FlxG.camera.addShader(crt = new CustomShader('fake CRT'));
		if(FlxG.save.data.god) FlxG.camera.addShader(god);
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		stage.getSprite("underwater").visible=true;
		case 1232: defaultCamZoom = 0.85;
		case 1360: camGame.alpha = 0;
		FlxTween.tween(camHUD, {alpha: 0}, 0.8, {ease: FlxEase.circOut});
		if(FlxG.save.data.god) FlxG.camera.removeShader(god);
		//clearShader(FlxG.camera);
		//clearShader(camGame);
		case 1400: gf.angle = boyfriend.angle = dad.angle = 0;
		for (i in 0...4) cpuStrums.members[i].y=playerStrums.members[i].y=50;
		case 1488: camHUD.alpha=1;
		rain.zoom=32;
		rain.raindropLength=0.03;
		rain.opacity=0.125;
		if(FlxG.save.data.glitch){camHUD.addShader(glitch);glitch.on=1.;}
		fgfxtwo.visible = true;
		stage.getSprite("underwater").visible=false;
		cameraSpeed = 1;
		defaultCamZoom = 1;
		camGame.alpha = 1;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
	}
}

function underwater(){
	//for(i in stage.stageSprites.keys()) stage.getSprite(i).visible = !stage.getSprite(i).visible;//LATER.
	for(i in ['sky','city','mountains','hillfront','street','underwater'])
		stage.getSprite(i).visible=!stage.getSprite(i).visible;
	moveing = !moveing;
	dad.angle=boyfriend.angle=gf.angle=0;
}