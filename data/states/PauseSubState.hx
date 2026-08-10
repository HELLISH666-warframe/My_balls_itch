import Sys;
import funkin.options.OptionsMenu;
import funkin.editors.charter.Charter;
import funkin.options.keybinds.KeybindsOptions;
import funkin.backend.utils.FunkinParentDisabler;

var optionArray = ["resume song", "restart song", "shut down", "log off"];
var curSelected = 0;
var optionButtons = [];
var pauseMusic = FlxG.sound.load(Paths.music('tstpwyptg'), 0, true);
var bit = new CustomShader("8bitcolor");
var camPause = new FlxCamera();
function postCreate(){
	add(parentDisabler = new FunkinParentDisabler());

	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
    
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	add(startMenu = new FlxSprite(0, 720).loadGraphic(Paths.image("menus/windowsUi/start menu"))).y -= startMenu.height;
	for (i in 0...optionArray.length) {
		var button = new FlxSprite(25, (723 - startMenu.height) + (34 * i) + (i > 1 ? 270 : 0));
		button.frames = Paths.getSparrowAtlas("menus/windowsUi/win98buttons");
		button.animation.addByPrefix("unselect", optionArray[i] + " unselect");
		button.animation.addByPrefix("select", optionArray[i] + " select");
		button.ID = i;
		add(button);
		button.animation.play("unselect");
		optionButtons.push(button);
	}
	cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	if (FlxG.save.data.colour){FlxG.camera.addShader(bit);
		PlayState.instance.camHUD.addShader(bit);
		bit.enablethisbitch = 1.;}
}
function update(elapsed:Float) {
	if (pauseMusic.volume < .5)	pauseMusic.volume += elapsed * .01;
	if (FlxG.keys.justPressed.P) FlxG.switchState(new OptionsMenu((_) -> FlxG.switchState(new PlayState())));
	if (FlxG.keys.justPressed.C) openSubState(new KeybindsOptions());
	for (i in optionButtons) {
		if (i.ID == curSelected) {i.animation.play("select");
        if (controls.ACCEPT) {
            var choice = optionArray[i.ID];
            switch (choice){
					case "resume song": close();
					case "restart song": FlxG.resetState();
					case "log off":
						PlayState.deathCounter = 0;
						PlayState.seenCutscene = false;
						if (PlayState.chartingMode && Charter.undos.unsaved) PlayState.instance.saveWarn(false);
						else if(PlayState.isStoryMode) FlxG.switchState(new MainMenuState());
						else FlxG.switchState(new FreeplayState());
					case "shut down":Sys.exit(0);
				}
			}
		}
		else i.animation.play("unselect");
	}
    if (controls.DOWN_P){curSelected += 1; FlxG.sound.play(Paths.sound('scrollFunny'), 0.6);}
    if (controls.UP_P) {curSelected -= 1; FlxG.sound.play(Paths.sound('scrollFunny'), 0.6);}
    curSelected = (curSelected > optionArray.length - 1 ? 0 : (curSelected < 0 ? optionArray.length - 1 : curSelected));
}
function destroy(){
	PlayState.instance.camHUD.removeShader(bit);
    FlxG.camera.removeShader(bit);
    FlxG.sound.destroySound(pauseMusic);
	FlxG.cameras.remove(camPause);
}