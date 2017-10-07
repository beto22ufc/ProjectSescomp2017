/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Tema;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface TemaDAO {
    public Tema adicionarTema(Tema tema);
    public void atualizarTema(Tema tema);
    public List<Tema> listaTemas();
    public void removerTema(Tema tema);
    public Tema getTema(long codTema);
}
