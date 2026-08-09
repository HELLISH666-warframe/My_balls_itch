if(PlayState.SONG.meta.customValues.noteSkins==null)return;
var noteName;
function onNoteCreation(e) {
	if(e.strumLineID>PlayState.SONG.meta.customValues.noteSkins.length)return;
	e.noteSprite = "game/notes/"+PlayState.SONG.meta.customValues.noteSkins[e.strumLineID];
}
function onStrumCreation(e) {
	if(e.player>PlayState.SONG.meta.customValues.noteSkins.length-1)return;
	e.sprite = "game/notes/"+PlayState.SONG.meta.customValues.noteSkins[e.player];
}