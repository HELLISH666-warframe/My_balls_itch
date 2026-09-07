//FP_select_shit.
static var curSelMaster = 0;
var curCatText = new FlxText(0,125).setFormat(Paths.font("vcr.ttf"), 96);
var loBg = new FlxSprite().makeSolid(433,720,0xFF000000);
var loBgt = new FlxSprite().makeSolid(866,720,0xFF000000);
var time:Float = 0;
var chrom = new CustomShader("chromatic aberration");
var shit = [["MAIN","CLASSIC","EXTRAS"],[0xFF8C81D9,0xFFC63C3f,0xFFDCF5F4],[[866,433],[866,0],[0,-430]]];

//Test_shit
var inFreeplay=false;
public var testMap:Map<String, FlxGraphic>=[];

function create() {
	CoolUtil.playMenuSong(true);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	add(bg = CoolUtil.loadAnimatedGraphic(new FlxSprite(320,178.5),Paths.image('menus/freeplay/mainbgAnimate'))).scale.set(2,2);

	add(ground = new FlxSprite(0,522).loadGraphic(Paths.image('menus/freeplay/freeplay select/ground')));

	for(i in [loBg,loBgt]) add(i).alpha = 0.5;

	add(ro = new FlxSprite(37,80).loadGraphic(Paths.image('menus/freeplay/freeplay select/ron')));
	add(classicImage = new FlxSprite(370,320).loadGraphic(Paths.image('menus/freeplay/freeplay select/evilron'))).scale.set(1.3,1.3);
	add(extraImage = new FlxSprite(882,0).loadGraphic(Paths.image('menus/freeplay/freeplay select/doyne')));
	add(curCatText);
	changeSelMFS(0);

	for(i in [ground,loBg,loBgt,ro,classicImage,extraImage,curCatText])i.visible=!inFreeplay;

	//Freeplay
	modeText.setFormat(Paths.font("w95.otf"), 48, FlxColor.WHITE);
	add(modeText).visible=inFreeplay;
	
	portrait.updateHitbox();
	add(portrait);

	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(480.5,-30.5),Paths.image('menus/freeplay/bar')));
	add(portraitOverlay);

	for (i in ["ron","wasted","ayo","bloodshed","trojan-virus","ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic","Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","trouble","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","triad","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding","ron-bside","wasted-bside"]){
		Assets.exists(Paths.image('menus/freeplay/portraits/' + i)) ? port=i : port="ron";
		var graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + port));
		graphic.persist = true;
		testMap.set(i,graphic);
	}

	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	camText.addShader(fish = new CustomShader(FlxG.save.data.rtx?"fisheye-good":"fisheye"));
	fish.MAX_POWER = 0.2;

	var coolemitter = new FlxTypedEmitter(null,FlxG.height);
	coolemitter.velocity.set(0, -5, 0, -10);
	var coolzemitter = new FlxTypedEmitter();
	coolzemitter.velocity.set(0, 5, 0, 10);

	for (i in 0...150) {
		for(pratt in [coolemitter,coolzemitter]){
			pratt.add(p = new FlxParticle().makeGraphic(6,6,FlxColor.BLACK));
			pratt.add(p2 = new FlxParticle().makeGraphic(12,12,FlxColor.BLACK));
		}
	}
	for(i in [coolzemitter,coolemitter]){
		i.width = FlxG.width*1.5;
		i.angularVelocity.set(-10, 10);
		i.lifespan.set(5);
		add(i).start(false, 0.05);
	}

	grpSongs = new FlxTypedGroup();
	add(grpSongs);

	if(inFreeplay)makeSongs();

	scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
	scoreText.setFormat(Paths.font("w95.otf"), 32, FlxColor.WHITE, 'right');

	scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
	scoreBG.alpha = 0.6;
	add(scoreBG);

	diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
	diffText.font = scoreText.font;
	add(diffText);

	add(scoreText);

	add(textBG = new FlxSprite(0, FlxG.height - 26).makeSolid(FlxG.width, 26, 0xFF000000)).alpha = 0.6;

	text = new FlxText(textBG.x, textBG.y + 4, FlxG.width, 'Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu.');
	text.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, 'right');
	text.scrollFactor.set();
	add(text);

	FlxG.cameras.add(camText, false);

	for(i in [modeText,portrait,bar,portraitOverlay,grpSongs,scoreText,scoreBG,diffText,textBG,text])i.visible=inFreeplay;
	//for(i in [coolzemitter,coolemitter])i.emitting=inFreeplay;
	
	//inFreeplay?makeFS():makeMFS();
}
function makeMFS() {
	add(ground = new FlxSprite(0,522).loadGraphic(Paths.image('menus/freeplay/freeplay select/ground')));

	for(i in [loBg,loBgt]) add(i).alpha = 0.5;

	add(ro = new FlxSprite(37,80).loadGraphic(Paths.image('menus/freeplay/freeplay select/ron')));
	add(classicImage = new FlxSprite(370,320).loadGraphic(Paths.image('menus/freeplay/freeplay select/evilron'))).scale.set(1.3,1.3);
	add(extraImage = new FlxSprite(882,0).loadGraphic(Paths.image('menus/freeplay/freeplay select/doyne')));
	add(curCatText);
	changeSelMFS(0);
}
function update(elapsed:Float) {
	time+=elapsed;
	inFreeplay?updateFS(elapsed):updateMFS(elapsed);
	chrom.data.rOffset.value = [chromeOffset*Math.sin(time)];
	chrom.data.bOffset.value = [-chromeOffset*Math.sin(time)];
}
function updateMFS(e:Float) {
	time += e;
	ground.color = bg.color;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
    curCatText.y += Math.sin(time*4)/2;//MAKE_IT_SO_THIS_DOESN'T_OFFSET_OVER_TIME_LATER.
	curCatText.text = shit[0][curSelMaster];
	curCatText.screenCenter(FlxAxes.X);
	if (controls.LEFT_P||controls.RIGHT_P){
		changeSelMFS(controls.LEFT_P ? -1:1);
		CoolUtil.playMenuSFX(0, 0.7);
	}
	if(controls.ACCEPT){
		CoolUtil.playMenuSFX(1);
		enterFreeplay();
		inFreeplay=true;
	}
	if(controls.BACK) FlxG.switchState(new MainMenuState());
}
function changeSelMFS(p) {
	FlxG.save.data.freeplaything = curSelMaster = FlxMath.wrap(curSelMaster + p, 0, 2);
	for(i in [ro,classicImage,extraImage]){FlxTween.cancelTweensOf(i); i.color = FlxColor.GRAY;}
	FlxTween.cancelTweensOf(bg,'color');
	[ro,classicImage,extraImage][curSelMaster].color=FlxColor.WHITE;
	for(i in 0...2) [loBgt,loBg][i].x=shit[2][curSelMaster][i];
	if(shit[1][curSelMaster] != bg.color) FlxTween.color(bg,1,bg.color,shit[1][curSelMaster]);
}

