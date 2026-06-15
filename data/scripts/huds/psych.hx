//Scoring gutted since it doesn't need it.
import flixel.text.FlxTextBorderStyle as BS;
import flixel.util.FlxStringUtil;
import flixel.ui.FlxBar;
public var timeTxt;
public var timeBarBG;
public var timeBar;
var songLength = FlxG.sound.music.length;
var updateTime:Bool = true;
function create() {
    var showTime:Bool = (FlxG.save.data.TimeBar != 'Disabled');
    timeTxt = new FlxText(42 + (FlxG.width / 2) - 248, 19, 400,curSong);
	timeTxt.setFormat(Paths.font("w95.otf"), 32, FlxColor.WHITE, 'center', BS.OUTLINE, FlxColor.BLACK);
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

function onSongStart() for(i in [timeTxt,timeBarBG,timeBar])
    FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});