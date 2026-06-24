static var curSelMaster = 0;
var cooltext = new FlxText(0,125).setFormat(Paths.font("vcr.ttf"), 96);
var loBg = new FlxSprite().makeSolid(433,720,0xFF000000);
var loBgt = new FlxSprite().makeSolid(866,720,0xFF000000);
var time:Float = 0;
var chrom = new CustomShader("chromatic aberration");
var shit = [["MAIN","CLASSIC","EXTRAS"],[0xFF8C81D9,0xFFC63C3f,0xFFDCF5F4],[[866,433],[866,0],[0,-430]]];
function create() {
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	
	add(bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(320,178.5),Paths.image('menus/freeplay/mainbgAnimate'))).scale.set(2,2);
	add(ground = new FlxSprite(0,522).loadGraphic(Paths.image('menus/freeplay/freeplay select/ground')));

	for(i in [loBg,loBgt]) add(i).alpha = 0.5;

	add(ro = new FlxSprite(37,80).loadGraphic(Paths.image('menus/freeplay/freeplay select/ron')));
	add(classicImage = new FlxSprite(370,320).loadGraphic(Paths.image('menus/freeplay/freeplay select/evilron'))).scale.set(1.3,1.3);
	add(extraImage = new FlxSprite(882,0).loadGraphic(Paths.image('menus/freeplay/freeplay select/doyne')));
	add(cooltext);
	changeSelection(0);
}
function update(elapsed:Float) {time += elapsed;
    ground.color = bg.color;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
    cooltext.y += Math.sin(time*4)/2;//MAKE_IT_SO_THIS_DOESN'T_OFFSET_OVER_TIME_LATER.
	cooltext.text = shit[0][curSelMaster];
	cooltext.screenCenter(FlxAxes.X);
	if (controls.LEFT_P||controls.RIGHT_P){
		changeSelection(controls.LEFT_P ? -1:1);
		CoolUtil.playMenuSFX(0, 0.7);
	}
	if(controls.ACCEPT){
		CoolUtil.playMenuSFX(1);
		FlxG.switchState(new FreeplayState());
	}
	if(controls.BACK) FlxG.switchState(new MainMenuState());
}
function changeSelection(p) {
	FlxG.save.data.freeplaything = curSelMaster = FlxMath.wrap(curSelMaster + p, 0, 2);
	for(i in [ro,classicImage,extraImage]){FlxTween.cancelTweensOf(i); i.color = FlxColor.GRAY;}
	FlxTween.cancelTweensOf(bg,'color');
	[ro,classicImage,extraImage][curSelMaster].color=FlxColor.WHITE;
	for(i in 0...2) [loBgt,loBg][i].x=shit[2][curSelMaster][i];
	if(shit[1][curSelMaster] != bg.color) FlxTween.color(bg,1,bg.color,shit[1][curSelMaster]);
}