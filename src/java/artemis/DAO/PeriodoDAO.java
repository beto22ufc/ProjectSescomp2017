/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Periodo;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface PeriodoDAO {
    public void adicionarPeriodo(Periodo periodo);
    public void atualizarPeriodo(Periodo periodo);
    public List<Periodo> listaPeriodos();
    public void removerPeriodo(Periodo periodo);
    public Periodo getPeriodo(long codPeriodo);
}
