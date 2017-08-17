/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.UsuarioBeans;
import artemis.model.Usuario;
import artemis.service.Sign;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Wallison
 */
@Controller
public class CadastroPaginaController {
    private Sign sign;

    public Sign getSign() {
        return sign;
    }
    @Autowired(required = true)
    @Qualifier(value = "signService")
    public void setSign(Sign sign) {
        if(sign != null)
            this.sign = sign;
        else
            throw new NullPointerException("Sign service não pode ser nula!");
    }
    
    @RequestMapping(value = "/ArtemisTCC/cadastrar", method = RequestMethod.POST)
    public String cadastra(@ModelAttribute("usuario") UsuarioBeans u){
        this.setSign(new Sign((Usuario) u.toBusiness()));
        return "redirect: /cadastro";
    }
    
    @RequestMapping(value = "/ArtemisTCC/cadastro", method = RequestMethod.GET) 
    public String displayLogin(Model model) { 
        model.addAttribute("usuario", new UsuarioBeans()); 
        return "usuario"; 
    }
    
}
