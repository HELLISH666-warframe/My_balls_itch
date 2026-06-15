if (!Assets.exists(Paths.file("songs/" + curSong + "/credits.txt"))) return;
/*
| - Reformated by @ItsLJcool - |
*/
//and_messed_up_by_me_ear
import flixel.text.FlxTextBorderStyle as BS;

var credits:FlxText;
var creditBG:FlxSprite;
function postCreate() {
// init shit bruh
credits = new FlxText(0, 0, 0, Assets.getText(Paths.file("songs/" + curSong + "/credits.txt")));
credits.setFormat(Paths.font("w95.otf"), 24, FlxColor.WHITE, 'center', BS.OUTLINE, FlxColor.BLACK);
credits.scrollFactor.set();
credits.screenCenter();

add(creditBG = new FlxSprite().makeSolid(600, FlxG.height + 10, FlxColor.BLACK)).screenCenter();
creditBG.scrollFactor.set();
creditBG.alpha = 0.0001; // renders but doesn't show. if it's 0, then it doesn't render.

creditBG.camera = credits.camera = camHUD;
}

function onSongStart() {
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