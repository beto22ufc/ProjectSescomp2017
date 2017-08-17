/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Instituicao;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface InstituicaoDAO {
    public void adicionarInstituicao(Instituicao instituicao);
    public void atualizarInstituicao(Instituicao instituicao);
    public List<Instituicao> listaInstituicoes();
    public void removerInstituicao(Instituicao instituicao);
    public Instituicao getInstituicao(long codInstituicao);
}
