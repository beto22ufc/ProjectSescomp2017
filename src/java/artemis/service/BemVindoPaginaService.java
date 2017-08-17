/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.service;

import artemis.model.Usuario;

/**
 *
 * @author Wallison
 */

public interface BemVindoPaginaService{

    public void adicionarUsuario(Usuario usuario);

    public void autenticar(Usuario usuario);
}
