import ron.menus.MusicPlayer;
import ron.menus.runtabtest;
import ron.menus.Winver;

function new() {
    FlxG.stage.window.onKeyDown.add(onKeyDown);
	FlxG.stage.window.onTextInput.add(onTextInput);
}

private function onKeyDown(e:KeyCode, modifier:KeyModifier) {
	if (currentFocus != null) currentFocus.onKeyDown(e, modifier);
}

private function onKeyUp(e:KeyCode, modifier:KeyModifier) {
	if (currentFocus != null) currentFocus.onKeyUp(e, modifier);
}

private function onTextInput(str:String) {
	if (currentFocus != null) currentFocus.onTextInput(str);
}

public var hoveredSprite = null;
public var currentFocus = null;
function update() {
    if (FlxG.mouse.justReleased){
		currentFocus = (hoveredSprite is runtabtest) ? (cast hoveredSprite) : null;
        trace(hoveredSprite is runtabtest);
    }
    for(i in FlxG.state.members){
        if (i != null)
    if(actuallyOverlaps(i,FlxG.camera)&&Std.isOfType(i, Winver))trace(i);
    }
}

function destroy(){
    FlxG.stage.window.onKeyDown.remove(onKeyDown);
	FlxG.stage.window.onTextInput.remove(onTextInput);
}

public function isOverlapping(spr, rect:FlxRect) {
	var pos = FlxG.mouse.getScreenPosition(FlxG.camera, __point);

	if (((pos.x > __rect.x) && (pos.x < __rect.x + __rect.width)) && ((pos.y > __rect.y) && (pos.y < __rect.y + __rect.height))) {
		return true;
	}
	return false;
}

function actuallyOverlaps(sprite:FlxBasic, camera:FlxCamera) {
	var posthing = FlxG.mouse.getWorldPosition(camera);
	return FlxMath.inBounds(posthing.x, sprite.x, sprite.x + sprite.width) && FlxMath.inBounds(posthing.y, sprite.y, sprite.y + sprite.height);
}