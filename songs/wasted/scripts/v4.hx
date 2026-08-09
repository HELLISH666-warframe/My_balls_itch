function beatHit(curBeat) {
	if (curBeat >= 80 && curBeat < 143||curBeat >= 210 && curBeat < 270){
		for (i in 0...4) { 
			for (guh in [playerStrums, cpuStrums]) {
				var member = guh.members;
				if (curBeat % 2 == 0) {
					FlxTween.cancelTweensOf(guh.members[1]);
					FlxTween.cancelTweensOf(guh.members[3]);
					guh.members[3].angle=guh.members[1].angle=180;
                    FlxTween.tween(guh.members[1], {angle: 0}, 0.3, {ease: FlxEase.circOut});
                    FlxTween.tween(guh.members[3], {angle: 0}, 0.3, {ease: FlxEase.circOut});
				}
				else{
					FlxTween.cancelTweensOf(guh.members[0]);
					FlxTween.cancelTweensOf(guh.members[2]);
					guh.members[0].angle=guh.members[2].angle=-180;
                    FlxTween.tween(guh.members[0], {angle: 0}, 0.3, {ease: FlxEase.circOut});
                    FlxTween.tween(guh.members[2], {angle: 0}, 0.3, {ease: FlxEase.circOut});
				}
			}
		}
	}
	switch(curBeat){
		case 48:camSpeed = 8;
	}
}
function postCreate() {
	for (i in cpuStrums.members) i.noteAngle=0;
	for (i in playerStrums.members) i.noteAngle=0;
	camSpeed = 8;
}
function onPostNoteCreation(e) e.note.forceIsOnScreen = true;