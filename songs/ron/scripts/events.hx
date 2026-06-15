var rain = new CustomShader("rain");
rain.data.iTime.value=rain.data.opacity.value=[0];

function update(elapsed:Float) rain.iTime +=elapsed;

function postCreate(){				
	insert(members.indexOf(gf),blackeffect = new FlxSprite(-180,-100).makeSolid(FlxG.width*1.5, FlxG.width*1.5, FlxColor.BLACK)).alpha = 0;
	blackeffect.scrollFactor.set(0,0);
}
function stepHit(curStep){
	if (curStep >= 272 && curStep <= 1304) {
		for(s in [playerStrums,cpuStrums])
		if (curStep % 8 == 0){
			for (i in 0...4){
			FlxTween.globalManager.completeTweensOf(s);
			s.members[i].y+=20;
			FlxTween.tween(s.members[i], {y: 50}, 0.65, {ease: FlxEase.backOut});}
		    }
		}
	if (curStep == 540||curStep == 604||curStep == 668||curStep == 732||curStep == 1304)
		FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.4, {ease: FlxEase.backOut});
	switch (curStep) {
		case 272:FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		case 1304:
		boyfriend.color = gf.color = 0xFFdbcfb3;
		fxtwo = new FlxSprite().loadGraphic(Paths.image('stages/effect'));
		fxtwo.scale.set(0.75, 0.75);
		fxtwo.updateHitbox();
		fxtwo.antialiasing = true;
		fxtwo.screenCenter();
		fxtwo.scrollFactor.set(0, 0);
		add(fxtwo).alpha = 0.2;
		fxtwo.camera = camHUD;
		FlxG.camera.flash(FlxColor.WHITE, 1, null, true);
		for(i in stage.stageSprites.keys()) stage.getSprite(i).visible = !stage.getSprite(i).visible;
		if (!FlxG.save.data.rain)return;
		FlxG.camera.addShader(rain);
		rain.zoom=35;
		rain.raindropLength=0.075;
		rain.opacity=0.2;
		case 1568: FlxTween.tween(blackeffect, {alpha: 1}, 0.5, {ease: FlxEase.circInOut});
		FlxTween.tween(rain, {opacity: 0}, 0.5, {ease: FlxEase.circOut});
		case 1600: FlxTween.tween(blackeffect, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
		FlxTween.tween(rain, {opacity: 0.2}, 0.5, {ease: FlxEase.circInOut});
	}
}