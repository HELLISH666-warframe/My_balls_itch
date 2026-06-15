function postCreate() {
    flatgrass.updateHitbox();
	farmHouse.updateHitbox();
    cornBag.loadGraphic(Paths.image("stages/farm/"+(FlxG.random.int(0, 1000) == 0 ? 'popeye' : 'cornbag')));
}