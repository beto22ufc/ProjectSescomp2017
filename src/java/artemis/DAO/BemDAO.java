/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Bem;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface BemDAO {
    public void adicionarBem(Bem bem);
    public void atualizarBem(Bem bem);
    public List<Bem> listaBens();
    public void removerBem(Bem bem);
    public Bem getBem(long codBem);
}
