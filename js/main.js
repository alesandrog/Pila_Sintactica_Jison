let input = ace.edit("input_editor");
let output = ace.edit("output_editor");


function analizar (){
    let res = CalculadoraHeredados.parse(input.getValue());
    output.setValue(res.toString());
}

function limpiar(){
    input.setValue("");
    output.setValue("");
}