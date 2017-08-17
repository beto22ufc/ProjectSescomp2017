/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

import artemis.model.Bem;
import artemis.model.Local;
import artemis.model.Periodo;
import artemis.model.Reserva;
import artemis.model.ReservaBem;
import artemis.model.ReservaLocal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Wallison
 */
public class ReservaBemBeans extends ReservaBeans{
    private BemBeans bem;
    
    public ReservaBemBeans(){

    }

    public ReservaBemBeans(long codReserva, List<PeriodoBeans> periodoBeanses, BemBeans bem, LocalDateTime data){
        setCodReserva(codReserva);
        setPeriodosBeans(periodoBeanses);
        setBem(bem);
        setData(data);
    }

    public ReservaBemBeans(List<PeriodoBeans> periodoBeanses, BemBeans bem, LocalDateTime data){
        setPeriodosBeans(periodoBeanses);
        setBem(bem);
        setData(data);
    }

    public BemBeans getBem() {
        return bem;
    }

    public void setBem(BemBeans bem) {
        this.bem = bem;
    }
    
    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Reserva){
                ReservaBem r = (ReservaBem) o;
                this.setCodReserva(r.getCodReserva());
                this.setData(r.getData());
                BemBeans bb = (BemBeans) (new BemBeans().toBeans(r.getBem()));
                this.setBem(bb);
                List<PeriodoBeans> periodos = Collections.synchronizedList(new ArrayList<PeriodoBeans>());
                PeriodoBeans periodoBeans = null;
                for(int i=0;i<r.getPeriodos().size();i++){
                    periodoBeans = (PeriodoBeans) (new PeriodoBeans().toBeans(r.getPeriodos().get(i)));
                    periodos.add(periodoBeans);
                }
                this.setPeriodosBeans(periodos);
                return this;
            }else{
                throw new IllegalArgumentException("Isso não é uma Reserva!");
            }
        }else{
            throw new NullPointerException("Reserva não pode ser nula!");
        }
    }

    @Override
    public Object toBusiness() {
        ReservaBem r = new ReservaBem();
        if(this.getCodReserva()>0){
            r.setCodReserva(this.getCodReserva());
        }
        if(this.getData() != null){
            r.setData(this.getData());
        }
        Bem b = (Bem) ((BemBeans)this.getBem()).toBusiness();
        r.setBem(b);
        List<Periodo> periodos = Collections.synchronizedList(new ArrayList<Periodo>());
        for(int i=0;i<this.getPeriodosBeans().size();i++){
            periodos.add((Periodo)this.getPeriodosBeans().get(i).toBusiness());
        }
        r.setPeriodos(periodos);
        return r;
    }
    
}
