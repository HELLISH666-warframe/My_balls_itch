var healthLoss:Float = health -= 0.02;
function onDadHit(e){
	var multiplier:Float = 1;
	switch (dad.curCharacter) {
		case 'hellron'|'classichellron'|'bloodshedron'|'bloodbathnew':
		health >= 1 ? multiplier = 1 : multiplier += (1 - health);

		camHUD.shake((0.0055 * multiplier / 4) / 2, 0.15);
		FlxG.camera.shake(0.025 * multiplier / 4, 0.1);
		health > 0.05*healthLoss+.01 ? health -= 0.05*healthLoss : health = 0.05*healthLoss;
		case 'hellron-drippin'|'dripronclassic': 
		health >= 1 ? multiplier = 1 : multiplier += (1 - health);

		FlxG.camera.shake(0.025 * multiplier / 4, 0.1);
		camHUD.shake(0.0055 * multiplier / 4, 0.15);
		health > 0.1*healthLoss ? health -= 0.1*healthLoss : health = 0.02*healthLoss;
	}
}
function beatHit(){
    if ((dad.curCharacter == 'hellron-drippin'||dad.curCharacter == 'dripronclassic')&& curBeat % 2 == 0){
	var multiplier:Float = 1;
    health >= 1 ? multiplier = 1 : multiplier += (1 - health);
    FlxG.camera.shake(0.025 * multiplier / 4, 0.1);
    camHUD.shake(0.0055 * multiplier / 4, 0.15);
    health > 0.5*healthLoss ? health -= 0.5*healthLoss : health = 0.03*healthLoss;

    iconP2.angle = 0;
    FlxTween.cancelTweensOf(iconP2);
    FlxTween.tween(iconP2, {angle: 359.99}, Conductor.crochet / 1200 * 2, {ease: FlxEase.circOut});
    iconP2.alpha = (2-(health)-0.25)/2+0.2;
    iconP1.alpha = (health-0.25)/2+0.2;        
    }
}