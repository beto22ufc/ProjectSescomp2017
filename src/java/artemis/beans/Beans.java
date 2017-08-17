/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package artemis.beans;

/**
 *
 * @author Wallison
 */
public interface Beans {
    /**
     *
     * @param o
     * @return Beans
     */
    public Beans toBeans(Object o);
    public Object toBusiness();
}
