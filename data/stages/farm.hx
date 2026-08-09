function postCreate() {
    flatgrass.updateHitbox();
	farmHouse.updateHitbox();
    var bagType = FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag';
    cornBag.loadGraphic(Paths.image("stages/farm/"+bagType));
}