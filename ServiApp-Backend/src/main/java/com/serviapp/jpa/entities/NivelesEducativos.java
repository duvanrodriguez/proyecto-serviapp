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
@Table(name = "niveles_educativos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "NivelesEducativos.findAll", query = "SELECT n FROM NivelesEducativos n"),
    @NamedQuery(name = "NivelesEducativos.findByIdNivelEducativo", query = "SELECT n FROM NivelesEducativos n WHERE n.idNivelEducativo = :idNivelEducativo"),
    @NamedQuery(name = "NivelesEducativos.findByDescripcion", query = "SELECT n FROM NivelesEducativos n WHERE n.descripcion = :descripcion")})
public class NivelesEducativos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_nivel_educativo")
    private Integer idNivelEducativo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 150)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idNivelEducativo")
    private List<Titulos> titulosList;

    public NivelesEducativos() {
    }

    public NivelesEducativos(Integer idNivelEducativo) {
        this.idNivelEducativo = idNivelEducativo;
    }

    public NivelesEducativos(Integer idNivelEducativo, String descripcion) {
        this.idNivelEducativo = idNivelEducativo;
        this.descripcion = descripcion;
    }

    public Integer getIdNivelEducativo() {
        return idNivelEducativo;
    }

    public void setIdNivelEducativo(Integer idNivelEducativo) {
        this.idNivelEducativo = idNivelEducativo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<Titulos> getTitulosList() {
        return titulosList;
    }

    public void setTitulosList(List<Titulos> titulosList) {
        this.titulosList = titulosList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idNivelEducativo != null ? idNivelEducativo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof NivelesEducativos)) {
            return false;
        }
        NivelesEducativos other = (NivelesEducativos) object;
        if ((this.idNivelEducativo == null && other.idNivelEducativo != null) || (this.idNivelEducativo != null && !this.idNivelEducativo.equals(other.idNivelEducativo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.NivelesEducativos[ idNivelEducativo=" + idNivelEducativo + " ]";
    }
    
}
