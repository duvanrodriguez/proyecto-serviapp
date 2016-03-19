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
import javax.persistence.Entity;
import javax.persistence.Id;
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
 * @author adsi2
 */
@Entity
@Table(name = "CALIFICACIONES_SERVICIOS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CalificacionesServicios.findAll", query = "SELECT c FROM CalificacionesServicios c"),
    @NamedQuery(name = "CalificacionesServicios.findByIdCalificacion", query = "SELECT c FROM CalificacionesServicios c WHERE c.idCalificacion = :idCalificacion"),
    @NamedQuery(name = "CalificacionesServicios.findByPuntuacion", query = "SELECT c FROM CalificacionesServicios c WHERE c.puntuacion = :puntuacion"),
    @NamedQuery(name = "CalificacionesServicios.findByComentario", query = "SELECT c FROM CalificacionesServicios c WHERE c.comentario = :comentario"),
    @NamedQuery(name = "CalificacionesServicios.findByFecha", query = "SELECT c FROM CalificacionesServicios c WHERE c.fecha = :fecha")})
public class CalificacionesServicios implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_calificacion")
    private Integer idCalificacion;
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
    @JoinColumn(name = "id_servicio", referencedColumnName = "id_servicio")
    @ManyToOne(optional = false)
    private Servicios idServicio;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuarios idUsuario;

    public CalificacionesServicios() {
    }

    public CalificacionesServicios(Integer idCalificacion) {
        this.idCalificacion = idCalificacion;
    }

    public CalificacionesServicios(Integer idCalificacion, short puntuacion, Date fecha) {
        this.idCalificacion = idCalificacion;
        this.puntuacion = puntuacion;
        this.fecha = fecha;
    }

    public Integer getIdCalificacion() {
        return idCalificacion;
    }

    public void setIdCalificacion(Integer idCalificacion) {
        this.idCalificacion = idCalificacion;
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

    public Servicios getIdServicio() {
        return idServicio;
    }

    public void setIdServicio(Servicios idServicio) {
        this.idServicio = idServicio;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCalificacion != null ? idCalificacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CalificacionesServicios)) {
            return false;
        }
        CalificacionesServicios other = (CalificacionesServicios) object;
        if ((this.idCalificacion == null && other.idCalificacion != null) || (this.idCalificacion != null && !this.idCalificacion.equals(other.idCalificacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.CalificacionesServicios[ idCalificacion=" + idCalificacion + " ]";
    }
    
}
