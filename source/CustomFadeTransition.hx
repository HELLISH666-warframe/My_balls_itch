import flixel.math.FlxPoint;
import flixel.addons.transition.Transition;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileCircle;
import flixel.addons.transition.FlxTransitionSprite.TransitionStatus;
import flixel.addons.transition.TransitionData;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.graphics.FlxGraphic;
import funkin.backend.MusicBeatSubstate;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	public var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	public var isTransIn:Bool = false;
	public var transBlack:FlxSprite;
	public var transGradient:FlxSprite;

	public function new(duration:Float, isTransIn:Bool) {
		super();

		trace(duration);
		this.isTransIn = isTransIn;
		var zoom:Float = FlxMath.bound(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);
		transGradient = new FlxSprite().makeGraphic(width, height, FlxColor.BLACK);
		transGradient.scrollFactor.set();

		transBlack = new FlxSprite().makeGraphic(width, height + 400, FlxColor.BLACK);
		transBlack.scrollFactor.set();

		transGradient.x -= (width - FlxG.width) / 2;
		transBlack.x = transGradient.x;

		var transData = new TransitionData(cast "tiles", 0xFF000000, duration, new FlxPoint(0,1));
		transData.tileData = {width: 32, height: 32, asset: FlxGraphic.fromBitmapData(new GraphicTransTileCircle(0, 0, true, 0xFF000000))};
		var transitional = new Transition(transData);
		FlxG.state.add(transitional);
		new FlxTimer().start(duration, function(tmr:FlxTimer) {if(!isTransIn && finishCallback != null)finishCallback(); else close();});
		transitional.setStatus(isTransIn?TransitionStatus.FULL:TransitionStatus.EMPTY);
		transitional.start(isTransIn?TransitionStatus.OUT:TransitionStatus.IN);

		if(nextCamera != null) {
			transBlack.cameras = [nextCamera];
			transGradient.cameras = [nextCamera];
			transitional.cameras = [nextCamera];
		}
	}

	override function update(elapsed:Float) {
		if(isTransIn) {
			transBlack.y = transGradient.y + transGradient.height;
		} else {
			transBlack.y = transGradient.y - transBlack.height;
		}
		super.update(elapsed);
		if(isTransIn) {
			transBlack.y = transGradient.y + transGradient.height;
		} else {
			transBlack.y = transGradient.y - transBlack.height;
		}
		trace("dgbre");
	}

	public override function destroy() {
		if(leTween != null) {
			trace("Fuck");
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}