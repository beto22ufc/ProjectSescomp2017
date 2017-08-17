/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.controller;

import artemis.beans.UsuarioBeans;
import artemis.model.Usuario;
import artemis.service.Sign;
import javax.servlet.http.HttpSession;
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
public class LoginPaginaController {
    private Sign sign;

    public Sign getSign() {
        return sign;
    }
    
    @Autowired(required = true)
    @Qualifier(value = "signService")
    public void setSign(Sign sign) {
        this.sign = sign;
    }
    @RequestMapping(value="/entrar", method = RequestMethod.POST)
    public String login(@ModelAttribute("usuario") UsuarioBeans u, HttpSession session){
        this.setSign(new Sign((Usuario) u.toBusiness()));
        session.setAttribute("usuario", this.getSign().entra());
        return "redirect:/";
    }
    
}
