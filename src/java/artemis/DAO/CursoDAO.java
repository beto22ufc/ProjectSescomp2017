/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Curso;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface CursoDAO {
    public void adicionarCurso(Curso curso);
    public void atualizarCurso(Curso curso);
    public List<Curso> listaCursos();
    public void removerCurso(Curso curso);
    public Curso getCurso(long codCurso);
}
