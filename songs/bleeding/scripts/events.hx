import flixel.addons.effects.FlxTrail;
import openfl.display.BlendMode;
importScript("data/scripts/bloodbleed-shit");
var rain = new CustomShader("rain");
var time = 0;
var glitch = new CustomShader("glitchsmh");
var bleed = new CustomShader("bleedingvhs");
var vhs = new CustomShader("vhs");
var bloodshedTrail = null;
exploders.scale.set(3.8, 3.8);

function postCreate(){
    evilbar();
    if (FlxG.save.data.rain){camGame.addShader(rain);rain.zoom = 40;
	rain.raindropLength = 0.1;rain.opacity = 0.25;
	}
    for (i in cpuStrums.members) i.noteAngle=0;
    boyfriend.color = gf.color = 0xFFBD7F77;
    bloodshedTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
	insert(members.indexOf(dad)-1,bloodshedTrail);
}
function update(elapsed:Float){time += elapsed;
    for(i in [glitch,bleed,rain,vhs])
        i.iTime=time;
}
function beatHit(curBeat){
    switch (curBeat) {
        case 64:for (i in 0...4){FlxTween.tween(playerStrums.members[i], {x: playerStrums.members[i].x - 320},1,{ease: FlxEase.linear});FlxTween.tween(cpuStrums.members[i],{x: cpuStrums.members[i].x - 1250,angle: cpuStrums.members[i].angle + 359},1,{ease: FlxEase.linear});}
        case 94:remove(bloodshedTrail);
        case 96:stage.getSprite('wbg').alpha = 0.66;
        Estatic.alpha=1;
        FlxTween.tween(Estatic.scale,{x:1.2,y:1.2},Conductor.crochet / 1000,{ease: FlxEase.quadInOut,type: FlxTween.PINGPONG});
        camGame.flash(FlxColor.WHITE, 1);
		if (FlxG.save.data.glitch){camGame.addShader(glitch);glitch.on = 1.;}
        stage.getSprite('mountainsbackbl').visible=stage.getSprite('city').visible=stage.getSprite('mountains').visible=false;
        stage.getSprite('satan').color = FlxColor.BLACK;
		stage.getSprite('firebg').alpha = 1;
		stage.getSprite('firebg').screenCenter();
		if (FlxG.save.data.vhs)camHUD.addShader(vhs);
		if (FlxG.save.data.chrom){camGame.addShader(chrom);
			chrom.data.rOffset.value = [chromeOffset*Math.sin(curStep*4)/2];
			chrom.data.bOffset.value = [chromeOffset*Math.sin(curStep*4) * -1/2];}
        bloodshedTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069); //nice
        insert(members.indexOf(dad)-1, bloodshedTrail);

        dad.y -= 220;
		dad.x -= 230;
		boyfriend.y -= 230;
		boyfriend.x += 300;

        FlxTween.angle(stage.getSprite('satan'), 0, 359.99, 1.5, {ease: FlxEase.quadIn, 
			onComplete: function(twn:FlxTween) {
				FlxTween.angle(stage.getSprite('satan'), 0, 359.99, 0.75, {type: FlxTween.LOOPING});}});

        explode();
        exploders.visible = cameramovebleed = true;
        stage.getSprite('street').visible = false;
		stage.getSprite('islands').alpha = 1;
        FlxTween.tween(stage.getSprite('satan'), {y: gf.y - 500}, 1, {ease: FlxEase.backInOut});
        FlxTween.tween(gf,{y: gf.y + 800, angle: 45},1,{ease: FlxEase.quadIn});
        healthBar.setGraphicSize(800,Std.int(healthBar.height));
        case 160:cameramovebleed = gf.visible = false;
        case 352:explode();
        cameramovebleed = true;
        stage.getSprite('wbg').alpha = 0;

        FlxTween.globalManager.completeTweensOf(stage.getSprite('satan'));
        FlxTween.angle(stage.getSprite('satan'), 0, 359.99, 0.33, {type: FlxTween.LOOPING});
        case 416:camGame.flash(FlxColor.WHITE, 1);
		cameramovebleed = false;
		intensecameramovebleed = true;
        camHUD._filters = [];
		if (FlxG.save.data.vhs)camHUD.addShader(bleed);
		Estatic.color = FlxColor.BLACK;
		Estatic.blend = BlendMode.NORMAL;
		defaultCamZoom -= 0.1;
        FlxTween.tween(stage.getSprite('islands'), {y: stage.getSprite('islands').y + 25}, 1, {ease: FlxEase.circInOut, type: FlxTween.PINGPONG});
		FlxTween.tween(dad, {y: dad.y + 25}, 1, {ease: FlxEase.circInOut, type: FlxTween.PINGPONG});
		FlxTween.tween(boyfriend, {y: boyfriend.y + 25}, 1, {ease: FlxEase.circInOut, type: FlxTween.PINGPONG});
        case 480:Estatic.color = FlxColor.RED;
        stage.getSprite('satan').color = FlxColor.WHITE;
        camHUD._filters = [];
        camGame.flash(FlxColor.WHITE, 1);
        FlxTween.tween(stage.getSprite('hellbg'), {alpha: 0}, 1, {ease: FlxEase.circInOut});
		FlxTween.tween(stage.getSprite('firebg'), {alpha: 0}, 1, {ease: FlxEase.circInOut});
        FlxTween.cancelTweensOf(stage.getSprite('satan'));
        FlxTween.angle(stage.getSprite('satan'), stage.getSprite('satan').angle, 359.99, 0.5, {ease: FlxEase.quadIn});
		defaultCamZoom += 0.1;
    }
    if (curStep > 384) {
        chrom.rOffset=chromeOffset*Math.sin(curStep*4)/2;
        chrom.bOffset=chromeOffset*Math.sin(curStep*4) * -1/2;
	}
}
function explode(){
    exploders.animation.play('explosion');
    FlxG.sound.play(Paths.sound('hellexplode'), 0.7);
}