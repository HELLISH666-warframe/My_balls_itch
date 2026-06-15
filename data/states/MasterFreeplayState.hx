var image,vimage,intendedColor,extraImage,classicImage;
static var curSelectedMaster:Int = 0;
var cooltext = new FlxText(0,125,0).setFormat(Paths.font("vcr.ttf"), 96, FlxColor.WHITE);
var cameraWhat = new FlxCamera();
var cameraText = new FlxCamera();
var loBg = new FlxSprite(0, 0).makeSolid(433, 999, 0xFF000000);
var loBgt = new FlxSprite(0, 0).makeSolid(866, 999, 0xFF000000);
var time:Float = 0;
var chrom = new CustomShader("chromatic aberration");
var shit = [["MAIN","CLASSIC","EXTRAS"],[0xFF8C81D9,0xFFC63C3f,0xFFDCF5F4]];
function create() {
	cameraText.bgColor = 0;
	FlxG.cameras.reset(cameraWhat);
	FlxG.cameras.add(cameraText);
	FlxCamera.defaultCameras = [cameraWhat];
	if (FlxG.save.data.crt) FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom) cameraText.addShader(chrom);

	add(bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(320,178.5), Paths.image('menus/freeplay/mainbgAnimate'))).scale.set(2,2);

	add(vimage = new FlxSprite(0,540).loadGraphic(Paths.image('menus/freeplay/freeplay select/ground'))).camera = cameraText;

	for(i in [loBg,loBgt]){
		i.alpha = 0.5;
		add(i).camera = cameraText;
	}

	add(image = new FlxSprite(37,80).loadGraphic(Paths.image('menus/freeplay/freeplay select/ron'))).camera = cameraText;

	add(classicImage = new FlxSprite(370,320).loadGraphic(Paths.image('menus/freeplay/freeplay select/evilron'))).scale.set(1.3,1.3);
	classicImage.camera = cameraText;

	add(extraImage = new FlxSprite(882).loadGraphic(Paths.image('menus/freeplay/freeplay select/doyne'))).camera = cameraText;
	changeSelection(0);

	add(cooltext).camera = cameraText;
}
function update(elapsed:Float) {
	time += elapsed;
    vimage.color = bg.color;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
    cooltext.y += Math.sin(time*4)/2;
	cooltext.text = shit[0][curSelectedMaster];
	cooltext.screenCenter(FlxAxes.X);
	if (controls.RIGHT_P||controls.LEFT_P){
		changeSelection(controls.RIGHT_P ? 1 : -1);
		CoolUtil.playMenuSFX(0, 0.7);
	}
	if(controls.ACCEPT){
		FlxG.switchState(new FreeplayState());
		FlxG.save.data.freeplaything = curSelectedMaster;
	}
	if(controls.BACK) FlxG.switchState(new MainMenuState());
}
function changeSelection(p) {
	curSelectedMaster = FlxMath.wrap(curSelectedMaster + p, 0, 2);
	for(i in [image,classicImage,extraImage]){
		FlxTween.globalManager.cancelTweensOf(i);
		i.color = FlxColor.GRAY;
	}

	var newColor = shit[1][curSelectedMaster];
	switch (curSelectedMaster) {
		case 0: loBgt.x = 866; loBg.x = 433;
		image.color = FlxColor.WHITE;
		case 1: loBgt.x = 866; loBg.x = 0;
		newColor = 0xFFC63C3f;
		classicImage.color = FlxColor.WHITE;
		case 2: loBgt.x = 0; loBg.x = 433;
		newColor = 0xFFDCF5F4;
		extraImage.color = FlxColor.WHITE;
	}
	if(newColor != intendedColor) {
		intendedColor = newColor;
		FlxTween.color(bg, 1, bg.color, intendedColor);
	}
}