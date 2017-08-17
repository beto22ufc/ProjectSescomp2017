/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.ContaAtivacao;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface ContaAtivacaoDAO {
    public void adicionarContaAtivacao(ContaAtivacao ca);
    public void atualizarContaAtivacao(ContaAtivacao ca);
    public List<ContaAtivacao> listaContasAtivacao();
    public void removerContaAtivacao(ContaAtivacao ca);
    public ContaAtivacao getContaAtivacao(long codContaAtivacao);
}
