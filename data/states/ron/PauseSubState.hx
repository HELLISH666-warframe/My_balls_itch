import funkin.backend.utils.FunkinParentDisabler;
import funkin.options.keybinds.KeybindsOptions;
import funkin.editors.charter.Charter;
import funkin.options.OptionsMenu;
import Sys;

var optionArray = [["resume song","restart song","settings","shut down","log off"],
["change binds","change options"]];
var curSelPause = [0,0];
var menu = 0;
var optionButtons = [[],[]];
var pauseMusic = FlxG.sound.load(Paths.music('tstpwyptg'), 0, true);
var bit = new CustomShader("8bitcolor");
var camPause = new FlxCamera();
function postCreate(){
	add(parentDisabler = new FunkinParentDisabler());

	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
    
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	add(startMenu = new FlxSprite(0, 720).loadGraphic(Paths.image("menus/pause/start menu"))).y -= startMenu.height;
	for (i in 0...optionArray[0].length) {
		var button = new FlxSprite(25, (723 - startMenu.height) + (34 * i) + (i > 1 ? 120 : 0)+ if(i > 2) 115);
		button.frames = Paths.getSparrowAtlas("menus/pause/"+optionArray[0][i]);
		button.animation.addByPrefix("unselect", optionArray[0][i] + " unselect");
		button.animation.addByPrefix("select", optionArray[0][i] + " select");
		button.ID = i;
		add(button);
		button.animation.play("unselect");
		optionButtons[0].push(button);
	}

	for (i in 0...optionArray[1].length) {
		var sub_button = new FlxSprite(194, (498) + (25 * i));
		sub_button.frames = Paths.getSparrowAtlas("menus/pause/"+optionArray[1][i]);
		sub_button.animation.addByPrefix("unselect", optionArray[1][i] + " unselect");
		sub_button.animation.addByPrefix("select", optionArray[1][i] + " select");
		sub_button.ID = i;
		add(sub_button).alpha=0;
		sub_button.animation.play("unselect");
		optionButtons[1].push(sub_button);
	}
	cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	if (FlxG.save.data.colour){FlxG.camera.addShader(bit);
		PlayState.instance.camHUD.addShader(bit);
		bit.enablethisbitch = 1.;}
}
function update(elapsed:Float) {
	if (pauseMusic.volume < .5)	pauseMusic.volume += elapsed * .01;
	for (i in optionButtons[menu]) {
		if (i.ID == curSelPause[menu]) {i.animation.play("select");
        if (controls.ACCEPT) {
            switch (optionArray[menu][i.ID]){
				case "resume song":close();
				case "restart song":FlxG.resetState();
				case "settings":new FlxTimer().start(0.01, ()-> menu=optionButtons[1][0].alpha=optionButtons[1][1].alpha=1);
				curSelPause[1]=0;
				case "shut down":Sys.exit(0);
				case "log off":PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;
				if (PlayState.chartingMode && Charter.undos.unsaved) PlayState.instance.saveWarn(false);
				else if(PlayState.isStoryMode) FlxG.switchState(new MainMenuState());
				else FlxG.switchState(new FreeplayState());
				case "change binds":openSubState(new KeybindsOptions());
				case "change options":FlxG.switchState(new OptionsMenu((_) -> FlxG.switchState(new PlayState())));
				}
			}
		}
		else i.animation.play("unselect");
	}
	if (controls.BACK&&menu==1) menu=optionButtons[1][0].alpha=optionButtons[1][1].alpha=0;
	if (controls.UP_P||controls.DOWN_P){
		changeOption(controls.UP_P ? -1 :1);
		FlxG.sound.play(Paths.sound('scrollFunny'), 0.6);
	}
}
function changeOption(p) curSelPause[menu] = FlxMath.wrap(curSelPause[menu] + p, 0, optionArray[menu].length-1);
function destroy(){
	PlayState.instance.camHUD.removeShader(bit);
    FlxG.camera.removeShader(bit);
    FlxG.sound.destroySound(pauseMusic);
	FlxG.cameras.remove(camPause);
}