/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.sessions;

import com.nimbusds.jose.JOSEException;
import com.serviapp.jpa.entities.Usuarios;
import com.serviapp.rest.auth.AuthUtils;
import java.text.ParseException;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author usuario
 */
@Stateless
public class UsuariosFacade extends AbstractFacade<Usuarios> {
    @PersistenceContext(unitName = "com.serviapp_ServiApp-Backend_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public UsuariosFacade() {
        super(Usuarios.class);
    }
    
     
    public Usuarios findByEmail(String email) {
        try {
            return (Usuarios) getEntityManager().createNamedQuery("Usuarios.findByEmail")
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }
    }
    
    public List<Usuarios> findByNombre(String nombre) {
        return getEntityManager().createNamedQuery("Usuarios.findByNombres")
                .setParameter("nombres", nombre + "%")
                .getResultList();
    }
    
    /*
    * Helper methods
    */
    public Usuarios getAuthUser(HttpServletRequest request) throws ParseException, JOSEException {
        String subject = AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY));
        return super.find(Integer.parseInt(subject));
    }
    
}
