//LET_ME_EXTEND_FLXGROUP_PLEASE_CODENAME
//GENUNINTLY_AWFUL_CODE_I_JUST_WANTED_SOMETHING_DONE_QUICK_OK?
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
class Winver extends FunkinSprite {
	var w = new FlxTypedGroup();
	public var ok:FlxButton;
	public var exit:FlxButton;
	public var tabBar:FlxButton;
    
    public function new() {
        super(55, 55);

		loadGraphic(Paths.image("menus/windowsUi/winver"));

		tabBar = new FlxButton(55, 55, "");
		tabBar.width = 305;
		tabBar.height = 20;
		tabBar.alpha = 0;
		tabBar.allowSwiping = true;
		w.add(tabBar);
		w.add(this);
		ok = new FlxButton(175, 238, "", function() {destroy();});
		exit = new FlxButton(340, 60, "", ok.onUp.callback);
		for (i=>button in [ok,exit]) {
			button.frames = Paths.getSparrowAtlas("menus/windowsUi/run tab");
			var animIndex = ["ok", "exit"];
			button.animation.addByPrefix("normal", animIndex[i] + " neutral");
			button.animation.addByPrefix("highlight", animIndex[i] + " neutral");
			button.animation.addByPrefix("pressed", animIndex[i] + " pressed");
			button.updateHitbox();
			w.add(button);
		}
    }
    
	var justMousePos = FlxPoint.get();
	var justTaskBarPos = FlxPoint.get();
	var movingTab = false;
    override function update(_) {
        super.update(_);
		if (tabBar.status == 2) {
			if (FlxG.mouse.justPressed) {justMousePos = FlxG.mouse.getScreenPosition(); justTaskBarPos.set(x,y);movingTab = true;}
		}
		if (FlxG.mouse.justReleased) movingTab = false;
		if (movingTab) {
			setPosition(Math.round(FlxG.mouse.getScreenPosition().x - justMousePos.x) + justTaskBarPos.x, Math.round(FlxG.mouse.getScreenPosition().y - justMousePos.y) + justTaskBarPos.y);
			for (button in [ok, exit, tabBar]) {
				var offsetIndex = [ok => [120, 183],exit => [285, 6],tabBar => [0, 0]];
				button.setPosition(x + offsetIndex[button][0], y + offsetIndex[button][1]);
			}
		}
    }
	function destroy() {
		FlxG.state.remove(w,true);
		super.destroy();
	}
}