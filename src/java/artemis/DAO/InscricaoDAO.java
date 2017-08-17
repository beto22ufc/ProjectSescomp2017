/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Inscricao;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface InscricaoDAO {
    public void adicionarInscricao(Inscricao inscricao);
    public void atualizarInscricao(Inscricao inscricao);
    public List<Inscricao> listaInscricoes();
    public void removerInscricao(Inscricao inscricao);
    public Inscricao getInscricao(long codInscricao);
}
