/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Atividade;
import artemis.model.Evento;
import artemis.model.Inscricao;
import artemis.model.Usuario;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface InscricaoDAO {
    public Inscricao adicionarInscricao(Inscricao inscricao);
    public void atualizarInscricao(Inscricao inscricao);
    public List<Inscricao> listaInscricoes();
    public List<Evento> listaInscricoesEventos(Usuario participante);
    public List<Atividade> listaInscricoesAtividades(Usuario participante);
    public void removerInscricao(Inscricao inscricao);
    public Inscricao getInscricao(long codInscricao);
}
