/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author usuario
 */
@Embeddable
public class OfertasPK implements Serializable {
    @Basic(optional = false)
    @Column(name = "id_oferta")
    private int idOferta;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_tipo_oferta")
    private int idTipoOferta;

    public OfertasPK() {
    }

    public OfertasPK(int idOferta, int idTipoOferta) {
        this.idOferta = idOferta;
        this.idTipoOferta = idTipoOferta;
    }

    public int getIdOferta() {
        return idOferta;
    }

    public void setIdOferta(int idOferta) {
        this.idOferta = idOferta;
    }

    public int getIdTipoOferta() {
        return idTipoOferta;
    }

    public void setIdTipoOferta(int idTipoOferta) {
        this.idTipoOferta = idTipoOferta;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idOferta;
        hash += (int) idTipoOferta;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OfertasPK)) {
            return false;
        }
        OfertasPK other = (OfertasPK) object;
        if (this.idOferta != other.idOferta) {
            return false;
        }
        if (this.idTipoOferta != other.idTipoOferta) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.OfertasPK[ idOferta=" + idOferta + ", idTipoOferta=" + idTipoOferta + " ]";
    }
    
}
