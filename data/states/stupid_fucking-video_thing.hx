import hxvlc.flixel.FlxVideoSprite;
function create() {
	FlxG.sound.music.fadeOut(0.1, 0);
	var video = new FlxVideoSprite();
	video.load(Paths.video("ron"));
	add(video).play();
	video.x=99.5;
	video.bitmap.onEndReached.add(function(){
	PlayState.loadWeek({
	songs: [{name: 'ron'},{name: 'wasted'}, {name: 'ayo'}, {name: 'bloodshed'}, {name: 'trojan-virus'}]}, 'hard');
	PlayState.isStoryMode=true;
	FlxG.switchState(new PlayState());
	});
}