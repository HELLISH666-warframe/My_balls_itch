import Sys;
import funkin.options.OptionsMenu;
import funkin.editors.charter.Charter;
import flixel.group.FlxTypedSpriteGroup;
import funkin.options.keybinds.KeybindsOptions;
import funkin.backend.utils.FunkinParentDisabler;

var optionArray = [["resume song","restart song","settings","shut down","log off"],
["Change binds","Change options"]];
var curSelPa = [0,0];
var menu = 0;
var optionButtons = [[],[]];
var testt = new FlxTypedSpriteGroup<FlxSprite>();
var pauseMusic = FlxG.sound.load(Paths.music('breakfast'), 0, true);
var bit = new CustomShader("8bitcolor");
var camPause = new FlxCamera();
function postCreate(){
	FlxG.mouse.visible = true;
	add(parentDisabler = new FunkinParentDisabler());

	camPause.bgColor = 0x00000000;
	FlxG.cameras.add(camPause, false);
    
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	add(startMenu = new FlxSprite(0, 305).loadGraphic(Paths.image("menus/windowsUi/start menu")));
	for (i in 0...optionArray[0].length) {
		var button = new FlxSprite(25, (723 - startMenu.height) + (34 * i) + (i > 1 ? 120 : 0)+ if(i > 2) 115);
		button.frames = Paths.getSparrowAtlas("menus/windowsUi/win98buttons");
		button.animation.addByPrefix("unselect", optionArray[0][i] + " unselect");
		button.animation.addByPrefix("select", optionArray[0][i] + " select");
		button.ID = i;
		add(button);
		button.animation.play("unselect");
		button.updateHitbox();
		optionButtons[0].push(button);
		testt.add(button);
	}

	for (i in 0...optionArray[1].length) {
		var sub_button = new FlxSprite(194, (498) + (25 * i));
		sub_button.frames = Paths.getSparrowAtlas("menus/windowsUi/win98buttons");
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
	if (pauseMusic.volume < .5) pauseMusic.volume += elapsed * .01;
	for (i in optionButtons[menu]) {
		if (i.ID == curSelPa[menu]) {i.animation.play("select");
        if (controls.ACCEPT) {
            switch (optionArray[menu][i.ID]){
				case "resume song": close();
				case "restart song": FlxG.resetState();
				case "settings": new FlxTimer().start(0.01, ()-> menu=optionButtons[1][0].alpha=optionButtons[1][1].alpha=1);
				curSelPa[1]=0;
				case "shut down":openSubState(new ModSubState("shut-down"));
				case "log off":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;
					if (PlayState.chartingMode && Charter.undos.unsaved) PlayState.instance.saveWarn(false);
					else if(PlayState.isStoryMode) FlxG.switchState(new ModState("DesktopState"));
					else FlxG.switchState(new FreeplayState());

				case "Change binds": openSubState(new KeybindsOptions());
				case "Change options": FlxG.switchState(new OptionsMenu((_) -> FlxG.switchState(new PlayState())));
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
	if (FlxG.keys.justPressed.O)FlxG.camera.removeShader(bit);

	if(menu==1)return;
	testt.forEach(function (folder) {
        if (FlxG.mouse.overlaps(folder)&&FlxG.mouse.justPressed) {
            if (curSelPa != folder.ID) {
                changeOption(folder.ID-curSelPa);
            }
        }
    });
}
function destroy(){
	PlayState.instance.camHUD.removeShader(bit);
    FlxG.camera.removeShader(bit);
    FlxG.sound.destroySound(pauseMusic);
	FlxG.cameras.remove(camPause);
}
function changeOption(p) curSelPa[menu] = FlxMath.wrap(curSelPa[menu] + p, 0, optionArray[menu].length-1);