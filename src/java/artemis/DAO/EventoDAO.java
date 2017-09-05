/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Evento;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface EventoDAO {
    public Evento adicionarEvento(Evento evento);
    public void atualizarEvento(Evento evento);
    public List<Evento> listaEventos();
    public void removerEvento(Evento evento);
    public Evento getEvento(long codEvento);
    public List<Evento> getPrimeirosEventos(int n);
}
