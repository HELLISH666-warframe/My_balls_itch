var glitch = new CustomShader("glitchsmh");
var chrom = new CustomShader("chromatic aberration");
var vhs = new CustomShader("vhs");
var time:Float = 0;
var moveing:Bool = false;
var rain = new CustomShader("rain");
var defaultStrumX:Array<Float> = [[96,208,320,432],[736,848,960,1072]];

function update(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	for (i in [glitch,rain,vhs]) i.iTime=time;
	var currentBeat:Float = (Conductor.songPosition / 1000)*(Conductor.bpm/60);
	if (moveing){
		for (i in 0...4) cpuStrums.members[i].x = defaultStrumX[0][i]+ 32 * Math.sin((currentBeat + i*0.25) * Math.PI);
		for (i in 0...4) playerStrums.members[i].x = defaultStrumX[1][i]+ 32 * Math.sin((currentBeat + i*0.25) * Math.PI);
	}
	if (!moveing){
		for (i in 0...4) cpuStrums.members[i].x = defaultStrumX[0][i];
		for (i in 0...4) playerStrums.members[i].x = defaultStrumX[1][i];
	}
}
function postCreate() {
if (FlxG.save.data.rain){FlxG.camera.addShader(rain);rain.zoom = 35;
	rain.raindropLength = 0.075;rain.opacity = 0.2;
	}
	stage.getSprite("popup").alpha = 0.5;
    stage.getSprite("popupt").alpha = 0.7;
}
function stepHit(step){
	switch (step){
	case 384:
		if (FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
		if (FlxG.save.data.vhs) FlxG.camera.addShader(vhs);
		if (FlxG.save.data.glitch) FlxG.camera.addShader(glitch); glitch.on = 1.;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		camHUD.shake(0.002);
		defaultCamZoom = 0.8;
		moveing = true;
		stage.getSprite("sky").destroy();
		stage.getSprite("mountainsback").destroy();
		stage.getSprite("mountains").destroy();
		stage.getSprite("hillfront").destroy();
		stage.getSprite("street").destroy();
	case 640:
		moveing = false;
		glitch.on = 0.;
		defaultCamZoom = 0.55;
	case 912:
		moveing = true;
		glitch.on = 1.;
		defaultCamZoom = 0.88;
	case 1160|1164|1165|1166|1167:
		window.move(window.x + FlxG.random.int(-50, 50),window.y + FlxG.random.int(-32, 32));
	//Code_later.
	/*case 1161:
		#if windows
		misc.SendWindowsNotification.sendWindowsNotification("Virus & threat protection", "Windows Defender Antivirus found threats. Get details.");
		#end*/
	case 1424:
		moveing = false;
		if (FlxG.save.data.glitch)FlxG.camera.removeShader(glitch);
		FlxTween.tween(camHUD, {alpha: 0}, 2, {ease: FlxEase.circInOut});
	case 1490:
		defaultCamZoom = 1;
	case 1552:
		add(budjet = new FlxSprite(0, 0).loadGraphic(Paths.image('ron/budjet'))).camera = camOther;
		budjet.screenCenter();
		dad.visible = false;
		defaultCamZoom = 0.9;
	}
	if (curStep >= 384 && curStep <= 640) FlxG.camera.shake(0.00625, 0.1);
	
	camHUD.shake(0.00125, 0.15);
}