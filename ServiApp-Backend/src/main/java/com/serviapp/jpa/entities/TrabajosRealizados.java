/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.serviapp.jpa.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author usuario
 */
@Entity
@Table(name = "trabajos_realizados")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TrabajosRealizados.findAll", query = "SELECT t FROM TrabajosRealizados t"),
    @NamedQuery(name = "TrabajosRealizados.findByIdTrabajoRealizado", query = "SELECT t FROM TrabajosRealizados t WHERE t.idTrabajoRealizado = :idTrabajoRealizado"),
    @NamedQuery(name = "TrabajosRealizados.findByDescripcion", query = "SELECT t FROM TrabajosRealizados t WHERE t.descripcion = :descripcion")})
public class TrabajosRealizados implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_trabajo_realizado")
    private Integer idTrabajoRealizado;
    @Size(max = 150)
    @Column(name = "descripcion")
    private String descripcion;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuarios idUsuario;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTrabajoRealizado")
    private List<ImagenesTrabajos> imagenesTrabajosList;

    public TrabajosRealizados() {
    }

    public TrabajosRealizados(Integer idTrabajoRealizado) {
        this.idTrabajoRealizado = idTrabajoRealizado;
    }

    public Integer getIdTrabajoRealizado() {
        return idTrabajoRealizado;
    }

    public void setIdTrabajoRealizado(Integer idTrabajoRealizado) {
        this.idTrabajoRealizado = idTrabajoRealizado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Usuarios getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuarios idUsuario) {
        this.idUsuario = idUsuario;
    }

    @XmlTransient
    public List<ImagenesTrabajos> getImagenesTrabajosList() {
        return imagenesTrabajosList;
    }

    public void setImagenesTrabajosList(List<ImagenesTrabajos> imagenesTrabajosList) {
        this.imagenesTrabajosList = imagenesTrabajosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTrabajoRealizado != null ? idTrabajoRealizado.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TrabajosRealizados)) {
            return false;
        }
        TrabajosRealizados other = (TrabajosRealizados) object;
        if ((this.idTrabajoRealizado == null && other.idTrabajoRealizado != null) || (this.idTrabajoRealizado != null && !this.idTrabajoRealizado.equals(other.idTrabajoRealizado))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.TrabajosRealizados[ idTrabajoRealizado=" + idTrabajoRealizado + " ]";
    }
    
}
