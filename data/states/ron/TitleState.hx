import flixel.addons.display.FlxBackdrop;

static var initialized = false;
var time = 0;

var blackScreen,textGroup,ngSpr,curWacky,logoBl,logoBi,animScreen,titleText,animbarScrt,animbarScrb;//Kill me.

var god = new CustomShader("godray");
var color = new CustomShader("colorizer");
var chrom = new CustomShader("chromatic aberration");

function create() {
	curWacky = FlxG.random.getObject(getIntroTextShit());

	FlxG.mouse.visible = false;

	startIntro();
	if(FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
	FlxG.camera.addShader(color);
}

function startIntro() {
	if (!initialized) CoolUtil.playMenuSong(true);
		
	animScreen = CoolUtil.loadAnimatedGraphic(new FlxSprite(-100,-90),Paths.image('menus/titlescreen/trueTitleBgAnimated'),30);
	animScreen.scale.set(2,2);
	animScreen.updateHitbox();
	animbarScrt = new FlxBackdrop(Paths.image('menus/titlescreen/trueTitleBarTop'), FlxAxes.X, 0, 0);
	animbarScrb = new FlxBackdrop(Paths.image('menus/titlescreen/trueTitleBarBottom'), FlxAxes.X, 0, 0);
	new FlxTimer().start(0.005, function(tmr:FlxTimer) {
		animbarScrb.x -= 2;
		animbarScrt.x += 2;
		tmr.reset(0.005);
	});
	logoBi = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/trueTitleBack'));
	logoBl = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/trueTitleLogo'));
	titleText = new FlxSprite().loadGraphic(Paths.image('menus/titlescreen/trueTitlePlay'));
	for(i in [animScreen,animbarScrt,animbarScrb,logoBi,logoBl,titleText]) add(i).screenCenter(FlxAxes.XY);//Ugly line of code go!
		
	blackScreen = CoolUtil.loadAnimatedGraphic(new FlxSprite(), Paths.image('menus/titlescreen/titleThing'));
	blackScreen.scale.set(2.25,2.25);
	blackScreen.updateHitbox();
	blackScreen.screenCenter();
	blackScreen.scrollFactor.set(0.1,0.1);
	add(blackScreen);

	add(textGroup = new FlxGroup());

	add(ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('menus/titlescreen/newgrounds_logo'))).visible = false;
	ngSpr.updateHitbox();
	ngSpr.screenCenter(FlxAxes.X);
	ngSpr.antialiasing = Options.antialiasing;

	var blackeffect:FlxSprite = new FlxSprite().makeSolid(FlxG.width*3, FlxG.height*3, FlxColor.BLACK);
	blackeffect.updateHitbox();
	blackeffect.antialiasing = true;
	blackeffect.screenCenter(FlxAxes.XY);
	blackeffect.scrollFactor.set();
	add(blackeffect);

	FlxTween.tween(blackeffect, {alpha: 0}, 1, {ease: FlxEase.quadInOut});

	initialized ? skipIntro() : initialized = true;
}

function getIntroTextShit():Array<Array<String>> {
	var fullText = Assets.getText(Paths.txt('config/introText'));

	var firstArray:Array<String> = fullText.split('\n');
	var swagGoodArray:Array<Array<String>> = [];

	for (i in firstArray) swagGoodArray.push(i.split('--'));

	return swagGoodArray;
}

var transitioning = false;

function update(elapsed:Float) {
	time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	god.iTime=time;
	if (skippedIntro) {
		logoBl.angle = logoBi.angle = Math.sin(-time*5)/8;
		logoBl.screenCenter(FlxAxes.XY);
		titleText.angle += Math.sin(-time*8)/16;
		color.data.colors.value=[time/2];
	}

	if (initialized && !transitioning && skippedIntro && controls.ACCEPT) {
		FlxTween.tween(titleText, {y: titleText.y - 500}, 2, {ease: FlxEase.backIn});

		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
				
		FlxTween.cancelTweensOf(FlxG.camera);
		blackScreen.color = FlxColor.BLACK;
		blackScreen.scale.set(10,10);
		blackScreen.screenCenter(FlxAxes.XY);
		FlxTween.tween(blackScreen, {alpha: 1}, 1.1, {ease: FlxEase.circIn});
		FlxTween.tween(FlxG.camera, {zoom: 3, angle: 22}, 1.5, {ease: FlxEase.quartIn});
		FlxTween.tween(animbarScrt, {y: animbarScrt.y - 200}, 0.5, {ease: FlxEase.quadIn});
		FlxTween.tween(animbarScrb, {y: animbarScrb.y + 200}, 0.5, {ease: FlxEase.quadIn});
		FlxG.camera.fade(0xFF000000, 0.8, true);

		transitioning = true;

		new FlxTimer().start(1, ()-> {FlxG.switchState(new MainMenuState());});
	}

	if (initialized && controls.ACCEPT && !skippedIntro) skipIntro();
	if (FlxG.keys.justPressed.F)  FlxG.fullscreen = !FlxG.fullscreen;
}

function createCoolText(textArray:Array<String>) {
	if(textArray==null){while (textGroup.members.length > 0) textGroup.remove(textGroup.members[0], true); return;}
	for (i in 0...textArray.length) {
		var money:FlxText = new FlxText(0, 0, 0, textArray[i]);
		money.setFormat(Paths.font("w95.otf"), 60, FlxColor.WHITE, 'center');
		money.bold = true;
		money.y += (i * 60) + 200;
		money.screenCenter(FlxAxes.X);
		textGroup.add(money);
	}
}

function beatHit() {
	if (!transitioning) {
		FlxG.camera.zoom = 1.03;
		FlxTween.tween(FlxG.camera, {zoom: 1}, 0.2, {ease: FlxEase.circOut});
		animScreen.animation.play('idle', true);
	}

	switch (curBeat) {
		case 1:createCoolText(['A', 'FUCKTON', 'OF', 'PEOPLE']);
		case 3:createCoolText(['A', 'FUCKTON', 'OF', 'PEOPLE', 'PRESENT']);
		case 4:createCoolText(null);
		case 5:createCoolText(['in association with']);
		case 7:createCoolText(['in association with', 'not patrick']); ngSpr.visible = true;
		case 8:createCoolText(null); ngSpr.visible = false;
		case 9:createCoolText([curWacky[0]]);
		case 11:createCoolText([curWacky[0], curWacky[1]]);
		case 12:createCoolText(null);
		case 13:createCoolText(['LITERALLY EVERY']);
		case 14:createCoolText(['LITERALLY EVERY', 'FANMADE FNF MOD']);
		case 15:createCoolText(['LITERALLY EVERY', 'FANMADE FNF MOD', 'EVER']);
		case 16:skipIntro();
	}
}

var skippedIntro = false;
function skipIntro() {
	if (skippedIntro)return;
	remove(ngSpr);
	remove(textGroup);
	FlxG.camera.flash(FlxColor.WHITE, 4);
	FlxG.camera.addShader(god);
	blackScreen.alpha = 0;
	skippedIntro = true;
}