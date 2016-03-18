/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.sessions;

import com.serviapp.jpa.entities.Paises;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author usuario
 */
@Stateless
public class PaisesFacade extends AbstractFacade<Paises> {
    @PersistenceContext(unitName = "com.serviapp_ServiApp-Backend_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PaisesFacade() {
        super(Paises.class);
    }
    
}
