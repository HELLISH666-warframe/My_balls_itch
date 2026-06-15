import flixel.addons.display.FlxBackdrop as BD;

function postCreate(){
    cloud = new BD(Paths.image('stages/street/ron_clouds'),FlxAxes.X);
    cloud.scrollFactor.set(0.1,0.1);
    cloud.screenCenter(FlxAxes.XY);
    cloud.setPosition(-800,-800);
    FlxTween.tween(cloud, {x: cloud.x + 6000}, 720, {type: FlxTween.LOOPING});
    stage.stageSprites.set('cloud',cloud);
    insert(members.indexOf(sky)+1,cloud);

    cloudss = new BD(Paths.image('stages/street/ron_clouds'), FlxAxes.X);
	cloudss.scale.set(0.5,0.5);
	cloudss.updateHitbox();
	cloudss.scrollFactor.set(0.05,0.1);
	cloudss.screenCenter(FlxAxes.XY);
	cloudss.y -= 120;
    stage.stageSprites.set('cloudss',cloudss);
    insert(members.indexOf(cloud)+1,cloudss);

    FlxTween.tween(cloudss, {x: cloudss.x + 3000}, 360, {type: FlxTween.LOOPING});
    for(i in stage.stageSprites.keys())
        if(StringTools.contains(i.toLowerCase(),'wasted')) stage.getSprite(i).visible=false;
}