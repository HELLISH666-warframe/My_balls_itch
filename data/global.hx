allowGitaroo = false;
public static var modSave;
var rtxShader = new CustomShader('NVIDIA RTX Architecture');
function new() {
    FlxG.save.data.Vs_Ron_V3point1_save??={};
    modSave=FlxG.save.data.Vs_Ron_V3point1_save;
    modSave.glitch ??= true;
    modSave.chrom ??= true;
    modSave.chromeOffset ??= 0.5;
    modSave.mosaic ??= true;
    modSave.crt ??= true;
    modSave.colour ??= true;
    modSave.grey ??= true;
    modSave.vhs ??= true;
    modSave.rain ??= true;
    modSave.rtx ??= false;
    modSave.warning ??= true;
    modSave.website ??= true;
    modSave.TimeBar ??= "Disabled";
    Flags.DISABLE_WARNING_SCREEN=!modSave.warning;
}
import funkin.backend.system.Flags;
public static var chromeOffset = (modSave.chromeOffset/350);

public static function makeTheModGood(onOrNot:Bool) {
    if(onOrNot) FlxG.game.addShader(rtxShader);
    else FlxG.game.removeShader(rtxShader);
}

function preStateSwitch() if(FlxG.save.data.rtx)makeTheModGood(false);

function postStateSwitch() if(FlxG.save.data.rtx)makeTheModGood(true);