/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Local;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface LocalDAO {
    public void adicionarLocal(Local local);
    public void atualizarLocal(Local local);
    public List<Local> listaLocais();
    public void removerLocal(Local local);
    public Local getLocal(long codLocal);
}
