//UISTATE_CAN_GO_FUCKING_DIE.
import funkin.editors.ui.IUIFocusable;
import openfl.geom.Rectangle;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
using IUIFocusable;
class runtabtest extends FunkinSprite {
	public var tab,ok,cancel,exit,help;
	var t = Paths.getSparrowAtlas("menus/windowsUi/run tab");
	var cacheRect = new Rectangle();
    public var tab:FunkinSprite;
	public var typeText = new FunkinText(60, 644, 270, "", 18, false);
	public var caretSpr;
	var position:Int = 0;
	public var typing = false;
	public var added:Bool=false;

	public var acceptCode:String->Void;
    
    public function new() {
        super(59, 644);

		makeSolid(271, 17, FlxColor.WHITE);
        scrollFactor.set();
        
		tab = new FunkinSprite(0, 560);
		tab.frames = t;
		tab.animation.addByPrefix("d", "tab");
		tab.animation.play("d");
		ok = new FlxButton(177, 685, "", ()-> {acceptCode(); destroy();});
		cancel = new FlxButton(258, 685, "", ()-> {destroy();});
		help = new FlxButton(308, 566, "", ()-> {CoolUtil.openURL("www.facebook.com");});
		exit = new FlxButton(327, 566, "", ()-> {destroy();});
		for (i=>button in [ok, cancel, help, exit]) {
		button.frames = t;
		var animIndex = ["ok", "cancel", "help", "exit"];
		button.animation.addByPrefix("normal", animIndex[i] + " neutral");
		button.animation.addByPrefix("highlight", animIndex[i] + " neutral");
		button.animation.addByPrefix("pressed", animIndex[i] + " pressed");
		button.updateHitbox();
	}

	position = 1;

	caretSpr = new FlxSprite(0, 0);
	caretSpr.makeGraphic(1, 1, FlxColor.BLACK);
	caretSpr.scale.set(1, typeText.size);
	caretSpr.updateHitbox();

	typeText.font=Paths.font('w95.otf');
	typeText.color = FlxColor.BLACK;

	FlxG.stage.window.onKeyDown.add(onKeyDown);
	FlxG.stage.window.onTextInput.add(onTextInput);
    }

	public function huh() {
		FlxG.state.add(this);
		FlxG.state.add(tab);
		for (i=>button in [ok, cancel, help, exit]) FlxG.state.add(button);
		FlxG.state.add(caretSpr);
		FlxG.state.add(typeText);
		added=true;
	}
    
	var currentFocus=null;
    override function update(_) {
        super.update(_);
		//currentFocus = (FlxG.mouse.overlaps(this))?true:null;
		typing=(actuallyOverlaps(this,FlxG.camera)&&active);
		FlxG.sound.keysAllowed = !typing;

		if(actuallyOverlaps(typeText,FlxG.camera)&&active&&FlxG.mouse.justReleased){
			var pos = FlxG.mouse.getScreenPosition(FlxG.camera, FlxPoint.get());
			pos.x -= typeText.x;
			pos.y -= typeText.y;

			if (pos.x < 0) position = 0;
			else {
				var index = typeText.textField.getCharIndexAtPoint(pos.x, pos.y);
				if (index > -1) position = index;
				else position = typeText.text.length;
			}

			pos.put();
		}

		var off = (/*bHeight - */typing.height) / 2;
		if (typing) {
			caretSpr.alpha = (FlxG.game.ticks % 666) >= 333 ? 1 : 0;

			var curPos = switch(position) {
				case 0:FlxPoint.get(0, 0);
				default:
				if (position >= typeText.text.length) {
					typeText.textField.__getCharBoundaries(typeText.text.length-1, cacheRect);
					FlxPoint.get(cacheRect.x + cacheRect.width, cacheRect.y);
				} else {
					typeText.textField.__getCharBoundaries(position, cacheRect);
					FlxPoint.get(cacheRect.x, cacheRect.y);
				}
			}
			//caretSpr.follow(typeText, 4 + curPos.x, off + curPos.y);
			caretSpr.setPosition(typeText.x+ curPos.x, typeText.y+off + curPos.y);
			curPos.put();
		}else{
			caretSpr.alpha = 0;
		}
    }
	function onTextInput(text:String):Void {
		if(!typing)return;
		typeText.text = typeText.text.substr(0, position) + text + typeText.text.substr(position);
		position += text.length;
	}
	function changeSelection(change:Int) {
		position = FlxMath.wrap(position + change, 0, typeText.text.length);
	}
	//import lime.ui.KeyCode;
	function onKeyDown(e:KeyCode, modifier:KeyModifier) {
		if (!typing)return;
		/*trace(FlxG.keys.firstJustPressed());
		trace(e,CoolUtil.keyToString(e));*/
		switch(FlxG.keys.firstJustPressed()) {
			case 8:
			if (position > 0) {
				typeText.text = typeText.text.substr(0, position-1) + typeText.text.substr(position);
				changeSelection(-1);
			}
			case 13:acceptCode(typeText.text);
			case 37:changeSelection(-1);
			case 39:changeSelection(1);
		}
	}
	function destroy() {
		added=false;
		for(i in [typeText,caretSpr,tab,ok,cancel,exit,help]){FlxG.state.remove(i,true);i.kill();i.destroy();}
		FlxG.state.remove(this,true);
		super.destroy();
		trace("Wowie.");
		FlxG.stage.window.onKeyDown.remove(onKeyDown);
		FlxG.stage.window.onTextInput.remove(onTextInput);
		FlxG.sound.keysAllowed=true;
	}

	//Todo:MAKE_THIS_HAVE_AN_OFFSET_DEPENDING_ON_THE_GAME_WINDOW_SIZE.
	function actuallyOverlaps(sprite:FlxBasic, camera:FlxCamera) {
		var posthing = FlxG.mouse.getWorldPosition(camera);
		return FlxMath.inBounds(posthing.x, sprite.x, sprite.x + sprite.width) && FlxMath.inBounds(posthing.y, sprite.y, sprite.y + sprite.height);
	}
}