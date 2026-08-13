import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.MusicBeatSubstate;
import funkin.menus.GitarooPause;
import flixel.ui.FlxButton;
import CustomFadeTransition;
import funkin.backend.utils.DiscordUtil;
import StringTools;

import ron.menus.MusicPlayer;
import ron.menus.runtabtest;
import ron.menus.Winver;

var time:Float = 0;
var chrom = new CustomShader("chromatic aberration");
var rainbowscreen,sanstitre;
var icons:Map<String, Dynamic> = [
	"discord" => "https://discord.gg/ron-874366610918473748",
	"random" => "https://www.facebook.com",
	"settings" => new OptionsMenu(),
	"freeplay" => new GitarooPause(),
	"story mode" => "story mode is idiot",
	"credits" => new CreditsMain(),
];
public var curClicked:String = "";
var clickAmounts:Int = 0;
var buttons:Array<FlxButton> = [];
var clicked:Bool = false;
var ywindow:Float = FlxG.height/2-203;

//RunTab_shit.
var tab,ok,cancel,exit,help;
var t = Paths.getSparrowAtlas("menus/windowsUi/run tab");
var white:FunkinSprite = new FunkinSprite(50, 640).makeSolid(280, 25, FlxColor.WHITE);
var typeText:FunkinText = new FunkinText(58, 643, 270, "|", 18, false);
function create() {
	DiscordUtil.changePresenceSince("In the desktop", null);
	CustomFadeTransition.nextCamera = FlxG.camera;
	CoolUtil.playMenuSong();
	var iconI:Int = 0;
	var iconFrames = Paths.getFrames("menus/desktop/menuIcons");
	var rainbTmr = new FlxTimer().start(0.005, function(tmr:FlxTimer)
	{
		rainbowscreen.x += (Math.sin(time)/5)+2;
		rainbowscreen.y += (Math.cos(time)/5)+1;
		sanstitre.setPosition(rainbowscreen.x,rainbowscreen.y);
		tmr.reset(0.005);
	});
	add(sanstitre = new FlxBackdrop(Paths.image('menus/desktop/sanstitre'), FlxAxes.XY, 0, 0));
	add(rainbowscreen = new FlxBackdrop(Paths.image('menus/desktop/rainbowpcBg'), FlxAxes.XY, 0, 0));
	add(new FlxSprite().loadGraphic(Paths.image("menus/desktop/pcBg")));
	if (FlxG.save.data.crt)FlxG.camera.addShader(crt = new CustomShader("fake CRT"));
	if (FlxG.save.data.colour) {FlxG.camera.addShader(bit = new CustomShader("8bitcolor"));
	bit.enablethisbitch = 1.;}
	if (FlxG.save.data.chrom) FlxG.camera.addShader(chrom);
	
	add(window = CoolUtil.loadAnimatedGraphic(new FlxSprite(FlxG.width/1.3-405,ywindow),Paths.image('menus/desktop/menuCarNew'))).angle = 3;
	FlxTween.tween(window, {y: ywindow + 10, angle: -3}, 1, {ease: FlxEase.circInOut, type: 4});
	window.scale.set(1.5,1.5);

	for (i in icons.keys()) {
		var button:FlxButton;
		button = new FlxButton((iconI > 2 ? 180 : 20), 20 + (150 * (iconI > 2 ? iconI - 3:iconI)), "", function() {
			if (curClicked != i) {
				clickAmounts = 0;
				curClicked = i;
				for (i in buttons) i.color = 0xffffff;
			}
			if (curClicked == i) {
				clickAmounts++;
				button.color = 0xFF485EC2;
				if (clickAmounts == 2) {
					FlxG.mouse.visible = false;
					if (icons[i] == "story mode is idiot") {FlxG.switchState(new ModState('ron/stupid_fucking-video_thing'));}
					else icons[i].length != 0 ? CoolUtil.openURL(icons[i]) : FlxG.switchState(icons[i]);
				}	
			}
			clicked = true;
		});
		button.frames = iconFrames;
		for(s in ["normal","highlight","pressed"]) button.animation.addByPrefix(s, i);
		add(button).allowSwiping = false;
		buttons.push(button);
		iconI++;
	}
}

function update(elapsed:Float) {
	time += elapsed;
	chrom.rOffset = chromeOffset*Math.sin(time);
	chrom.bOffset = -chromeOffset*Math.sin(time);
	if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * elapsed;

	if (controls.SWITCHMOD||FlxG.keys.justPressed.SEVEN) {
		import funkin.menus.ModSwitchMenu; import funkin.editors.EditorPicker;
		controls.SWITCHMOD ? openSubState(new ModSwitchMenu()) :openSubState(new EditorPicker());
		persistentUpdate = !persistentDraw;
	}

	if (clickAmounts != 2) FlxG.mouse.visible = true;
	if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.R)
		urtab=new runtabtest().acceptCode = function(e) {acceptCode(e);}
}

function beatHit()if(typeText.text=="|") typeText.visible =!typeText.visible;

function acceptCode(e) {
	switch (e) {
        case "teevee": CoolUtil.openURL("https://youtu.be/X9hIJDzo9m0");
		case "ron": #if windows Sys.command("start RON.exe"); #end
		case "full"|"full version"|"2.5"|"3.0"|"demo 3"|"next demo":CoolUtil.openURL("https://youtu.be/pNzGTCEmf3U");
		case "2012": rainbowscreen.visible = false; FlxG.sound.play(Paths.sound('vine'));
		case "winver":winVer = new Winver();case "cdplayer"|'s': cdPlayer = new MusicPlayer();
		FlxG.sound.music.volume = 0.01;
		case "passionatedevs": //FlxG.save.data.rtxMode = !FlxG.save.data.rtxMode;
		FlxG.camera.addShader(rtx = new CustomShader("NVIDIA RTX Architecture"));
		case "ron-b"|'b-ron'|'flip':PlayState.loadSong('ron-bside', 'normal'); FlxG.switchState(new PlayState());
		case "wasted-b":PlayState.loadSong('wasted-bside', 'normal'); FlxG.switchState(new PlayState());
		case "week2":PlayState.loadSong('atelophobia', 'hard'); FlxG.switchState(new PlayState());
		case "peak"|"ron undertale" |"for old times sake"|'week2'|'trouble'|'black-hole':
			var songIndex = ["peak" => "awesome-ron", "ron undertale" => "haemorrhage", "for old times sake" => "oneirophobia",'week2'=>'atelophobia','trouble'=>'trouble','black-hole'=>'anti-piracy'];
			PlayState.loadSong(songIndex[e], 'hard');
		FlxG.switchState(new PlayState());
		default: 
		CoolUtil.openURL(e);
	}
}

function destroy() {
	FlxG.sound.keysAllowed=true;
}