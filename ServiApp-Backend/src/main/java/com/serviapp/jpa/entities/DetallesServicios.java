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
import javax.persistence.JoinColumns;
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
@Table(name = "detalles_servicios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DetallesServicios.findAll", query = "SELECT d FROM DetallesServicios d"),
    @NamedQuery(name = "DetallesServicios.findByNumFactura", query = "SELECT d FROM DetallesServicios d WHERE d.detallesServiciosPK.numFactura = :numFactura"),
    @NamedQuery(name = "DetallesServicios.findByIdCobroServicio", query = "SELECT d FROM DetallesServicios d WHERE d.detallesServiciosPK.idCobroServicio = :idCobroServicio"),
    @NamedQuery(name = "DetallesServicios.findByFecha", query = "SELECT d FROM DetallesServicios d WHERE d.fecha = :fecha"),
    @NamedQuery(name = "DetallesServicios.findByEmail", query = "SELECT d FROM DetallesServicios d WHERE d.email = :email"),
    @NamedQuery(name = "DetallesServicios.findByCantidadDia", query = "SELECT d FROM DetallesServicios d WHERE d.cantidadDia = :cantidadDia"),
    @NamedQuery(name = "DetallesServicios.findByCantidadServiciol", query = "SELECT d FROM DetallesServicios d WHERE d.cantidadServiciol = :cantidadServiciol"),
    @NamedQuery(name = "DetallesServicios.findByDescripcion", query = "SELECT d FROM DetallesServicios d WHERE d.descripcion = :descripcion")})
public class DetallesServicios implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected DetallesServiciosPK detallesServiciosPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 150)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cantidad_dia")
    private int cantidadDia;
    @Basic(optional = false)
    @NotNull
    @Column(name = "cantidad_serviciol")
    private int cantidadServiciol;
    @Size(max = 150)
    @Column(name = "descripcion")
    private String descripcion;
    @JoinColumn(name = "id_cobro_servicio", referencedColumnName = "id_cobro_servicio", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private CobrosServicios cobrosServicios;
    @JoinColumn(name = "num_factura", referencedColumnName = "num_factura", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Facturas facturas;
    @JoinColumns({
        @JoinColumn(name = "id_oferta", referencedColumnName = "id_oferta"),
        @JoinColumn(name = "id_tipo_oferta", referencedColumnName = "id_tipo_oferta")})
    @ManyToOne(optional = false)
    private Ofertas ofertas;

    public DetallesServicios() {
    }

    public DetallesServicios(DetallesServiciosPK detallesServiciosPK) {
        this.detallesServiciosPK = detallesServiciosPK;
    }

    public DetallesServicios(DetallesServiciosPK detallesServiciosPK, Date fecha, String email, int cantidadDia, int cantidadServiciol) {
        this.detallesServiciosPK = detallesServiciosPK;
        this.fecha = fecha;
        this.email = email;
        this.cantidadDia = cantidadDia;
        this.cantidadServiciol = cantidadServiciol;
    }

    public DetallesServicios(int numFactura, int idCobroServicio) {
        this.detallesServiciosPK = new DetallesServiciosPK(numFactura, idCobroServicio);
    }

    public DetallesServiciosPK getDetallesServiciosPK() {
        return detallesServiciosPK;
    }

    public void setDetallesServiciosPK(DetallesServiciosPK detallesServiciosPK) {
        this.detallesServiciosPK = detallesServiciosPK;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCantidadDia() {
        return cantidadDia;
    }

    public void setCantidadDia(int cantidadDia) {
        this.cantidadDia = cantidadDia;
    }

    public int getCantidadServiciol() {
        return cantidadServiciol;
    }

    public void setCantidadServiciol(int cantidadServiciol) {
        this.cantidadServiciol = cantidadServiciol;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public CobrosServicios getCobrosServicios() {
        return cobrosServicios;
    }

    public void setCobrosServicios(CobrosServicios cobrosServicios) {
        this.cobrosServicios = cobrosServicios;
    }

    public Facturas getFacturas() {
        return facturas;
    }

    public void setFacturas(Facturas facturas) {
        this.facturas = facturas;
    }

    public Ofertas getOfertas() {
        return ofertas;
    }

    public void setOfertas(Ofertas ofertas) {
        this.ofertas = ofertas;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (detallesServiciosPK != null ? detallesServiciosPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DetallesServicios)) {
            return false;
        }
        DetallesServicios other = (DetallesServicios) object;
        if ((this.detallesServiciosPK == null && other.detallesServiciosPK != null) || (this.detallesServiciosPK != null && !this.detallesServiciosPK.equals(other.detallesServiciosPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.DetallesServicios[ detallesServiciosPK=" + detallesServiciosPK + " ]";
    }
    
}
