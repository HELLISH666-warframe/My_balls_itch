var glitch = new CustomShader("glitchsmh");
var vhs = new CustomShader("vhs");
glitch.data.iTime.value = vhs.iTime = 0;
function postCreate() {
	mmtw = FlxG.sound.load(Paths.music('tstpwyptg'), 0, true);
	mmtw.volume = 0;
	mmtw.play(false, FlxG.random.int(0, Std.int(mmtw.length / 2)));
	if (FlxG.save.data.glitch) {FlxG.camera.addShader(glitch); glitch.on = 1.;}
	if (FlxG.save.data.vhs) FlxG.camera.addShader(vhs);
	if (FlxG.save.data.crt) FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom) {FlxG.camera.addShader(chrom = new CustomShader("chromatic aberration"));
		chrom.rOffset = chromeOffset/2; chrom.bOffset = chromeOffset * -1;
	}
	var bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(-80,-48.375), Paths.image('menus/titlescreen/titleThing'));
	bg.scale.set(2.25,2.25);
	bg.updateHitbox();
	bg.alpha = 0.33;
	add(bg).scrollFactor.set(0.1,0.1);
	titleAlphabet.visible = disclaimer.visible = false;

	add(screen = new FlxSprite().loadGraphic(Paths.image("menus/warning/lol"))).angle = -3;
		
	FlxTween.tween(screen, {y: screen.y + 20}, 1, {ease: FlxEase.circInOut, type: FlxTween.PINGPONG});
	FlxTween.tween(screen, {angle: 3}, 2, {ease: FlxEase.backInOut, type: FlxTween.PINGPONG});
}
function update(elapsed:Float){glitch.data.iTime.value = vhs.iTime += elapsed;
	if (mmtw.volume < .5) mmtw.volume += elapsed * .01;
	if (controls.ACCEPT){
		mmtw.destroy();
		FlxG.sound.play(Paths.sound('resumeSong'));
		FlxTween.tween(FlxG.camera, {zoom: 0.5, angle: 45}, 0.9, {ease: FlxEase.quadIn});
		new FlxTimer().start(0.8, ()-> FlxG.switchState(new TitleState()));
	}
}