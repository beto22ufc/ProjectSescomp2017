/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.model;

import java.util.function.Predicate;

/**
 *
 * @author Wallison
 * @param <Inscricao>
 */
public class InscricaoPredicate<Inscricao> implements Predicate<Inscricao> {

    private Inscricao inscricao;
    
    public InscricaoPredicate(Inscricao inscricao){
        setInscricao(inscricao);
    }
    
    @Override
    public boolean test(Inscricao t) {
        return !(t.equals(inscricao));
    }

    public Inscricao getInscricao() {
        return inscricao;
    }

    public void setInscricao(Inscricao inscricao) {
        if(inscricao !=null)
            this.inscricao = inscricao;
        else
            throw new NullPointerException("Usuário não pode ser nulo!");
    }
    
    
}
