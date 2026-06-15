import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle as BS;
import openfl.text.TextFormat;
import flixel.util.FlxStringUtil;
import funkin.backend.system.framerate.Framerate;

var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var timeText:FunkinText;
var noe;
var currentTimingShown:FlxText;

public var hideTime:Bool = false;
var ratingStuff:Array<Dynamic> = [
    ['D', 0.2], 
    ['C', 0.6],
    ['B', 0.7],
    ['A', 0.8],
    ['A.', 0.85],
    ['A:', 0.9],
    ['AA', 0.93], 
    ['AA.', 0.965],
    ['AA:', 0.99],
    ['AAA', 0.997],
	['AAA.', 0.998],
	['AAA:', 0.999],
	['AAAA', 0.99955],
	['AAAA.', 0.9997],
	['AAAA:', 0.9998],
	['AAAAA', 0.99935]
];

function getRating():String {
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC():String {
	var ratingFC = "FC";
    if (misses == 0)  {
        if (accuracy == 1.0) ratingFC = "MFC";
        else if (accuracy >= 0.99) ratingFC = "GFC";
    } else  {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
	
	return ratingFC;
}
var dnb=(PlayState.SONG.meta.displayName.toLowerCase() == 'slammed' || PlayState.SONG.meta.displayName.toLowerCase() == 'holy-shit-dave-fnf');
var swordEngine = (["Tristan","Dave","Bambi"])[Math.floor(Math.random()*3)];
function postCreate() {
	currentTimingShown = new FlxText(FlxG.width * 0.6 - 420, (FlxG.height * 0.5) - 6 + 320);
	add(currentTimingShown);
	
	var watermark:FlxText;
	watermark = new FlxText();
	watermark.setFormat(Paths.font(dnb?"comic.ttf":"vcr.ttf"));
	watermark.text = PlayState.SONG.meta.displayName + " - " + PlayState.difficulty.toUpperCase() + " | ";
	watermark.text+=StringTools.endsWith(curSong, "classic") ? "KE 1.5.4 (ron eidtion)" : swordEngine + " Engine (KE 1.2)";
	watermark.color = FlxColor.WHITE;
	watermark.size = 16;
	watermark.setBorderStyle(BS.OUTLINE, FlxColor.BLACK, 1);
	watermark.borderSize = 1.25;
	watermark.y = FlxG.height - 18;
	watermark.cameras = [camHUD];
	add(watermark);
	
	infotxt = new FunkinText(healthBarBG.x + 110, FlxG.height - 18);
	add(infotxt);
	
	for(text in [scoreTxt, missesTxt, accuracyTxt])
		text.visible = false;
		
	timeBarBG = CoolUtil.loadAnimatedGraphic(new FlxSprite(0, FlxG.height * 0.02), Paths.image('game/healthBar'));
	timeBarBG.screenCenter(0x01);
	add(timeBarBG);

	timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), inst, 'time', 0, inst.length);
	timeBar.createFilledBar(FlxColor.fromRGB(128, 128, 128), FlxColor.fromRGB(0, 255, 0));
	timeBar.numDivisions = timeBar.width;
	add(timeBar);

	songName = new FunkinText(timeBarBG.x, timeBarBG.y, Std.int(timeBarBG.width), PlayState.SONG.meta.displayName, 16);
	songName.alignment = 'center';
	add(songName);

	for (e in [timeBarBG, timeBar, songName, infotxt, currentTimingShown]) {
		e.cameras = [camHUD];
	}
	remove(comboGroup, true); 
	comboGroup.x -= 420;
	comboGroup.y += 320;
}

function postUpdate()
{
	var ratements = "(" + getRatingFC() + ") " + getRating();
	if (accuracy == -1)
		ratements = "N/A";
	
	infotxt.text = "Score:" + songScore + " | Combo Breaks:" + misses + " | Accuracy:" + FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2) + "% | " + ratements;
    comboGroup.cameras = [camHUD];
    add(comboGroup);
}

function onCountdown(event)
{
	if (event.spritePath != null) event.spritePath = event.spritePath+'-kade';
	
	if (event.soundPath != null) event.soundPath = event.soundPath+'-kade';
}

function onPostCountdown(event) {
	event.spriteTween?.cancel();
	
	if(event.sprite==null)return;
	var spr = event.sprite;
	spr.cameras = [camHUD];

	spr.zoomFactor = 0;
	spr.scale.set(0.8, 0.8);
	FlxTween.tween(event.sprite, {alpha: 0}, Conductor.crochet / 1000, { ease: FlxEase.cubeInOut,
		onComplete: function(twn:FlxTween)
		{
			spr.destroy();
			remove(spr, true);
		}
	});
}

function onPlayerHit(e)
{
	e.preventLastSustainHit();
	e.ratingSuffix = "-kade";
	
	if (!e.note.isSustainNote) {
		switch(e.rating) {
			default: currentTimingShown.color = FlxColor.RED;
			case "good": currentTimingShown.color = FlxColor.GREEN;
			case "sick": currentTimingShown.color = FlxColor.CYAN;
		}
		
		currentTimingShown.borderStyle = BS.OUTLINE;
		currentTimingShown.borderSize = 1;
		currentTimingShown.borderColor = FlxColor.BLACK;
		currentTimingShown.text = FlxMath.roundDecimal(Conductor.songPosition - e.note.strumTime, 3) + "ms";
		currentTimingShown.size = 20;

		FlxTween.globalManager.cancelTweensOf(currentTimingShown);
		currentTimingShown.alpha = 1;
		FlxTween.tween(currentTimingShown, {alpha: 0}, 0.1, {startDelay: 0.15});
	}
}

function onPostNoteCreation(e) {
	//trace(e.noteSprite);
    e.note.gapFix = -32;
	e.note.forceIsOnScreen = true;
	e.note.clipRect = 0;
}

function onDadHit(e) e.preventStrumGlow();