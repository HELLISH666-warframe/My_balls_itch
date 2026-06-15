//Re-code_this_later_ok?
import Sys;
import flixel.ui.FlxButton;

var buttons:Array<FlxButton> = [];

var rgrb = new FlxCamera();

public var curClicked:String = "";

var icons:Map<String, Dynamic> = ["ok" => "ok","cancel" => "cancel"];

function postCreate(){
	FlxG.sound.play(Paths.sound("error"));
	FlxG.mouse.visible = true;
	rgrb.bgColor = 0x00000000;
	FlxG.cameras.add(rgrb, false);
	add(startMenu = new FlxSprite(487, 307).loadGraphic(Paths.image("menus/windowsUi/wuhoh"))).camera=rgrb;

	var iconI:Int = 0;
	
	for (i in icons.keys()) {
		var button:FlxButton;
		button = new FlxButton((iconI > 0 ? 560 : 653), 365, "", function() {
			if (curClicked != i) curClicked = i;
			if (curClicked == i) {
				if (icons[i] == "ok") {
					FlxG.sound.play(Paths.sound("shutDown"));
					new FlxTimer().start(1, ()-> Sys.exit(0));}
				if (icons[i] == "cancel") {
				close();}
			}
			clicked = true;
		});
		button.frames = Paths.getSparrowAtlas("menus/windowsUi/run tab");
		button.animation.addByPrefix("highlight", icons[i] + " highlighted");
		button.animation.addByPrefix("normal", icons[i] + " neutral");
		button.animation.addByPrefix("pressed", icons[i] + " pressed");
		button.allowSwiping = false;
		add(button).camera=rgrb;
		buttons.push(button);
		iconI++;
	}
}