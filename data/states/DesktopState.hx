import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.MusicBeatSubstate;
import funkin.menus.GitarooPause;
import flixel.ui.FlxButton;
import CustomFadeTransition;
import funkin.backend.utils.DiscordUtil;
import StringTools;
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
var runTabBottons:Array<FlxButton> = [];
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
					if (icons[i] == "story mode is idiot") {FlxG.switchState(new ModState('ron/video_state'));}
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
	add(white);
	tab = new FlxSprite(0, 560);
	tab.frames = t;
	tab.animation.addByPrefix("d", "tab");
	add(tab).animation.play("d");
	add(typeText).color = FlxColor.BLACK;
	ok = new FlxButton(177, 685, "", ()-> {acceptCode(); kys();});
	cancel = new FlxButton(258, 685, "", ()-> {kys();});
	help = new FlxButton(308, 566, "", ()-> {CoolUtil.openURL("www.facebook.com");});
	exit = new FlxButton(327, 566, "", ()-> {kys();});
	for (i=>button in [ok, cancel, help, exit]) {
		button.frames = t;
		var animIndex = ["ok", "cancel", "help", "exit"];
		button.animation.addByPrefix("normal", animIndex[i] + " neutral");
		button.animation.addByPrefix("highlight", animIndex[i] + " neutral");
		button.animation.addByPrefix("pressed", animIndex[i] + " pressed");
		button.updateHitbox();
		runTabBottons.push(button);
		add(button);
	}
	exit.width=help.width-=58;
	kys();
}
var typing:Bool = false;
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
	if (FlxG.keys.pressed.CONTROL && FlxG.keys.justPressed.R && !typing) {
		giveBirth(); new FlxTimer().start(.001, ()->{typing = !typing;});
	}
}

var nonoKeys=[-1,9,13,15,16,17,18,20,27,37,38,39,40,187,192];
function postUpdate(elapsed:Float) {
	if(FlxG.keys.justPressed.ANY)
	trace(FlxG.keys.firstJustPressed());
	if (FlxG.keys.justPressed.ANY && typing && !nonoKeys.contains(FlxG.keys.firstJustPressed()) && FlxG.keys.firstJustPressed() <= 190) {
        if (typeText.text == "|") typeText.text = "";
        typeText.visible = true;
    
        if (FlxG.keys.justPressed.BACKSPACE && typeText.text != "|" && typeText.text != "")
            typeText.text = typeText.text.substr(0, typeText.text.length - 1);
        else if (typeText.text.length < 32)
            typeText.text += idk(CoolUtil.keyToString(FlxG.keys.firstJustPressed()).toLowerCase());

        if (typeText.text == "") typeText.text = "|";
    }
}

function idk(_:String) {
    return switch (_) {
        case "SPACE": " ";
        case "[←]": "";
		case "minus": "-";
        default: _;
    }
}

function giveBirth() {
	for(i in 0...4) for (fuck in [white,tab,typeText,runTabBottons[i]]){ fuck.alpha=1;
	fuck.active=true;
	}
}
function kys() {
	typing=false;for(i in 0...4) for (fuck in [white,tab,typeText,runTabBottons[i]]) {fuck.alpha=0;
		fuck.active=false;
	}
}
function beatHit()if(typeText.text=="|") typeText.visible =!typeText.visible;

function acceptCode() {
	switch (typeText.text) {
        case "teevee":CoolUtil.openURL("https://youtu.be/X9hIJDzo9m0");
		case "ron": #if windows Sys.command("start RON.exe"); #end
		case "full"|"full version"|"2.5"|"3.0"|"demo 3"|"next demo":CoolUtil.openURL("https://youtu.be/pNzGTCEmf3U");
		case "2012":rainbowscreen.visible = false;FlxG.sound.play(Paths.sound('vine'));
		case "winver":FlxG.state.add(new Winver());
		case "cdplayer": FlxG.state.add(new MusicPlayer()); FlxG.sound.music.volume = 0.01;
		case "passionatedevs":FlxG.save.data.rtx=!FlxG.save.data.rtx; makeTheModGood(FlxG.save.data.rtx);
		default:CoolUtil.openURL(typeText.text);
	}
}
