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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author usuario
 */
@Entity
@Table(name = "tipos_servicios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TiposServicios.findAll", query = "SELECT t FROM TiposServicios t"),
    @NamedQuery(name = "TiposServicios.findByIdTipoServicio", query = "SELECT t FROM TiposServicios t WHERE t.idTipoServicio = :idTipoServicio"),
    @NamedQuery(name = "TiposServicios.findByNombre", query = "SELECT t FROM TiposServicios t WHERE t.nombre LIKE :nombre")})
public class TiposServicios implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_servicio")
    private Short idTipoServicio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "nombre")
    private String nombre;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoServicio")
    private List<Servicios> serviciosList;

    public TiposServicios() {
    }

    public TiposServicios(Short idTipoServicio) {
        this.idTipoServicio = idTipoServicio;
    }

    public TiposServicios(Short idTipoServicio, String nombre) {
        this.idTipoServicio = idTipoServicio;
        this.nombre = nombre;
    }

    public Short getIdTipoServicio() {
        return idTipoServicio;
    }

    public void setIdTipoServicio(Short idTipoServicio) {
        this.idTipoServicio = idTipoServicio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @XmlTransient
    public List<Servicios> getServiciosList() {
        return serviciosList;
    }

    public void setServiciosList(List<Servicios> serviciosList) {
        this.serviciosList = serviciosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoServicio != null ? idTipoServicio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TiposServicios)) {
            return false;
        }
        TiposServicios other = (TiposServicios) object;
        if ((this.idTipoServicio == null && other.idTipoServicio != null) || (this.idTipoServicio != null && !this.idTipoServicio.equals(other.idTipoServicio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.TiposServicios[ idTipoServicio=" + idTipoServicio + " ]";
    }
    
}
