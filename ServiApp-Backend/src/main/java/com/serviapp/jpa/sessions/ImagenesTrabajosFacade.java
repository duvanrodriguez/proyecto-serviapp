/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.sessions;

import com.serviapp.jpa.entities.ImagenesTrabajos;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author usuario
 */
@Stateless
public class ImagenesTrabajosFacade extends AbstractFacade<ImagenesTrabajos> {
    @PersistenceContext(unitName = "com.serviapp_ServiApp-Backend_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ImagenesTrabajosFacade() {
        super(ImagenesTrabajos.class);
    }
    
}
