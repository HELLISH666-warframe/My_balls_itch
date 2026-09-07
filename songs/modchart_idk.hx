public var strumLineNotes = [];
public var defaultStrumX:Array<Float> = [50,162,274,386,690,802,914,1026];

function postCreate() {
	for (i in cpuStrums.members){strumLineNotes.push(i);}
    for (i in playerStrums.members) {strumLineNotes.push(i);}
    for(i in 0...strumLines.length)strumLines.members[i].forEach((a) -> {a.noteAngle=0;});
	for(i in 0...strumLineNotes.length) defaultStrumX[i]=strumLineNotes[i].x;

	for(i in 0...strumLines.length){
		if(!strumLines.members[i].visible)return;
		for(l in 0...strumLines.members[i].members.length)
		strumLines.members[i].members[l].extraCopyFields=['alpha'];
	}
}