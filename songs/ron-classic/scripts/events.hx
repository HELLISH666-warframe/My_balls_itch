function postCreate() iconP1.setIcon('oldbf');

function beatHit(curBeat) {
	switch(curBeat) {
		case 35:FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut});
		dad.playAnim('cheer', true);
		case 79|143|147|155|167|182:FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut});
	}
}