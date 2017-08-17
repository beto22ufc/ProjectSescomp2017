/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Localizacao;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface LocalizacaoDAO {
    public void adicionarLocalizacao(Localizacao localizacao);
    public void atualizarLocalizacao(Localizacao localizacao);
    public List<Localizacao> listaLocalizacoes();
    public void removerLocalizacao(Localizacao localizacao);
    public Localizacao getLocalizacao(long codLocalizacao);
}
