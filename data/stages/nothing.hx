function postCreate() {
    graadienter.color = FlxColor.BLACK;
    FlxTween.tween(scanlines, {alpha: 0.5}, 0.5, {ease: FlxEase.circInOut, type: FlxTween.PINGPONG});
    scanlines.active = false;
    scanlines.screenCenter();
    scanlines.visible=false;
    /*fx = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
	fx.setGraphicSize(Std.int(2560 * 0.75));
	fx.updateHitbox();
	fx.antialiasing = true;
	fx.scrollFactor.set(0, 0);
	fx.alpha = 0.75;	
	fx.screenCenter(FlxAxes.XY);
    insert(0,fx);*/
}
function stepHit(step) {
    switch (step) {
        case 256: graadienter.color = FlxColor.WHITE;
        case 768: scanlines.visible=true;
        graadienter.color = FlxColor.fromRGB(224,224,224);
        case 1280: remove(scanlines);
        graadienter.color = FlxColor.fromRGB(255,255,255);
    }
}