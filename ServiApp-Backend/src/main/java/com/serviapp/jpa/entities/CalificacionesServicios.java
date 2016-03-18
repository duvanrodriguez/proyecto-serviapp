/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author usuario
 */
@Entity
@Table(name = "calificaciones_servicios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CalificacionesServicios.findAll", query = "SELECT c FROM CalificacionesServicios c"),
    @NamedQuery(name = "CalificacionesServicios.findByIdUsuario", query = "SELECT c FROM CalificacionesServicios c WHERE c.calificacionesServiciosPK.idUsuario = :idUsuario"),
    @NamedQuery(name = "CalificacionesServicios.findByIdServicio", query = "SELECT c FROM CalificacionesServicios c WHERE c.calificacionesServiciosPK.idServicio = :idServicio"),
    @NamedQuery(name = "CalificacionesServicios.findByPuntuacion", query = "SELECT c FROM CalificacionesServicios c WHERE c.puntuacion = :puntuacion"),
    @NamedQuery(name = "CalificacionesServicios.findByComentario", query = "SELECT c FROM CalificacionesServicios c WHERE c.comentario = :comentario"),
    @NamedQuery(name = "CalificacionesServicios.findByFecha", query = "SELECT c FROM CalificacionesServicios c WHERE c.fecha = :fecha")})
public class CalificacionesServicios implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected CalificacionesServiciosPK calificacionesServiciosPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "puntuacion")
    private short puntuacion;
    @Size(max = 140)
    @Column(name = "comentario")
    private String comentario;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @JoinColumn(name = "id_servicio", referencedColumnName = "id_servicio", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Servicios servicios;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuarios usuarios;

    public CalificacionesServicios() {
    }

    public CalificacionesServicios(CalificacionesServiciosPK calificacionesServiciosPK) {
        this.calificacionesServiciosPK = calificacionesServiciosPK;
    }

    public CalificacionesServicios(CalificacionesServiciosPK calificacionesServiciosPK, short puntuacion, Date fecha) {
        this.calificacionesServiciosPK = calificacionesServiciosPK;
        this.puntuacion = puntuacion;
        this.fecha = fecha;
    }

    public CalificacionesServicios(int idUsuario, int idServicio) {
        this.calificacionesServiciosPK = new CalificacionesServiciosPK(idUsuario, idServicio);
    }

    public CalificacionesServiciosPK getCalificacionesServiciosPK() {
        return calificacionesServiciosPK;
    }

    public void setCalificacionesServiciosPK(CalificacionesServiciosPK calificacionesServiciosPK) {
        this.calificacionesServiciosPK = calificacionesServiciosPK;
    }

    public short getPuntuacion() {
        return puntuacion;
    }

    public void setPuntuacion(short puntuacion) {
        this.puntuacion = puntuacion;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Servicios getServicios() {
        return servicios;
    }

    public void setServicios(Servicios servicios) {
        this.servicios = servicios;
    }

    public Usuarios getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(Usuarios usuarios) {
        this.usuarios = usuarios;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (calificacionesServiciosPK != null ? calificacionesServiciosPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CalificacionesServicios)) {
            return false;
        }
        CalificacionesServicios other = (CalificacionesServicios) object;
        if ((this.calificacionesServiciosPK == null && other.calificacionesServiciosPK != null) || (this.calificacionesServiciosPK != null && !this.calificacionesServiciosPK.equals(other.calificacionesServiciosPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.CalificacionesServicios[ calificacionesServiciosPK=" + calificacionesServiciosPK + " ]";
    }
    
}
