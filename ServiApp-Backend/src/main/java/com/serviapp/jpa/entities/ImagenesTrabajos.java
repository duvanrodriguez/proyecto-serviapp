/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author usuario
 */
@Entity
@Table(name = "imagenes_trabajos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ImagenesTrabajos.findAll", query = "SELECT i FROM ImagenesTrabajos i"),
    @NamedQuery(name = "ImagenesTrabajos.findByIdImagenTrabajo", query = "SELECT i FROM ImagenesTrabajos i WHERE i.idImagenTrabajo = :idImagenTrabajo")})
public class ImagenesTrabajos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_imagen_trabajo")
    private Integer idImagenTrabajo;
    @Lob
    @Column(name = "imagen")
    private byte[] imagen;
    @JoinColumn(name = "id_trabajo_realizado", referencedColumnName = "id_trabajo_realizado")
    @ManyToOne(optional = false)
    private TrabajosRealizados idTrabajoRealizado;

    public ImagenesTrabajos() {
    }

    public ImagenesTrabajos(Integer idImagenTrabajo) {
        this.idImagenTrabajo = idImagenTrabajo;
    }

    public Integer getIdImagenTrabajo() {
        return idImagenTrabajo;
    }

    public void setIdImagenTrabajo(Integer idImagenTrabajo) {
        this.idImagenTrabajo = idImagenTrabajo;
    }

    public byte[] getImagen() {
        return imagen;
    }

    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }

    public TrabajosRealizados getIdTrabajoRealizado() {
        return idTrabajoRealizado;
    }

    public void setIdTrabajoRealizado(TrabajosRealizados idTrabajoRealizado) {
        this.idTrabajoRealizado = idTrabajoRealizado;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idImagenTrabajo != null ? idImagenTrabajo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ImagenesTrabajos)) {
            return false;
        }
        ImagenesTrabajos other = (ImagenesTrabajos) object;
        if ((this.idImagenTrabajo == null && other.idImagenTrabajo != null) || (this.idImagenTrabajo != null && !this.idImagenTrabajo.equals(other.idImagenTrabajo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.ImagenesTrabajos[ idImagenTrabajo=" + idImagenTrabajo + " ]";
    }
    
}
