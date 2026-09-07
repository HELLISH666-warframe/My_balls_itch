//yes_i_know_how_unoptimized_this_shit_is
var fog:FlxSprite;
var truefog:FlxSprite;
var time:Float = 0;
var wasdark = false;
var ray = new CustomShader('godray');
ray.iTime=0;
var glitch = new CustomShader("glitchsmh");
glitch.iTime=0;
var chrom = new CustomShader("chromatic aberration");
var rain = new CustomShader("rain");
var underWater = false;

public function water() {
	underWater=!underWater;
	dad.angle=boyfriend.angle=gf.angle=0;
	underwater.visible=!underwater.visible;
	darkness();
	if(underWater){
		for(i in [scoreTxt,accuracyTxt,missesTxt,healthBarBG1,healthBarBG2,iconP1,iconP2])
		FlxTween.tween(i, {y:i.y-FlxG.height}, 2, {ease: FlxEase.circOut});
		defaultCamZoom=FlxG.camera.zoom=0.65;
		rain.opacity = 0;
		FlxG.camera.addShader(ray);
		FlxG.camera.addShader(crt = new CustomShader('fake CRT'));
		boyfriend.cameraOffset.y-=90;
		dad.cameraOffset.y-=90;
		FlxTween.tween(street, {alpha: 0.2}, 0.7, {ease:FlxEase.circInOut, type:FlxTween.PINGPONG});
	}
	else{
		FlxTween.cancelTweensOf(street, ['alpha']);
		FlxG.camera.removeShader(ray);
		boyfriend.cameraOffset.y+=90;
		dad.cameraOffset.y+=90;
		for(i in [scoreTxt,accuracyTxt,missesTxt,healthBarBG1,healthBarBG2,iconP1,iconP2])
		FlxTween.tween(i, {y:i.y+FlxG.height}, 2, {ease: FlxEase.backOut});
		FlxTween.tween(camHUD, {alpha: 0}, 0.9, {ease:FlxEase.circInOut});
		if (FlxG.save.data.glitch) {camHUD.addShader(glitch); glitch.on = 1.;}
		if(FlxG.save.data.rain){rain.opacity = 0.125;rain.zoom = 32;rain.raindropLength = 0.03;}
		remove(truefog);
		insert(members.indexOf(stage.getSprite("street"))+1, truefog).visible=true;
		truefog.alpha=0.2;
		boyfriend.color = gf.color = 0xFFdbcfb3;
	}
	gf.alpha=street.alpha=underWater?0.4:1;
	for(i in 0...strumLines.length)strumLines.members[i].forEach((a) -> {a.y=50;});
}
function postCreate() {
	underwater.visible=false;
	
	boyfriend.color = 0xFFdbcfb3;
	gf.color = 0xFFdbcfb3;
	
	fog = new FlxSprite().loadGraphic(Paths.image('stages/pissedStreet/fog'));
	fog.scale.set(2, 2);
	fog.screenCenter();
	fog.scrollFactor.set(0.8, 0.8);
	fog.camera = camHUD;
	truefog = new FlxSprite().loadGraphic(Paths.image('stages/pissedStreet/truefog'));
	truefog.scale.set(2, 2);
	truefog.screenCenter();
	truefog.scrollFactor.set(0.8, 0.8);
	insert(members.indexOf(stage.getSprite("mountains")), truefog);
	truefog.visible = false;

	if (FlxG.save.data.rain) {FlxG.camera.addShader(rain);rain.zoom = 32;
	rain.raindropLength = 0.03;rain.opacity = 0.125;rain.iTime = 0;}
}

function fade()
{
	var it = 1; 
	for (i in stage.stageSprites) {
		FlxTween.color(i, (Conductor.crochet/1000) * 4.5,0xFFFFFFFF, 0xFF000000);
	}
}

function darkness()
{
	wasdark = !wasdark;
	if (wasdark == true)
	{
		for (i in stage.stageSprites) {
			FlxTween.cancelTweensOf(i, ['color']);
		}
		truefog.visible = true;
		add(fog);
		fog.color = 0xFF77ADFF;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		dad.color = 0xFF000000;
		boyfriend.color = 0xFF000000;
		truefog.color = 0xFFFFFFFF;
			
		sky.color = 0xFFFFFFFF;
		city.color = 0xFFFFFFFF;
		mountains.color = 0xFF000000;
		hillfront.color = 0xFF000000;
		street.color = 0xFF000000;
		street.alpha = 0.5;
		hillfront.alpha = 0.25;
		mountains.alpha = 0.125;
			
		gf.alpha = 0.75;
		new FlxTimer().start(0.02, ()->{gf.color = 0xFF000000;});

		rain.zoom = 40;rain.raindropLength = 0.1;rain.opacity = 0.25;
	}
	else
	{
		truefog.visible = false;
		remove(fog);
		var it = 0; 
		for (i in stage.stageSprites) {
			if (i.color == 0xFF000000)
				FlxTween.color(i, (Conductor.crochet/2000), 0xFF000000, 0xFFFFFFFF, {ease: FlxEase.circOut});
		}
		FlxTween.color(dad, (Conductor.crochet/2000), 0xFF000000, 0xFFFFFFFF, {ease: FlxEase.circOut});
		for (i in [gf, boyfriend])
			FlxTween.color(i, (Conductor.crochet/2000), 0xFF000000, 0xFFdbcfb3, {ease: FlxEase.circOut});

		street.alpha = hillfront.alpha = mountains.alpha = gf.alpha = 1;
		rain.zoom = 32;rain.raindropLength = 0.03;rain.opacity = 0.125;
	}
}

function underwater()
{
	sky.visible = !sky.visible;
	city.visible = !city.visible;
	mountains.visible = !mountains.visible;
	hillfront.visible = !hillfront.visible;
	street.visible = !street.visible;
	underwater.visible = !underwater.visible;
}

function update60(elapsed) 
{
	time += elapsed;
	chrom.data.rOffset.value = [0.005*Math.sin(time)];
	chrom.data.bOffset.value = [-0.005*Math.sin(time)];
	glitch.iTime +=elapsed;
	rain.iTime+=elapsed;
	ray.iTime+=elapsed;

	if (underWater) {
	//underwater.y -= FlxMath.bound(Math.sin(elapsed)/6,-400,100);
	boyfriend.y += Math.sin(curStep/6)/2;
	dad.y -= Math.sin(curStep/6)/2;
	gf.y += Math.sin(curStep/4)/2;
	gf.angle += 0.7;
	boyfriend.angle += Math.sin(curStep/8)/6;
	dad.angle -= Math.sin(curStep/8)/6;
	for (i in 0...8) {strumLineNotes[i].y += Math.sin((curStep+i*2)/4)/2;
	}
	}
}

function beatHit(){
	if(underWater){
		if (curBeat % 4 == 0) {
			for(i in 0...8){
			FlxTween.cancelTweensOf(strumLineNotes[i],['angle']);
			strumLineNotes[i].angle=0;
			}
			for(i in 0...4){
				FlxTween.tween(cpuStrums.members[i], {angle: curBeat % 8 == 4?-360:360}, 0.4*(i+1), {ease: FlxEase.circOut});
				FlxTween.tween(playerStrums.members[i], {angle: curBeat % 8 == 4?-360:360}, 0.5*(i+1), {ease: FlxEase.circOut});
			}
		}
	}
}