function enterFreeplay() {
	for(i in [ground,loBg,loBgt,ro,classicImage,extraImage,curCatText]){
	i.visible=false;
	//FlxTween.tween(i, {alpha:0.001}, 0.6, {ease: FlxEase.quintOut});
	}
	for(i in [modeText,portrait,bar,portraitOverlay,grpSongs,scoreText,scoreBG,diffText,textBG,text]){
		i.visible=true;
	}
	makeSongs();
	changeSelFP(0);
}

function exitFreeplay() {
	for(i in [ground,loBg,loBgt,ro,classicImage,extraImage,curCatText]){
	i.visible=true;
	//FlxTween.tween(i, {alpha:0.001}, 0.6, {ease: FlxEase.quintOut});
	}
	for(i in [modeText,portrait,bar,portraitOverlay,grpSongs,scoreText,scoreBG,diffText,textBG,text]){
		i.visible=false;
	}
	songs = [];
	grpSongs.clear();
	if(iconArray.length > 0) for(icon in iconArray) icon.destroy();
	iconArray = [];
	changeSelMFS(0);
}

//Freeplay_Shit.
import flixel.effects.particles.FlxTypedEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.DiscordUtil;
import flixel.text.FlxTextBorderStyle;
import funkin.savedata.FunkinSave;
import funkin.backend.chart.Chart;
import flixel.graphics.FlxGraphic;
import Alphabetthing;

var text;
var songs = [];
songRealList = [["ron","wasted","ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu","trouble","holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky","triad","certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding","ron-bside","wasted-bside"]];

static var curSelPFP:Int = 0;

var curDifficulty:Int = 1;

var scoreBG:FlxSprite;
var scoreText:FlxText;
var diffText:FlxText;
var lerpScore:Int = 0;
var lerpRating:Float = 0;
var intendedScore:Int = 0;
var intendedRating:Float = 0;

var grpSongs:FlxTypedGroup<Alphabet>;
var curPlaying:Bool = false;

var iconArray:Array<HealthIcon> = [];

