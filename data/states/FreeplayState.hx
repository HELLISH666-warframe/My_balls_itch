import Alphabetthing;
import flixel.graphics.FlxGraphic;
import funkin.backend.chart.Chart;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;

var time = 0;
var chrom = new CustomShader("chromatic aberration");
var glitch = new CustomShader("glitchsmh");
var grey = new CustomShader("grayscale");
var vhs = new CustomShader("vhs");

songs = [];
songRealList = [["ron",/*"wasted",*/"ayo","bloodshed","trojan-virus"],
	["ron-classic","wasted-classic","ayo-classic","bloodshed-classic","trojan-virus-classic","bleeding-classic"],
	["Tutorial","bloodbath","official-debate","gron","difficult-powers","bijuu",'trouble',"holy-shit-dave-fnf","slammed","ron-dsides","lights-down-remix","pretty-wacky",'triad',"certified-champion","rong-aisle","bloodshed-legacy-redux","clusterfunk","awesome-ron","oh-my-god-hes-ballin","fardventure","bleeding"]];
modelist = ["MAIN","CLASSIC","EXTRAS"];

for(s in songRealList[FlxG.save.data.freeplaything]) songs.push(Chart.loadChartMeta(s, "hard", true));
var camText = new FlxCamera();
camText.bgColor = null;
var portrait = new FlxSprite();
var portraitOverlay = new FlxSprite();
var preload = [];
var grpSongs2 = new FlxTypedGroup();
var iconArray2:Array<HealthIcon> = [];
var modeText = new FlxText(0,0,0,modelist[FlxG.save.data.freeplaything]).setFormat(null,48,FlxColor.WHITE);
static var curSelectReal = [0,0,0];
function postUpdate(elapsed:Float){time += elapsed;
	if(controls.BACK)FlxG.switchState(new ModState('MasterFreeplayState'));
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	vhs.data.iTime.value = glitch.data.iTime.value = [time];

	for (i in 0...songs.length){ grpSongs2.members[i].y += (Math.sin(i+time)/2);
		iconArray2[i].setPosition(grpSongs2.members[i].x+grpSongs2.members[i].width+10,grpSongs2.members[i].y-55);
	}
	for (item in grpSongs2.members)
		item.forceX = CoolUtil.fpsLerp(item.x, 125 + (65 * (item.ID - curSelected)),0.1);
	portraitOverlay.y = portrait.y;
	portraitOverlay.angle = portrait.angle;
}
function create(){
	add(grpSongs2);
	for (i in 0...songs.length) {
		var songText = new Alphabetthing(0, (70 * i) + 30, songs[i].displayName, true, false);
		songText.isMenuItem = true;
		songText.targetY = songText.ID = i;
		grpSongs2.add(songText).camera = camText;
		add(icon = new HealthIcon(songs[i].icon));
		iconArray2.push(icon);
	}
	for (i in 0...iconArray2.length) remove(iconArray2[i]);
	curSelected=curSelectReal[FlxG.save.data.freeplaything];
	insert(2,modeText);
	insert(2,portrait).updateHitbox();
}
function postCreate(){
	FlxG.cameras.add(camText, false);
	remove(grpSongs);
	for(i in iconArray) remove(i);

	bg.frames = Paths.getSparrowAtlas('menus/freeplay/mainbgAnimate');
	if(FlxG.save.data.freeplaything == 1){
		bg.frames = Paths.getSparrowAtlas('menus/freeplay/classicbgAnimate');
		FlxG.camera.addShader(vhs);
	}
	bg.animation.addByPrefix('animate', 'animate', 24, true);
	bg.animation.play('animate');
	bg.scale.set(2,2);
	bg.screenCenter();

	add(bar = CoolUtil.loadAnimatedGraphic(new FlxSprite(480.5,-30.5),Paths.image('menus/freeplay/bar')));

	insert(5,portraitOverlay);
	for (i in members) if (Std.isOfType(i, FlxText)) i.font = Paths.font("w95.otf");
	scoreBG.alpha = 0.3;
	
	for (i in 0...iconArray2.length) add(iconArray2[i]);
	for (i in songs){
		Assets.exists(Paths.image('menus/freeplay/portraits/' + i.portrait)) ? port=i.portrait : port="ron";
		var graphic = FlxGraphic.fromAssetKey(Paths.image('menus/freeplay/portraits/' + port));
		graphic.persist = true;
		preload.push(graphic);
	}
	changeSelection(0, true);
	if (FlxG.save.data.glitch)FlxG.camera.addShader(glitch);
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.chrom)FlxG.camera.addShader(chrom);
	FlxG.camera.addShader(grey);camText.addShader(grey);
	camText.addShader(fish = new CustomShader("fisheye"));
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
}
function shadering(REAL:Int,?string:String=""){
	var curPort = songs[REAL].portrait;
	if(string=="hand"){
		if(Assets.exists(Paths.image('menus/freeplay/portraits/'+curPort+'-over')))
		portraitOverlay.loadGraphic(Paths.image('menus/freeplay/portraits/'+curPort+'-over'));
		portraitOverlay.screenCenter();
		Assets.exists(Paths.image('menus/freeplay/portraits/'+curPort+'-over')) ? portraitOverlay.visible = true : 
		portraitOverlay.visible = false;
		return;
	}
    switch(songs[REAL].displayName)	{
		case"gron":if(FlxG.save.data.grey)grey.enable=1;
		case"trojan-virus":glitch.on = 1.;
		case"Bleeding":diffText.color=0xE00020;glitch.on = 1.;
		default:grey.enable=0; glitch.on = 0;diffText.color=0xFFFFFFFF;
    }
}
function onChangeSelection(event){
	if (event.change == 0) event.playMenuSFX = false;
	FlxTween.globalManager.completeTweensOf(portrait);
	var val = event.value;
	curSelectReal[FlxG.save.data.freeplaything]=val;
	for (i in grpSongs2){
		i.targetY = i.ID - val;
		i.targetY == 0 ? i.alpha = 1 : i.alpha = 0.6;
	}

	for (i in 0...iconArray2.length) iconArray2[i].alpha = 0.6;
    iconArray2[val].alpha = 1;
	shadering(val);
	FlxTween.tween(portrait,{y: portrait.y + 45,angle: 5},0.2,{ease:FlxEase.quintIn, onComplete:function(twn:FlxTween){
		portrait.loadGraphic(preload[val]);
		shadering(val,"hand");
		portrait.screenCenter();
		var mfwY = portrait.y;
		portrait.y -= 20;
		portrait.angle = -5;
		FlxTween.tween(portrait, {y: mfwY, angle: 0}, 0.4, {ease: FlxEase.elasticOut});
	}});
}