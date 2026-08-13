//UISTATE_CAN_GO_FUCKING_DIE.
import funkin.editors.ui.IUIFocusable;
import openfl.geom.Rectangle;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
using IUIFocusable;
class MusicPlayer extends FunkinSprite {
	var tabBar:FlxButton;
	var ronmusic:FlxSound;
	var ronmusicvox:FlxSound;
	var t = Paths.getSparrowAtlas("menus/windowsUi/so retro");
	var tab:FlxSprite;
	var play:FlxUIButton;
	var pause:FlxUIButton;
	var voices:FlxUIButton;
	var timer:FlxText;
	var militimer:FlxText;
	var dropDown/*:FlxUIDropDownMenu*/;
	var backward:FlxButton;
	var forward:FlxButton;
	var exit:FlxButton;
    
    public function new() {
		/*ronmusic = new FlxSound();
		ronmusic.loadEmbedded(Paths.inst("bleeding"));
		ronmusic.onComplete = function() {play.toggled = false;}
		FlxG.sound.list.add(ronmusic);
		ronmusicvox = new FlxSound();
		ronmusicvox.loadEmbedded(Paths.voices("bleeding"));
		FlxG.sound.list.add(ronmusicvox);
		ronmusicvox.volume = 0;*/
        super(250, 100);
		frames = t;
		animation.addByPrefix("t", "tab");
		animation.play("t");
		FlxG.state.add(this);
		
		exit = new FlxButton(this.x + 283, this.y + 5, "", function() {
			destroy();
			FlxG.sound.music.volume = 1;
		});
		exit.frames = Paths.getSparrowAtlas("menus/windowsUi/run tab");
		exit.animation.addByPrefix("normal", "exit neutral");
		exit.animation.addByPrefix("highlight", "exit neutral");
		exit.animation.addByPrefix("pressed", "exit pressed");
		FlxG.state.add(exit);

		timer = new FlxText(this.x + 61, this.y + 38, 0, "NO SONG PLAYING", 23);
		timer.color = 0xFF808000;
		timer.antialiasing = false;
		FlxG.state.add(timer);

		militimer = new FlxText(this.x + 17, this.y + 38, 0, "NO SONG PLAYING", 23);
		militimer.color = 0xFF808000;
		militimer.antialiasing = false;
		FlxG.state.add(militimer);

		backward = new FlxButton(this.x + 175, this.y + 54, function() {
			if (ronmusic.playing) ronmusic.time -= 3000;
		});

		forward = new FlxButton(this.x + 199, this.y + 54, function() {
			if (ronmusic.playing) {
				if (ronmusic.time + 3000 > ronmusic.length) ronmusic.stop();
				else ronmusic.time += 3000;
			}	
		});

		play = new FlxUIButton(this.x + 175, this.y + 27, function() {
			if (play.toggled) {
				if (pause.toggled) {
					pause.toggled = false;
					ronmusic.resume();
					ronmusicvox.resume();
				}
				else {ronmusic.play(); ronmusicvox.play();}
			}
			if (!play.toggled) {
				ronmusic.stop();
				ronmusicvox.stop();
			}
		});
    }
    override function update(_) {
        super.update(_);
    }
	function destroy() {
		for(i in [exit,timer,militimer]){FlxG.state.remove(i,true);i.kill();i.destroy();}
		FlxG.state.remove(this,true);
		super.destroy();
	}
}