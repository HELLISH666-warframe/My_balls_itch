//stolen_from_internet_oddities_pending_removal
var noteSkin=['default','default'];

function create(){
    switch(PlayState.SONG.meta.displayName){
        case 'ron'|'wasted'|'ayo'|'Bloodshed'|'trojan-virus'|'ron-classic'|'wasted-classic'|'Ayo-classic'|
        'trojan-virus-classic'|'gron'|'Bijuu'|'lights-down-remix'|'certified-champion'|'rong-aisle'|
        'cluster-funk'|'oh-my-god-hes-ballin'|'awesome-ron': noteSkin[0] = 'RON_NOTES';
        case 'Bloodshed-classic'|'bleeding-classic'|'Bleeding': noteSkin[0] = 'ronhell';
        case 'Bloodbath'|'Bloodshed-legacy-redux': noteSkin[0] = 'demon';
        case 'difficult-powers': noteSkin[0] = 'NOTEold_assets';
        noteSkin[1] = 'demon';
        case 'holy-shit-dave-fnf': noteSkin[0] = 'NOTEold_assets';
        noteSkin[1] = 'NOTEold_assets';
        case 'slammed': noteSkin[0] = 'NOTEold_assets';
        noteSkin[1] = 'RON_NOTES';
        case 'ron-dsides': noteSkin[0] = 'conall';
        case 'official-debate': noteSkin[1] = 'RON_NOTES';
        case 'Ron B-Sides'|'Wasted B-Sides': noteSkin[0] = 'evik';
    }
}

function onNoteCreation(e) {if(!Assets.exists(Paths.image('game/notes/'+ noteSkin[e.strumLineID])))return;
    e.noteSprite = "game/notes/" + noteSkin[e.strumLineID];
}

function onStrumCreation(e) {if(!Assets.exists(Paths.image('game/notes/'+ noteSkin[e.player])))return;
    e.sprite = "game/notes/" + noteSkin[e.player];
}

switch(PlayState.SONG.meta.displayName){
    case 'official-debate'|'difficult-powers'|'slammed':
function onPlayerHit(_) {
    _.showSplash=false;
}
}