import flixel.math.FlxRect;
var useKade=StringTools.endsWith(curSong, "classic")||(curSong == 'slammed' || curSong == 'holy-shit-dave-fnf');

public var healthBarBG1 = new FlxSprite();
public var healthBarBG2 = new FlxSprite();

public function evilbar() {
    for(i in [healthBarBG1,healthBarBG2]){
        i.loadGraphic(Paths.image("game/healthbar/healthBarintheworks2"));
        i.x-=100; i.y-=35;
    }
    iconP1.y = iconP2.y -= 6;
    healthBarBG1.color = boyfriend.iconColor; healthBarBG2.color = dad.iconColor;
    for(score in [scoreTxt,missesTxt,accuracyTxt]) score.visible=false;
}

function create() {
    for(i in [healthBarBG1,healthBarBG2]){
        i.loadGraphic(Paths.image('game/healthbar/healthBarintheworks'));
        i.screenCenter(FlxAxes.X);
        i.y = FlxG.height * 0.87;
        i.scale.set(1,.85);
    }
}
function postUpdate(elapsed:Float)
    healthBarBG1.clipRect = new FlxRect((2-health)/2*healthBarBG1.width,0,health/2*healthBarBG1.width,healthBarBG1.height);
function postCreate() {
    missesTxt.font=accuracyTxt.font=scoreTxt.font=Paths.font("w95.otf");
    if (!useKade){
        healthBarBG.alpha = healthBar.alpha=0.0001;
    
        healthBarBG1.color = boyfriend.iconColor; healthBarBG2.color = dad.iconColor;
        for(i in [healthBarBG1,healthBarBG2]) insert(0,i).cameras = [camHUD];
    }
}
function onEvent(_) {
	if (_.event.name == 'Change Character')
        new FlxTimer().start(.01,()->{healthBarBG1.color=boyfriend.iconColor;healthBarBG2.color=dad.iconColor;});
}

importScript("data/scripts/huds/"+if(useKade)'kade'else'psych');