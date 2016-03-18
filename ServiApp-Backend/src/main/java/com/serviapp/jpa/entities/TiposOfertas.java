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
@Table(name = "tipos_ofertas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TiposOfertas.findAll", query = "SELECT t FROM TiposOfertas t"),
    @NamedQuery(name = "TiposOfertas.findByIdTipoOferta", query = "SELECT t FROM TiposOfertas t WHERE t.idTipoOferta = :idTipoOferta"),
    @NamedQuery(name = "TiposOfertas.findByDescripcion", query = "SELECT t FROM TiposOfertas t WHERE t.descripcion = :descripcion")})
public class TiposOfertas implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_oferta")
    private Integer idTipoOferta;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "tiposOfertas")
    private List<Ofertas> ofertasList;

    public TiposOfertas() {
    }

    public TiposOfertas(Integer idTipoOferta) {
        this.idTipoOferta = idTipoOferta;
    }

    public TiposOfertas(Integer idTipoOferta, String descripcion) {
        this.idTipoOferta = idTipoOferta;
        this.descripcion = descripcion;
    }

    public Integer getIdTipoOferta() {
        return idTipoOferta;
    }

    public void setIdTipoOferta(Integer idTipoOferta) {
        this.idTipoOferta = idTipoOferta;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<Ofertas> getOfertasList() {
        return ofertasList;
    }

    public void setOfertasList(List<Ofertas> ofertasList) {
        this.ofertasList = ofertasList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoOferta != null ? idTipoOferta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TiposOfertas)) {
            return false;
        }
        TiposOfertas other = (TiposOfertas) object;
        if ((this.idTipoOferta == null && other.idTipoOferta != null) || (this.idTipoOferta != null && !this.idTipoOferta.equals(other.idTipoOferta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.TiposOfertas[ idTipoOferta=" + idTipoOferta + " ]";
    }
    
}
