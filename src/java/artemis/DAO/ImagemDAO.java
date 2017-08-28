/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.Imagem;
import java.util.List;

/**
 *
 * @author Wallison
 */
public interface ImagemDAO {
    public void adicionarImagem(Imagem imagem);
    public void atualizarImagem(Imagem imagem);
    public List<Imagem> listaImagens();
    public void removerImagem(Imagem imagem);
    public Imagem getImagem(long codImagem);
}