var intendedColor:Int;
var iconArray:Array<HealthIcon> = [];
var camText = new FlxCamera();
camText.bgColor = null;
var portrait = new FlxSprite();
var portraitOverlay = new FlxSprite();
var preload = [];
static var curSelectReal = [0,0,0,0,0];
var modeText = new FlxText(0,0,0,["MAIN","CLASSIC","EXTRAS"][FlxG.save.data.freeplaything]).setFormat(null,48,FlxColor.WHITE);
var fanmade_text = new FlxText(160, 600, 0, '', 48);

function makeFS() {
	bg.frames = Paths.getSparrowAtlas('menus/freeplay/mainbgAnimate');
	if(FlxG.save.data.freeplaything == 1){
		bg.frames = Paths.getSparrowAtlas('menus/freeplay/classicbgAnimate');
	}
	bg.animation.addByPrefix('animate', 'animate', 24, true);
	bg.animation.play('animate');
}

function makeSongs() {
	songs = [];
	grpSongs.clear();
	if(iconArray.length > 0) for(icon in iconArray) icon.destroy();
	iconArray = [];
	rsongsFound = songRealList[FlxG.save.data.freeplaything];
	for(s in rsongsFound) songs.push(Chart.loadChartMeta(s, "hard", true));
	for (i in 0...songs.length) {
		var songText = new Alphabetthing(0, (70 * i) + 30, songs[i].displayName.toUpperCase(),true);
		songText.isMenuItem = true;
		songText.targetY = i;
		songText.ID = i;
		songText.camera = camText;
		grpSongs.add(songText);
		var icon = new HealthIcon(songs[i].icon);

		iconArray.push(icon);
		add(icon);
	}
}

var holdTime:Float = 0;
var time:Float = 0;
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

function updateFS(e:Float) {
	if (FlxG.sound.music.volume < 0.7) FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
	lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, FlxMath.bound(e * 24, 0, 1)));
	lerpRating = FlxMath.lerp(lerpRating, intendedRating, FlxMath.bound(e * 12, 0, 1));

	if (Math.abs(lerpScore - intendedScore) <= 10) lerpScore = intendedScore;
	if (Math.abs(lerpRating - intendedRating) <= 0.01) lerpRating = intendedRating;

	var ratingSplit:Array<String> = Std.string(floorDecimal(lerpRating * 100, 2)).split('.');
	if (ratingSplit.length < 2) ratingSplit.push('');

	while (ratingSplit[1].length < 2) ratingSplit[1] += '0';

	scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' +ratingSplit.join('.')+ '%)';
	positionHighscore();
	var shiftMult:Int = 1;
	if (FlxG.keys.pressed.SHIFT) shiftMult = 3;
	if (controls.UP_P||controls.DOWN_P) {
		changeSelFP(controls.UP_P?-shiftMult:shiftMult);
		holdTime = 0;
	}
	if (controls.DOWN_P || controls.UP_P) {
		var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
		holdTime += e;
		var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

		if (holdTime > 0.5 && checkNewHold - checkLastHold > 0) 
			changeSelFP((checkNewHold - checkLastHold) * (controls.UP_P ? -shiftMult : shiftMult));
	}
	if (FlxG.mouse.wheel != 0) {
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
		changeSelFP(-shiftMult * FlxG.mouse.wheel, false);
	}
	if (controls.LEFT_P||controls.RIGHT_P) changeDiff(controls.LEFT_P?-1:1);
	else if (FlxG.keys.justPressed.SPACE) {
		if (instPlaying != curSelPFP) {
			#if PRELOAD_ALL
			FlxG.sound.music.volume = 0;

			FlxG.sound.playMusic(Paths.inst(songs[curSelPFP].name, songs[curSelPFP].difficulties[curDifficulty]), 0.7);
			instPlaying = curSelPFP;
			#end
		}
	}
	else if (controls.ACCEPT) {
		var songLowercase:String = songs[curSelPFP].name;
		persistentUpdate = false;
		PlayState.loadSong(songs[curSelPFP].name, songs[curSelPFP].difficulties[curDifficulty].toLowerCase());
		FlxG.switchState(new PlayState());
	
		FlxG.sound.music.volume = 0;
	}
	if (FlxG.keys.justPressed.CONTROL){
		persistentUpdate = false;
		openSubState(new ModSubState('shared/GameplayChangersSubstate'));
	}
	time += e;
	glitch.iTime = time;
	vhs.iTime = time;
	for (i in 0...songs.length)
		grpSongs.members[i].y += (Math.sin(i+time)/2);
	for (item in grpSongs.members)
		item.forceX = FlxMath.lerp(item.x, 125 + (65 * (item.ID - curSelPFP)), lerpFix(0.1));
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;
	if(controls.BACK){
		exitFreeplay();
		inFreeplay=false;
	}
	for (i in 0...grpSongs.length)
		iconArray[i].setPosition(grpSongs.members[i].x+grpSongs.members[i].width+10,grpSongs.members[i].y-30);
}

