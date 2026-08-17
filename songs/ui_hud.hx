import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.Flags;
import flixel.util.FlxStringUtil;
import flixel.math.FlxRect;
import flixel.ui.FlxBar;

public var timeTxt;
public var timeBarBG;
public var timeBar;
var songLength = FlxG.sound.music.length;
var updateTime:Bool = true;

public var healthBarBG1 = new FlxSprite();
public var healthBarBG2 = new FlxSprite();

public function evilbar() {
    for(i in [healthBarBG1,healthBarBG2]){
        i.loadGraphic(Paths.image("game/healthbar/healthBarintheworks2"));
        i.x-=100; i.y-=35;
    }
    iconP1.y = iconP2.y -= 6;
    healthBarBG1.color = boyfriend.iconColor; healthBarBG2.color = dad.iconColor;
}

function create() {
    for(i in [healthBarBG1,healthBarBG2]){
        i.loadGraphic(Paths.image('game/healthbar/healthBarintheworks'));
        i.screenCenter(FlxAxes.X);
        i.y = FlxG.height * 0.87;
        i.scale.set(1,.85);
    }

    var showTime:Bool = (FlxG.save.data.TimeBar != 'Disabled');
    timeTxt = new FlxText(42 + (FlxG.width / 2) - 248, 19, 400,curSong);
	timeTxt.setFormat(Paths.font("w95.otf"), 32, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	timeTxt.scrollFactor.set();
	timeTxt.alpha = 0;
	timeTxt.borderSize = 2;
	timeTxt.visible = showTime;

    updateTime = showTime;

    timeBarBG = new FlxSprite().loadGraphic(Paths.image('game/timeBar'));
	timeBarBG.x = timeTxt.x;
	timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
	timeBarBG.scrollFactor.set();
    timeBarBG.alpha = 0;
	timeBarBG.visible = showTime;
	timeBarBG.color = FlxColor.BLACK;
	add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, 'LEFT_TO_RIGHT', Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), null, '', 0, 1);
	timeBar.scrollFactor.set();
	timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
	timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
    timeBar.alpha = 0;
	timeBar.visible = showTime;
	add(timeBar);
    add(timeTxt);
    for(i in [timeBar,timeTxt,timeBarBG])i.camera=camHUD;

    if(FlxG.save.data.TimeBar == 'Song Name') {
		timeTxt.size = 24;
		timeTxt.y += 3;
	}
}

function update(elapsed:Float) {
    if(!updateTime)return;
    var songCalc:Float = (songLength - Conductor.songPosition);
    if(FlxG.save.data.TimeBar == "Time Elapsed") songCalc = Conductor.songPosition;
	if(songCalc < 0) songCalc = 0;
    if(FlxG.save.data.TimeBar != 'Song Name')
    timeTxt.text = FlxStringUtil.formatTime(songCalc/1000, false);
    timeBar.percent = (Conductor.songPosition/songLength)*100;
}

function postUpdate(elapsed:Float)
    healthBarBG1.clipRect = new FlxRect((2-health)/2*healthBarBG1.width,0,health/2*healthBarBG1.width,healthBarBG1.height);
function postCreate() {
    missesTxt.font=accuracyTxt.font=scoreTxt.font=Paths.font("w95.otf");
    if (!StringTools.endsWith(curSong, "classic")){
        healthBarBG.alpha = healthBar.alpha=0.0001;
    
        healthBarBG1.color = boyfriend.iconColor; healthBarBG2.color = dad.iconColor;
        for(i in [healthBarBG1,healthBarBG2]) insert(0,i).cameras = [camHUD];
    }
}

function onSongStart()
    for(i in [timeTxt,timeBarBG,timeBar])
    FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

function onEvent(_) {
	if (_.event.name == 'Change Character')
        new FlxTimer().start(.01,()->{healthBarBG1.color=boyfriend.iconColor;healthBarBG2.color=dad.iconColor;});
}

if (StringTools.endsWith(curSong, "classic")||(curSong == 'slammed' || curSong == 'holy-shit-dave-fnf')){
	add(kadeshit = new FlxText(20, FlxG.height * 0.9 +50, 0, curSong+" - Hard | ")).camera = camHUD;
	var swordEngine = (["Tristan","Dave","Bambi"])[Math.floor(Math.random()*3)];
	kadeshit.text += StringTools.endsWith(curSong, "classic") ? "KE 1.5.4 (ron eidtion)" : swordEngine + " Engine (KE 1.2)";
	StringTools.endsWith(curSong, "classic") ? 
	kadeshit.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE,FlxColor.BLACK) : kadeshit.setFormat(Paths.font("comic.ttf"), 16,  FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
}