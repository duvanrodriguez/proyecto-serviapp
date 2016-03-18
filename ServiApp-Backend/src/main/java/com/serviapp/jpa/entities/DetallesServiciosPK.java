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
public class DetallesServiciosPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "num_factura")
    private int numFactura;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_cobro_servicio")
    private int idCobroServicio;

    public DetallesServiciosPK() {
    }

    public DetallesServiciosPK(int numFactura, int idCobroServicio) {
        this.numFactura = numFactura;
        this.idCobroServicio = idCobroServicio;
    }

    public int getNumFactura() {
        return numFactura;
    }

    public void setNumFactura(int numFactura) {
        this.numFactura = numFactura;
    }

    public int getIdCobroServicio() {
        return idCobroServicio;
    }

    public void setIdCobroServicio(int idCobroServicio) {
        this.idCobroServicio = idCobroServicio;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) numFactura;
        hash += (int) idCobroServicio;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DetallesServiciosPK)) {
            return false;
        }
        DetallesServiciosPK other = (DetallesServiciosPK) object;
        if (this.numFactura != other.numFactura) {
            return false;
        }
        if (this.idCobroServicio != other.idCobroServicio) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.DetallesServiciosPK[ numFactura=" + numFactura + ", idCobroServicio=" + idCobroServicio + " ]";
    }
    
}
