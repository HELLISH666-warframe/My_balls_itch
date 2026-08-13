import haxe.io.Path;
allowGitaroo = false;
function new() {   
    FlxG.save.data.glitch ??= true;
    FlxG.save.data.chrom ??= true;
    FlxG.save.data.chromeOffset ??= 0.5;
    FlxG.save.data.mosaic ??= true;
    FlxG.save.data.crt ??= true;
    FlxG.save.data.colour ??= true;
    FlxG.save.data.grey ??= true;
    FlxG.save.data.vhs ??= true;
    FlxG.save.data.rain ??= true;
    FlxG.save.data.rtx ??= false;
    FlxG.save.data.warning ??= true;
    FlxG.save.data.website ??= true;
    FlxG.save.data.TimeBar ??= "Disabled";

    FlxG.mouse.useSystemCursor = false;
    FlxG.mouse.load(Assets.getBitmapData(Paths.image('menus/cursor')),1,1,1);
    FlxG.mouse.visible = false;

    for (i in Paths.getFolderContent('data/global')) importScript("data/global/"+Path.withoutExtension(i)); //import different global scripts for organization reasons
}
import funkin.backend.system.Flags;
Flags.DISABLE_WARNING_SCREEN=!FlxG.save.data.warning;
public static var chromeOffset = (FlxG.save.data.chromeOffset/350);

var rtxShader = new CustomShader('NVIDIA RTX Architecture');
public static function makeTheModGood(onOrNot:Bool) {
    if(onOrNot) FlxG.game.addShader(rtxShader);
    else FlxG.game.removeShader(rtxShader);
}

function preStateSwitch() if(FlxG.save.data.rtx)makeTheModGood(false);

function postStateSwitch() if(FlxG.save.data.rtx)makeTheModGood(true);

//Test
function update() {
    if (FlxG.keys.pressed.SHIFT && FlxG.keys.pressed.H)
        FlxG.switchState(new ModState('ron/test'));
        //FlxG.switchState(new ModState('tco/credits_test',{"videoName": 'tco_credits',"canSkip":false}));
}

function destroy(){
    FlxG.mouse.useSystemCursor = true;
    FlxG.mouse.visible = false;
    if(FlxG.save.data.rtx)
    FlxG.game.removeShader(rtxShader);
}