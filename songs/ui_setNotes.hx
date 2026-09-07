if(PlayState.SONG.meta.customValues.noteSkins==null)return;
var noteName;
function onNoteCreation(e) {
	if(e.strumLineID>SONG.meta.customValues.noteSkins.length)return;
	e.noteSprite = "game/notes/"+SONG.meta.customValues.noteSkins[e.strumLineID];
}
function onStrumCreation(e) {
	if(e.player>SONG.meta.customValues.noteSkins.length-1)return;
	e.sprite = "game/notes/"+SONG.meta.customValues.noteSkins[e.player];
}

function onPlayerHit(e) {
	e.showSplash=SONG.meta.customValues.noteSkins[e.note.strumID]=='NOTEold_assets'||SONG.meta.customValues.noteSkins[e.note.strumID]=='default';
}