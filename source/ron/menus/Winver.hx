//LET_ME_EXTEND_FLXGROUP_PLEASE_CODENAME
//GENUNINTLY_AWFUL_CODE_I_JUST_WANTED_SOMETHING_DONE_QUICK_OK?
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;

class Winver extends FlxButton {
  var ok:FlxButton;
  var exit:FlxButton;

  var group = new FlxTypedGroup();

  override function new(?x:Float, ?y:Float):Void {
    super(x, y);

    loadGraphic(Paths.image("menus/windowsUI/winver"));

    alpha = 0;
    allowSwiping = true;

    ok = makeButton(175, 238, 0, destroy);
    exit = makeButton(300, 60, 1, destroy);
  }

  override function update(elapsed:Float):Void {
    super.update(elapsed);

    // Positioning logic, blah, blah, blah.
  }

  override function destroy():Void {
    group.forEach(function(button:FlxButton) {
      button.destroy();
    });

    super.destroy();
  }

  function makeButton(x:Float, y:Float, index:Int, callback:Void -> Void):FlxButton {
    var button:FlxButton = new FlxButton(x, y, null, callback);

    button.frames = Paths.getFrames("menus/windowsUI/run tab");
    button.animation.addByPrefix("normal", '${index} neutral');
    button.animation.addByPrefix("pressed", '${index} pressed');

    group.add(button);

    return button;
  }
}