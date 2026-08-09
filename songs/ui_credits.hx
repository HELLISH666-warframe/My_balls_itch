/*
| - Reformated by @ItsLJcool - |
*/
//and_messed_up_by_me_ear
import flixel.text.FlxTextBorderStyle;

// if you want to have this toggled in the `meta.json` file, uncomment this line
// showCredits = (PlayState?.instance?.SONG?.meta?.customValues?.showCredits ?? showCredits);

var curSong:String = PlayState.SONG.meta.name;
public var showCredits:Bool =Assets.exists(Paths.file("songs/" + curSong + "/credits.txt"));
var credits:FlxText;
var creditBG:FlxSprite;
function postCreate() {
// init shit bruh
var creditPath = Paths.file("songs/" + curSong + "/credits.txt");
var creditText = "ItsLJcool stole the credits";
if (Assets.exists(creditPath)) creditText = Assets.getText(creditPath);

credits = new FlxText(0, 0, 0, creditText);
credits.setFormat(Paths.font("w95.otf"), 24, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
credits.scrollFactor.set();
credits.screenCenter();

add(creditBG = new FlxSprite().makeGraphic(600, FlxG.height + 10, FlxColor.BLACK)).screenCenter();
creditBG.scrollFactor.set();
creditBG.alpha = 0.0001; // renders but doesn't show. if it's 0, then it doesn't render.

creditBG.camera = credits.camera = camHUD;
}

function onSongStart() {
    if (!showCredits) return;
    add(credits);
    // ??
    var targety:Int = 0;
    targety = Std.int(credits.y);
    credits.y = FlxG.camera.scroll.y+FlxG.height+40;
    FlxTween.tween(credits, {y: targety}, 0.5);
    var coolDestroy = (spr:FlxSprite) -> {
    credits.destroy();
    };
    FlxTween.tween(creditBG, {alpha: 0.5}, 0.5);
    for (die in [credits, creditBG]) FlxTween.tween(die, {alpha: 0}, 0.5, {startDelay: 5, onComplete: coolDestroy});
}