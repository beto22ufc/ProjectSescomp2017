/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Atividade;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface AtividadeDAO {
    public Atividade adicionarAtividade(Atividade atividade);
    public void atualizarAtividade(Atividade atividade);
    public List<Atividade> listaAtividades();
    public void removerAtividade(Atividade atividade);
    public Atividade getAtividade(long codAtividade);
}
