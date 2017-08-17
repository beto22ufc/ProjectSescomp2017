/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Reserva;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface ReservaDAO {
    public void adicionarReserva(Reserva reserva);
    public void atualizarReserva(Reserva reserva);
    public List<Reserva> listaReservas();
    public void removerReserva(Reserva reserva);
    public Reserva getReserva(long codReserva);
}
