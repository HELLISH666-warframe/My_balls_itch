var grey = new CustomShader('grayscale');
function postCreate() {
    for(i in [camHUD,camGame]) i.addShader(grey); grey.enable=1;
}