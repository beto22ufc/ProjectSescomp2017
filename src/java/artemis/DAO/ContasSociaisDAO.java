/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.ContasSociais;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface ContasSociaisDAO {
    public ContasSociais adicionarContasSociais(ContasSociais contasSociais);
    public void atualizarContasSociais(ContasSociais contasSociais);
    public List<ContasSociais> listaContasSociais();
    public void removerAtividade(ContasSociais contasSociais);
    public ContasSociais getContasSociais(long codContasSociais);
}
