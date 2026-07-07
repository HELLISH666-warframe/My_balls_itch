import funkin.backend.utils.FunkinParentDisabler;
//import ron.CustomFadeTransition;

//CUSTOM_BULLSHIT.
import flixel.math.FlxPoint;
import flixel.addons.transition.Transition;
import flixel.addons.transition.FlxTransitionSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileCircle;
import flixel.addons.transition.FlxTransitionSprite.TransitionStatus;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;

var finishCallback:Void->Void;
var duration=newState != null?0.7:0.6;
function new() {
	//CUSTOM_BULLSHIT.
	var transData = new TransitionData(cast "tiles", 0xFF000000, duration);
	transData.direction=FlxPoint.get(0,1);
	transData.tileData = {width: 32, height: 32, asset: FlxGraphic.fromBitmapData(new GraphicTransTileCircle(0, 0, true, 0xFF000000))};
	var transitional = new Transition(transData);
	add(transitional);

	new FlxTimer().start(duration, function(tmr:FlxTimer) {if(transOut && finishCallback != null)finishCallback(); else finish();});

	transitional.setStatus(transOut?TransitionStatus.EMPTY:TransitionStatus.FULL);
	transitional.start(transOut?TransitionStatus.IN:TransitionStatus.OUT);
}

function create() {
    transitionTween.cancel();
    remove(blackSpr);
    remove(transitionSprite);
}

function postCreate() {
	for (thing in members) if (thing is FunkinParentDisabler) thing.destroy();
	for (i in FlxG.sound.list) if (i._paused) i.resume();//FUCK FunkinParentDisabler.
}