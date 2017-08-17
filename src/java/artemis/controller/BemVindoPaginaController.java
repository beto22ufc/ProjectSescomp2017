/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.model.Usuario;
import artemis.service.BemVindoPaginaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Wallison
 */
@Controller
public class BemVindoPaginaController {
    private BemVindoPaginaService bemVindoPaginaService;
    
    @Autowired
    @Qualifier(value="bemVindoPaginaService")
    public void setBemVindoPaginaService(BemVindoPaginaService bemVindoPaginaService) {
        if(bemVindoPaginaService !=  null)
            this.bemVindoPaginaService = bemVindoPaginaService;
        else 
            throw new NullPointerException("Argumento de serviço nulo!");
    }
    
    @RequestMapping(value="/usuario/adicionar", method=RequestMethod.POST)
    public String adicionarUsuario(@ModelAttribute("usuario") Usuario usuario){
        if(usuario.getCodUsuario() == 0){
            this.bemVindoPaginaService.adicionarUsuario(usuario);
        }else{
        
        }
        return "redirect:/usuario";
    }
}
