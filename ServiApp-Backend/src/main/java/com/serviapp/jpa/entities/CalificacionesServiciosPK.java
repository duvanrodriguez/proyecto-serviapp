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
public class CalificacionesServiciosPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_usuario")
    private int idUsuario;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_servicio")
    private int idServicio;

    public CalificacionesServiciosPK() {
    }

    public CalificacionesServiciosPK(int idUsuario, int idServicio) {
        this.idUsuario = idUsuario;
        this.idServicio = idServicio;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(int idServicio) {
        this.idServicio = idServicio;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idUsuario;
        hash += (int) idServicio;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CalificacionesServiciosPK)) {
            return false;
        }
        CalificacionesServiciosPK other = (CalificacionesServiciosPK) object;
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        if (this.idServicio != other.idServicio) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.CalificacionesServiciosPK[ idUsuario=" + idUsuario + ", idServicio=" + idServicio + " ]";
    }
    
}
