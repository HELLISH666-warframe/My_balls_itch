var time:Float = 0;
var chrom = new CustomShader("chromatic aberration");
var glitch = new CustomShader("glitchsmh");
function postCreate() {
	wbg = new FlxSprite().makeGraphic(FlxG.width*3, FlxG.height*3, FlxColor.BLACK);
    wbg.scale.set(5,5);
    wbg.updateHitbox();
    wbg.screenCenter();
    wbg.scrollFactor.set();
    wbg.alpha = 0.35;

    fx = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
    fx.setGraphicSize(Std.int(2560 * 0.75));
    fx.updateHitbox();
    fx.antialiasing = true;
    fx.screenCenter();
    fx.scrollFactor.set(0, 0);
    fx.alpha = 0.5;	
}
function update(elapsed:Float){time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	glitch.iTime = time;
}
function beatHit(curBeat){
	if (curBeat == 64) {
		camGame.flash(FlxColor.WHITE, 0.2);
		if (FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
		if (FlxG.save.data.glitch) {FlxG.camera.addShader(glitch); glitch.on = 1.;}
		stage.getSprite("background").visible=false;
		add(fx);
		add(wbg);
	}
}