import flixel.effects.particles.FlxTypedEmitter;
import flixel.effects.particles.FlxEmitterMode;
import flixel.effects.particles.FlxParticle;
var time = 0;
var mosaic = new CustomShader("mosaic");
var chrom = new CustomShader("chromatic aberration");
var baro = new FlxSprite().makeSolid(150, FlxG.height*3, FlxColor.BLACK);
var bart = new FlxSprite().makeSolid(150, FlxG.height*3, FlxColor.BLACK);
baro.x = 0;
bart.x = FlxG.width-150;
for(i in [bart,baro]){
    insert(0,i).camera = camHUD;
    i.scrollFactor.set();
    i.visible = false;
}
function postCreate(){
    for(i in [healthBarBG1,healthBarBG2,missesTxt,accuracyTxt,scoreTxt,iconP1,iconP2]) i.alpha=0.001;
	timeBarBG.visible = false;
	timeBar.visible = false;
	timeTxt.visible = false;
	camHUD.color = FlxColor.GRAY;
	if (FlxG.save.data.mosaic) {FlxG.camera.addShader(mosaic); camHUD.addShader(mosaic);
	}
}
function update(elapsed:Float){time += elapsed;
	chrom.data.rOffset.value = [chromeOffset*Math.sin(time)];
	chrom.data.bOffset.value = [-chromeOffset*Math.sin(time)];}
function stepHit(curStep){
	switch(curStep){
		case 250:defaultCamZoom += 0.2;
		case 256:stage.getSprite("graadienter").color = FlxColor.WHITE;
		camHUD.color = FlxColor.WHITE;
		for(i in [healthBarBG1,healthBarBG2,missesTxt,accuracyTxt,scoreTxt,iconP1,iconP2]) i.alpha=1;
		if(FlxG.save.data.TimeBar != 'Disabled') timeBarBG.visible = timeBar.visible = timeTxt.visible = true;
		defaultCamZoom -= 0.1;
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.camera.bgColor = FlxColor.WHITE;

		snowemitter = new FlxTypedEmitter(9999, 0, 300);
		for (i in 0...150) {
			snowemitter.add(p = new FlxParticle().makeGraphic(12,12,FlxColor.GRAY));
			snowemitter.add(p2 = new FlxParticle().makeGraphic(24,24,FlxColor.GRAY));
		}
		snowemitter.width = FlxG.width*1.5;
		snowemitter.launchMode = FlxEmitterMode.SQUARE;
		snowemitter.velocity.set(-10, -240, 10, -320);
		snowemitter.lifespan.set(5);
		insert(5,snowemitter);
		snowemitter.start(false, 0.05);
		case 752:defaultCamZoom += 0.1;
		case 761:mosaic.uBlocksize = 1;
		case 762|763:mosaic.uBlocksize += 1;
		case 764|765:mosaic.uBlocksize += 3;
		case 766:mosaic.uBlocksize = 13;
		case 767:mosaic.uBlocksize = 20;
		case 768:stage.getSprite("scanlines").visible=true;
		stage.getSprite("graadienter").color = FlxColor.fromRGB(224,224,224);
		if (FlxG.save.data.mosaic) {mosaic.uBlocksize = 0; FlxG.camera.removeShader(mosaic);
		camHUD.removeShader(mosaic);}
		cameraSpeed = 3;
		if (FlxG.save.data.chrom) {FlxG.camera.addShader(chrom);
		chrom.rOffset = chromeOffset/2;
		chrom.bOffset = chromeOffset * -1;
		}
		defaultCamZoom -= 0.1;
		FlxG.camera.zoom -= 0.1;
		FlxG.camera.flash(FlxColor.fromRGB(224, 224, 224), 3);
		FlxG.camera.bgColor = FlxColor.fromRGB(224,224,224);
		baro.visible = bart.visible = true;
		case 1280:stage.getSprite("scanlines").visible=false;
		stage.getSprite("graadienter").color = FlxColor.fromRGB(255,255,255);
		if (FlxG.save.data.chrom) {FlxG.camera.removeShader(chrom);camHUD.removeShader(chrom);}
		cameraSpeed = 1;
		defaultCamZoom += 0.1;
		FlxG.camera.zoom += 0.1;
		FlxG.camera.flash(FlxColor.fromRGB(224, 224, 224), 3);
		FlxG.camera.bgColor = FlxColor.fromRGB(255,255,255);
		baro.visible = bart.visible = false;
		case 1808:FlxTween.tween(camHUD, {alpha: 0}, 2, {ease: FlxEase.circInOut});
	}	
	if (curStep >= 256) {
		snowemitter.x = FlxG.camera.scroll.x;
		snowemitter.y = FlxG.camera.scroll.y+FlxG.height+40;
		if (curStep <= 512 && curStep % 4 == 0) {
			if (curStep % 8 == 0) {
				camGame.angle = -2;
				camHUD.angle = -4;
			} else {
				camGame.angle = 2;
				camHUD.angle = 4;
			}
			FlxTween.tween(camGame, {angle: 0}, 0.4, {ease: FlxEase.circOut});
			FlxTween.tween(camHUD, {angle: 0}, 0.4, {ease: FlxEase.circOut});
		}
	}
}

function destroy() FlxG.camera.bgColor = FlxColor.BLACK;