function changeDiff(e:Int) {
	curDifficulty = FlxMath.wrap(curDifficulty + e, 0, songs[curSelPFP].difficulties.length-1);

	intendedScore = FunkinSave.getSongHighscore(songs[curSelPFP].name, songs[curSelPFP].difficulties[curDifficulty]).score;
	intendedRating = FunkinSave.getSongHighscore(songs[curSelPFP].name, songs[curSelPFP].difficulties[curDifficulty]).accuracy;

	diffText.text = '< ' + songs[curSelPFP].difficulties[curDifficulty].toUpperCase() + ' >';
	diffText.color = switch(diffText.text) {
		case '< COOL >':0xF00020;
		case '< STAINED >':0x347FF1;
		default: 0xFFFFFFFF;		
	}
	fanmade_text.color = switch(diffText.text) {
		case '< STAINED >':0x347FF1;
		default: 0xffee00;		
	}
	positionHighscore();
}

function shadering(REAL:Int,?string:String=""){
	var cursong = songs[REAL];
    switch(cursong.displayName) {
		case "gron": if(FlxG.save.data.grey)FlxG.camera.addShader(grey);camText.addShader(grey);
		case "trojan-virus"|"Bleeding":glitch.on = 1.;
		default:FlxG.camera.removeShader(grey);camText.removeShader(grey);
			glitch.on = 0;
    }
	if(string=="hand"){
		if(Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong.displayName+'-over')))
		portraitOverlay.loadGraphic(Paths.image('menus/freeplay/portraits/'+cursong.displayName+'-over'));
		portraitOverlay.screenCenter();
		Assets.exists(Paths.image('menus/freeplay/portraits/'+cursong.displayName+'-over')) ? portraitOverlay.visible = true : 
		portraitOverlay.visible = false;
		return;
	}

	if(fanmade_text.text!=songs[curSelPFP].version)fanmade_text.alpha=0;
	FlxTween.tween(fanmade_text, {alpha:1}, 0.2, {ease: FlxEase.quintIn});
	fanmade_text.text=songs[curSelPFP].version;
	for(i in [bar,portrait]) {
		FlxTween.cancelTweensOf(i,['alpha']);
		FlxTween.tween(i, {alpha:cursong.port=='none'?0.2:1}, 0.5, {ease: FlxEase.quadIn});
	}
}

function changeSelFP(change:Int = 0, playSound:Bool = true) {
	playSound??=true;
	if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	curSelPFP = FlxMath.wrap(curSelPFP + change, 0, songs.length-1);
	curSelectReal[FlxG.save.data.freeplaything]=curSelPFP;
	
	var bullShit:Int = 0;

	for (i in grpSongs){
		i.targetY = bullShit - curSelPFP;
		bullShit++;
		i.alpha = 0.6;
		if (i.targetY == 0) i.alpha = 1;
	}

	for (i in 0...iconArray.length) iconArray[i].alpha = 0.6;
	iconArray[curSelPFP].alpha = 1;
	shadering(curSelPFP);

	FlxTween.tween(portrait, {y: portrait.y + 300}, 0.2, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween) {
		portrait.loadGraphic(testMap.get(songs[curSelPFP].name));
		shadering(curSelPFP,"hand");
		portrait.screenCenter(FlxAxes.Y);
		var mfwY2 = portrait.y;
		portrait.y -= 20;
		FlxTween.tween(portrait, {y: mfwY2}, 0.4, {ease: FlxEase.elasticOut});
	}});

	var newColor:Int = songs[curSelPFP].color;
	if (newColor != intendedColor) {
		intendedColor = newColor;
		FlxTween.cancelTweensOf(bg,['color']);
		FlxTween.color(bg, 1, bg.color, intendedColor);
	}
	changeDiff(0);
}

function positionHighscore() {
	scoreText.x = FlxG.width - scoreText.width - 6;

	scoreBG.scale.x = FlxG.width - scoreText.x + 6;
	scoreBG.x = FlxG.width - (scoreBG.scale.x / 2);
	diffText.x = Std.int(scoreBG.x + (scoreBG.width / 2));
	diffText.x -= diffText.width / 2;
}

public static function floorDecimal(value:Float, decimals:Int):Float{
	if (decimals < 1) return Math.floor(value);
	var tempMult:Float = 1;
	for (i in 0...decimals) tempMult *= 10;
	var newValue:Float = Math.floor(value * tempMult);
	return newValue / tempMult;
}

public static function lerpFix(value:Float) {return value / (60 / 60);}