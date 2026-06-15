//Kinda like the UOCM one but uhhh kind like uhhhh like uhhhhhh you ... uhhhh
import funkin.backend.assets.ModsFolder;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxSort;

var mods = CoolUtil.sortAlphabetically(ModsFolder.getModsList(), true);
var curSelected:Int = 0;

var subCam:FlxCamera;

var foldertext:FlxTypedGroup<FlxText>;
var folders:FlxTypedSpriteGroup<FlxSprite>;
var hitbox:FlxSprite;

function create() {
	camera = subCam = new FlxCamera();
	subCam.bgColor = 0xFFFFFFFF;
	FlxG.cameras.add(subCam, false);

	mods.push(null);
	changeSelection(0, true);

	if(FlxG.save.data.show_user_name){
	#if WINDOWS
	window.title="Browsing "+Sys.environment()["USERNAME"]+"'s pc.";
	#else
	window.title="Browsing "+Sys.environment()["USER"]+"'s pc.";
	#end
	}else window.title="Browsing Ronald Mcslide's pc.";

	foldertext = new FlxTypedGroup<FlxText>();
	folders = new FlxTypedSpriteGroup<FlxSprite>();

	for (i in 0...mods.length) {
		var text = new FlxText(0,0,100,mods[i] ==null ?"disableMods": mods[i],20);
		text.setFormat(Paths.font("w95.otf"),17,FlxColor.BLACK,'center');
		text.ID = i;
		text.x =40+ 120 * (text.ID % 10);
		text.y = 140 +140 * Math.floor(text.ID / 10);
		//Thanks betpowo!
		text.updateHitbox();
		foldertext.add(text);

		var folder = new FlxSprite().loadGraphic(Paths.image("menus/remove_later/modswitch/folder"));
		folder.setPosition(text.x+text.width-75,text.y-50);
		folder.setGraphicSize(50, 50);
		folder.updateHitbox();
		folder.ID = i;
		folders.add(folder);
	}
	add(foldertext);
    add(folders);

	add(back = new FlxSprite().loadGraphic(Paths.image('menus/remove_later/modswitch/ewdfhbruihb'))).camera=subCam;
	add(hitbox = new FlxSprite(1246, 5).makeSolid(30, 14, 0xE0000020)).alpha = 0;
	hitbox.width=60;
	hitbox.height=60;

	var objectsText = new FlxText(-20,700,100,mods.length+' object(s)',453);
	objectsText.setFormat(Paths.font("w95.otf"),15,FlxColor.BLACK,'right');
	add(objectsText).camera=subCam;

	if (FlxG.save.data.crt) subCam.addShader(cunvrehgu = new CustomShader("fake CRT"));
	//loadTheCursor('');
	trace(CoolUtil.getSizeString(FileSystem.stat(Paths.file("images/characters/dad.png")).size));
}
import sys.FileSystem;
import haxe.io.Bytes;
import sys.io.File;
public var onFile:(String, Bytes)->Void;
function update(elapsed:Float) {
	if (controls.BACK||(FlxG.mouse.overlaps(hitbox) && FlxG.mouse.pressed)) close();

	scrollCam(- FlxG.mouse.wheel);

	folders.forEach(function (folder) {
        if (FlxG.mouse.overlaps(folder)) {
            if (curSelected != folder.ID) {
                changeSelection(folder.ID-curSelected);
            }
            if (FlxG.mouse.justPressed){ModsFolder.switchMod(mods[curSelected]);
		    close();
			}
        }
    });
}

function changeSelection(change:Int, force:Bool = false) {
	if (change == 0 && !force) return;
	curSelected = FlxMath.wrap(curSelected + change, 0, mods.length-1);
}

function scrollCam(change:Int, force:Bool = false) {
	for(i in 0...folders.members.length) folders.members[i].y+=change*7;
	for(i in 0...foldertext.members.length) foldertext.members[i].y+=change*7;
}

function destroy() {
	window.title="vs literally every fnf fan mod ever";
	if (FlxG.save.data.crt) FlxG.camera.removeShader(cunvrehgu);
	FlxG.cameras.remove(subCam);
	FlxG.camera.bgColor = 0;
}