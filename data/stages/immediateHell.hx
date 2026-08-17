function postCreate() {
	hellbg.setGraphicSize(Std.int(hellbg.width * 5));
	hellbg.y += hellbg.height/ 5;
    satan.setGraphicSize(Std.int(satan.width * 1.2));
	satan.screenCenter(FlxAxes.XY);
	satan.y += 1000;
	satan.x -= 100;
	satan.updateHitbox();

	mountainsbackbl.alpha=hellbg.alpha = islands.alpha = firebg.alpha =0;
}