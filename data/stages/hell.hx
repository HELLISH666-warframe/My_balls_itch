importScript("data/scripts/bloodbleed-shit");

function postCreate() {
	firebg.alpha = 0;
	firebg.scrollFactor.set();
	firebg.screenCenter();
	satan.y -= 100;
	satan.updateHitbox();
	satan.screenCenter(FlxAxes.XY);
	satan.x -= 60;
	add(satan);
}
function stepHit(curStep:Int) {
	Estatic.alpha = (((2-health)/3)+0.2);
}