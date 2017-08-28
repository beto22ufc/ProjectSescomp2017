function inscreveEvento(evento){
    if(isNumeric(evento) && evento>0){
        $.get("/ArtemisTCC/inscreveEvento", {evento: evento
        }, function (data) {
            $('.btn-inscricao-evento').html(data);
        });
    }else{
        alert("Evento inválido!");
    }
}

function desfazInscricaoEvento(evento, inscricao){
    if(isNumeric(evento) && (evento>0) && isNumeric(inscricao) && (inscricao>0)){
        $.get("/ArtemisTCC/desfazerInscricaoEvento", {evento: evento, inscricao: inscricao
        }, function (data) {
            $('.btn-inscricao-evento').html(data);
        });
    }else{
        alert("Evento ou inscrição inválidos!");
    }
}

function inscreveEvento(atividade){
    if(isNumeric(atividade) && atividade>0){
        $.get("/ArtemisTCC/inscreveAtividade", {atividade: atividade
        }, function (data) {
            $('.btn-inscricao-evento').html(data);
        });
    }else{
        alert("Evento inválido!");
    }
}

function desfazInscricaoAtividade(atividade, inscricao){
    if(isNumeric(atividade) && (atividade>0) && isNumeric(inscricao) && (inscricao>0)){
        $.get("/ArtemisTCC/desfazerInscricaoAtividade", {atividade: atividade, inscricao: inscricao
        }, function (data) {
            $('.btn-inscricao-evento').html(data);
        });
    }else{
        alert("Evento ou inscrição inválidos!");
    }
}

function isNumeric(num){
    return (typeof num === "number");
}