/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.DAO;

import artemis.model.CPF;
import artemis.model.Usuario;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Wallison
 */
public interface UsuarioDAO{
    public void adicionarUsuario(Usuario usuario);
    public void atualizarUsuario(Usuario usuario);
    public List<Usuario> listaUsuarios();
    public void removeUsuario(Usuario usuario);
    public Usuario getUsuario(long codUsuario);
    public Usuario getUsuarioFromEmail(String email);
    public void adicionaCPF(CPF cpf);
    public void atualizaCPF(CPF cpf);
}
