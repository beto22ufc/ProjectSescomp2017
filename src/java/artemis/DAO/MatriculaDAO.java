/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Matricula;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface MatriculaDAO {
    public Matricula adicionarMatricula(Matricula matricula);
    public void atualizarMatricula(Matricula matricula);
    public List<Matricula> listaMatriculas();
    public void removeMatricula(Matricula matricula);
    public Matricula getMatricula(long codMatricula);
}
