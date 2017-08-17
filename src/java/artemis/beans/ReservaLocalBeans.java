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
import artemis.model.ReservaLocal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author Wallison
 */
public class ReservaLocalBeans extends ReservaBeans{
    private LocalBeans local;

    public ReservaLocalBeans(){

    }

    public ReservaLocalBeans(long codReserva, List<PeriodoBeans> periodoBeanses, LocalBeans local, LocalDateTime data){
        setCodReserva(codReserva);
        setPeriodosBeans(periodoBeanses);
        setLocal(local);
        setData(data);
    }

    public ReservaLocalBeans(List<PeriodoBeans> periodoBeanses, LocalBeans local, LocalDateTime data){
        setPeriodosBeans(periodoBeanses);
        setLocal(local);
        setData(data);
    }
    
    public LocalBeans getLocal() {
        return local;
    }

    public void setLocal(LocalBeans local) {
        this.local = local;
    }
    
    @Override
    public Beans toBeans(Object o) {
        if(o != null){
            if(o instanceof Reserva){
                ReservaLocal r = (ReservaLocal) o;
                this.setCodReserva(r.getCodReserva());
                this.setData(r.getData());
                LocalBeans lb = (LocalBeans) (new LocalBeans().toBeans(r.getLocal()));
                this.setLocal(lb);
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
        ReservaLocal r = new ReservaLocal();
        if(this.getCodReserva()>0){
            r.setCodReserva(this.getCodReserva());
        }
        if(this.getData() != null){
            r.setData(this.getData());
        }
        Local l = (Local) ((LocalBeans) this.getLocal()).toBusiness();
        r.setLocal(l);
        List<Periodo> periodos = Collections.synchronizedList(new ArrayList<Periodo>());
        for(int i=0;i<this.getPeriodosBeans().size();i++){
            periodos.add((Periodo)this.getPeriodosBeans().get(i).toBusiness());
        }
        r.setPeriodos(periodos);
        return r;
    }
    
}
