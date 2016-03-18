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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author usuario
 */
@Entity
@Table(name = "cobros_servicios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CobrosServicios.findAll", query = "SELECT c FROM CobrosServicios c"),
    @NamedQuery(name = "CobrosServicios.findByIdCobroServicio", query = "SELECT c FROM CobrosServicios c WHERE c.idCobroServicio = :idCobroServicio"),
    @NamedQuery(name = "CobrosServicios.findByValorDiaServicio", query = "SELECT c FROM CobrosServicios c WHERE c.valorDiaServicio = :valorDiaServicio"),
    @NamedQuery(name = "CobrosServicios.findByDescripcion", query = "SELECT c FROM CobrosServicios c WHERE c.descripcion = :descripcion")})
public class CobrosServicios implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_cobro_servicio")
    private Integer idCobroServicio;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "valor_dia_servicio")
    private Float valorDiaServicio;
    @Size(max = 150)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "cobrosServicios")
    private List<DetallesServicios> detallesServiciosList;

    public CobrosServicios() {
    }

    public CobrosServicios(Integer idCobroServicio) {
        this.idCobroServicio = idCobroServicio;
    }

    public Integer getIdCobroServicio() {
        return idCobroServicio;
    }

    public void setIdCobroServicio(Integer idCobroServicio) {
        this.idCobroServicio = idCobroServicio;
    }

    public Float getValorDiaServicio() {
        return valorDiaServicio;
    }

    public void setValorDiaServicio(Float valorDiaServicio) {
        this.valorDiaServicio = valorDiaServicio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<DetallesServicios> getDetallesServiciosList() {
        return detallesServiciosList;
    }

    public void setDetallesServiciosList(List<DetallesServicios> detallesServiciosList) {
        this.detallesServiciosList = detallesServiciosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idCobroServicio != null ? idCobroServicio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CobrosServicios)) {
            return false;
        }
        CobrosServicios other = (CobrosServicios) object;
        if ((this.idCobroServicio == null && other.idCobroServicio != null) || (this.idCobroServicio != null && !this.idCobroServicio.equals(other.idCobroServicio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.CobrosServicios[ idCobroServicio=" + idCobroServicio + " ]";
    }
    
}
