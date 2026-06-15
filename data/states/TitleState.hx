import flixel.addons.display.FlxBackdrop;
var done = false;
var god = new CustomShader("godray");
var fish = new CustomShader("colorizer");
var chrom = new CustomShader("chromatic aberration");
var time:Float = 0;
function update(elapsed:Float) {
	if (done != (done = true)) {
		animScreen = new FlxSprite();
		animScreen.scale.set(2,2);
		animScreen.frames = Paths.getSparrowAtlas('menus/titlescreen/trueTitleBgAnimated');
		animScreen.animation.addByPrefix('animate', 'animate', 30, true);
		animScreen.animation.play('animate');
		animScreen.screenCenter();
		insert(1,animScreen);
			
		if (blackScreen.frames != null) {
			CoolUtil.loadAnimatedGraphic(blackScreen, Paths.image("menus/titlescreen/titleThing"));
			blackScreen.scale.set(2.25,2.25);
			blackScreen.updateHitbox();
		}
		remove(titleText);
		animbarScrt = new FlxBackdrop(Paths.image('menus/titlescreen/trueTitleBarTop'), FlxAxes.X, 0, 0);
		animbarScrb = new FlxBackdrop(Paths.image('menus/titlescreen/trueTitleBarBottom'), FlxAxes.X, 0, 0);
		animbarScrb.velocity.x -= 120;
		animbarScrt.velocity.x += 120;
		insert(members.indexOf(titleScreenSprites), animbarScrb);
		add(animbarScrt);
		titleTextt = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/trueTitlePlay'));
		insert(members.indexOf(titleScreenSprites), titleTextt);
		new FlxTimer().start(0.005, function(tmr:FlxTimer)
		{
			animbarScrb.x -= 2;
			animbarScrt.x += 2;
			tmr.reset(0.005);
		});
	}
	time += elapsed;
	fish.data.colors.value = [time/2];
	chrom.data.rOffset.value = [chromeOffset*Math.sin(time)];
	chrom.data.bOffset.value = [-chromeOffset*Math.sin(time)];
	titleTextt.angle += Math.sin(-time*8)/16;
	var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

	if (pressedEnter) {
		if (!skippedIntro)
			skipIntro();
		else if (transitioning)
			pressEnter();
		if (curBeat <= 16 && FlxG.keys.justPressed.ENTER) {
			FlxG.camera.addShader(fish);
			FlxG.camera.addShader(god);
		}
	}
}
function beatHit(){
	if (curBeat == 16 && !skippedIntro) {
		FlxG.camera.addShader(fish);
		FlxG.camera.addShader(god);
	}
	if(!transitioning){
	FlxTween.completeTweensOf(FlxG.camera);
	FlxG.camera.zoom += 0.03;
	animScreen.animation.play('animate', true);
	FlxTween.tween(FlxG.camera, {zoom: 1}, Conductor.crochet / 1500, {ease: FlxEase.backOut});}}
function create() if(FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
function pressEnter() {
	FlxTween.tween(titleTextt, {y: titleTextt.y - 500}, 2, {ease: FlxEase.backIn});
	
	FlxTween.cancelTweensOf(FlxG.camera);
	FlxTween.tween(FlxG.camera, {zoom: 3, angle: 22}, 1.1, {ease: FlxEase.quartIn});
	FlxTween.tween(animbarScrt, {y: animbarScrt.y - 200}, 0.5, {ease: FlxEase.quadIn});
	FlxTween.tween(animbarScrb, {y: animbarScrb.y + 200}, 0.5, {ease: FlxEase.quadIn});
	FlxG.camera.fade(0xFF000000, 0.8, true);

	new FlxTimer().start(1, function(tmr:FlxTimer)
	FlxG.switchState(new ModState('DesktopState')));
}