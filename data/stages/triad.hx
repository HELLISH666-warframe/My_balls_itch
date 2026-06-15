import flixel.addons.display.FlxBackdrop as BD;

var chrom = new CustomShader("chromatic aberration");
var fish = new CustomShader("fisheye");
var bgMove = new FlxTimer();
var bg = new BD(Paths.image('stages/triad/nomajin'), FlxAxes.XY, 0, 0);
var bgt = new BD(Paths.image('stages/triad/majinother'), FlxAxes.XY, 0, 0);

function new(){
    defaultCamZoom = 0.75;
    bg.scale.set(2,2);
    bgt.scale.set(2,2);
	bg.scrollFactor.set(0.5,0.5);
    bgt.scrollFactor.set(0.5,0.5);
    add(bg);
    add(bgt).visible=false;
    if (FlxG.save.data.chrom) {FlxG.camera.addShader(chrom);
        chrom.rOffset=chromeOffset/2;
        chrom.bOffset=chromeOffset * -1/2;
    }
    FlxG.camera.addShader(fish);
    fish.MAX_POWER = 0.2;
				

    bgMove.start(0.005, function(tmr:FlxTimer) {
		bg.x += 2;
		bg.y += 1;
		bgt.x += 3;
		bgt.y += 2;
		tmr.reset(0.005);
	});
}

function postCreate() {
    dad.x -= 375;
    boyfriend.scrollFactor.set(0.3,0.1);
    stage.stageSprites.set('bgt',bgt);
}