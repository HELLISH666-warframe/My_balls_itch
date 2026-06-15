function postCreate(){ 
	iconP2.flipX=iconP1.flipX=true;
	gf.visible = stage.getSprite("nothing").visible = false;
}
function beatHit(curBeat) {
	switch(curBeat) {
		case 246:
		dad.color = boyfriend.color = FlxColor.BLACK;
		camGame.flash(FlxColor.WHITE, 1);
		stage.getSprite("bg").visible=false;
		stage.getSprite("nothing").visible=true;
		case 278:
		camGame.flash(FlxColor.WHITE, 1);
		dad.color = boyfriend.color = FlxColor.WHITE;
		gf.visible = stage.getSprite("bg").visible=true;
		stage.getSprite("nothing").visible=false;
		case 294:
		camGame.flash(FlxColor.WHITE, 1);
		iconP2.setIcon('trump');
		remove(iconP1);
		insert(members.indexOf(iconP2)+1, iconP1);
		barbg2.color=0xE08B73;
	}
}
function postUpdate(elapsed){	
	var center:Float = healthBar.x + healthBar.width * FlxMath.remapToRange(healthBar.percent, 100, 0, 1, 0);

	iconP1.x = center - (iconP1.width - 26);
	iconP2.x = center - 26;
}
function onPlayerHit(_) {
    _.showSplash=false;
}