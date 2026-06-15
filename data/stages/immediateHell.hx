function postCreate() {
	hellbg.setGraphicSize(Std.int(hellbg.width * 5));
	hellbg.y += hellbg.height/ 5;
    satan.setGraphicSize(Std.int(satan.width * 1.2));
	satan.screenCenter();
	satan.updateHitbox();

	mountainsbackbl.alpha=hellbg.alpha = satan.alpha = islands.alpha = firebg.alpha =0;
}
function beatHit(curBeat){
	switch (curBeat){
	case 96:
		city.destroy();
		street.destroy();
		mountains.destroy();
		firebg.screenCenter();	
		satan.color = FlxColor.BLACK;
		wbg.alpha = 0.66;
		satan.alpha = hellbg.alpha = islands.alpha = firebg.alpha =1;

		FlxTween.angle(satan, 0, 359.99, 1.5, 
			{ease: FlxEase.quadIn, onComplete: function(twn:FlxTween) 
				{FlxTween.angle(satan, 0, 359.99, 0.75, {type: FlxTween.LOOPING});}});	
				
		FlxTween.tween(satan, {y: gf.y - 500}, 1, {ease: FlxEase.backInOut});
	case 352:
		wbg.destroy();
		FlxTween.globalManager.completeTweensOf(satan);
		FlxTween.angle(satan, 0, 359.99, 0.33, { type: FlxTween.LOOPING } );
	case 416:
		FlxTween.tween(islands,{y: islands.y + 25},1,{ease: FlxEase.circInOut,type: FlxTween.PINGPONG});
	case 480:
		satan.color = FlxColor.WHITE;
		FlxTween.tween(hellbg,{alpha: 0},1,{ease: FlxEase.circInOut});
		FlxTween.tween(firebg,{alpha: 0},1,{ease: FlxEase.circInOut});
		FlxTween.cancelTweensOf(satan);
		FlxTween.angle(satan, satan.angle, 359.99, 0.5, {ease: FlxEase.quadIn});
	}
}
function destroy() {
	for(i in [wbg,hellbg,city,mountains,firebg,satan,street,islands])
	i.destroy();
}