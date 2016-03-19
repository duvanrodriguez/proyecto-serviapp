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
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "ofertas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ofertas.findAll", query = "SELECT o FROM Ofertas o"),
    @NamedQuery(name = "Ofertas.findByIdOferta", query = "SELECT o FROM Ofertas o WHERE o.ofertasPK.idOferta = :idOferta"),
    @NamedQuery(name = "Ofertas.findByDescripcion", query = "SELECT o FROM Ofertas o WHERE o.descripcion = :descripcion"),
    @NamedQuery(name = "Ofertas.findByDescuento", query = "SELECT o FROM Ofertas o WHERE o.descuento = :descuento"),
    @NamedQuery(name = "Ofertas.findByServicioMinimo", query = "SELECT o FROM Ofertas o WHERE o.servicioMinimo = :servicioMinimo"),
    @NamedQuery(name = "Ofertas.findByDiaMinimo", query = "SELECT o FROM Ofertas o WHERE o.diaMinimo = :diaMinimo"),
    @NamedQuery(name = "Ofertas.findByIdTipoOferta", query = "SELECT o FROM Ofertas o WHERE o.ofertasPK.idTipoOferta = :idTipoOferta")})
public class Ofertas implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected OfertasPK ofertasPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "descuento")
    private String descuento;
    @Basic(optional = false)
    @NotNull
    @Column(name = "servicio_minimo")
    private int servicioMinimo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "dia_minimo")
    private int diaMinimo;
    @JoinColumn(name = "id_tipo_oferta", referencedColumnName = "id_tipo_oferta", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private TiposOfertas tiposOfertas;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "ofertas")
    private List<DetallesServicios> detallesServiciosList;

    public Ofertas() {
    }

    public Ofertas(OfertasPK ofertasPK) {
        this.ofertasPK = ofertasPK;
    }

    public Ofertas(OfertasPK ofertasPK, String descripcion, String descuento, int servicioMinimo, int diaMinimo) {
        this.ofertasPK = ofertasPK;
        this.descripcion = descripcion;
        this.descuento = descuento;
        this.servicioMinimo = servicioMinimo;
        this.diaMinimo = diaMinimo;
    }

    public Ofertas(int idOferta, int idTipoOferta) {
        this.ofertasPK = new OfertasPK(idOferta, idTipoOferta);
    }

    public OfertasPK getOfertasPK() {
        return ofertasPK;
    }

    public void setOfertasPK(OfertasPK ofertasPK) {
        this.ofertasPK = ofertasPK;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDescuento() {
        return descuento;
    }

    public void setDescuento(String descuento) {
        this.descuento = descuento;
    }

    public int getServicioMinimo() {
        return servicioMinimo;
    }

    public void setServicioMinimo(int servicioMinimo) {
        this.servicioMinimo = servicioMinimo;
    }

    public int getDiaMinimo() {
        return diaMinimo;
    }

    public void setDiaMinimo(int diaMinimo) {
        this.diaMinimo = diaMinimo;
    }

    public TiposOfertas getTiposOfertas() {
        return tiposOfertas;
    }

    public void setTiposOfertas(TiposOfertas tiposOfertas) {
        this.tiposOfertas = tiposOfertas;
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
        hash += (ofertasPK != null ? ofertasPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ofertas)) {
            return false;
        }
        Ofertas other = (Ofertas) object;
        if ((this.ofertasPK == null && other.ofertasPK != null) || (this.ofertasPK != null && !this.ofertasPK.equals(other.ofertasPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.Ofertas[ ofertasPK=" + ofertasPK + " ]";
    }
    
}
