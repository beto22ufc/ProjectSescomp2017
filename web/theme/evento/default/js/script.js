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
    var r = confirm("Deseja cancelar sua inscrição neste evento?");
    if (r === true) {
        if(isNumeric(evento) && (evento>0) && isNumeric(inscricao) && (inscricao>0)){
            $.get("/ArtemisTCC/desfazerInscricaoEvento", {evento: evento, inscricao: inscricao
            }, function (data) {
                $('.btn-inscricao-evento').html(data);
            });
        }else{
            alert("Evento e/ou inscrição inválidos!");
        }
    }
}

function inscreveAtividade(atividade){
    if(isNumeric(atividade) && atividade>0){
        $.get("/ArtemisTCC/inscreveAtividade", {atividade: atividade
        }, function (data) {
            $('.btn-inscricao-atividade-'+atividade+'').html(data);
        });
    }else{
        alert("Atividade inválida!");
    }
}

function desfazInscricaoAtividade(atividade, inscricao){
    var r = confirm("Deseja cancelar sua inscrição nesta atividade?");
    if (r === true) {
        if(isNumeric(atividade) && (atividade>0) && isNumeric(inscricao) && (inscricao>0)){
            $.get("/ArtemisTCC/desfazerInscricaoAtividade", {atividade: atividade, inscricao: inscricao
            }, function (data) {
                $('.btn-inscricao-atividade-'+atividade+'').html(data);
            });
        }else{
            alert("Atividade e/ou inscrição inválidos!");
        }
    }
}

function isNumeric(num){
    return (typeof num === "number");
}