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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
 * @author usuario
 */
@Entity
@Table(name = "titulos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Titulos.findAll", query = "SELECT t FROM Titulos t"),
    @NamedQuery(name = "Titulos.findByIdTitulo", query = "SELECT t FROM Titulos t WHERE t.idTitulo = :idTitulo"),
    @NamedQuery(name = "Titulos.findByTituloObtenido", query = "SELECT t FROM Titulos t WHERE t.tituloObtenido = :tituloObtenido"),
    @NamedQuery(name = "Titulos.findByFechaTerminacion", query = "SELECT t FROM Titulos t WHERE t.fechaTerminacion = :fechaTerminacion"),
    @NamedQuery(name = "Titulos.findByInstitucion", query = "SELECT t FROM Titulos t WHERE t.institucion = :institucion")})
public class Titulos implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_titulo")
    private Integer idTitulo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 150)
    @Column(name = "titulo_obtenido")
    private String tituloObtenido;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_terminacion")
    @Temporal(TemporalType.DATE)
    private Date fechaTerminacion;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "institucion")
    private String institucion;
    @JoinColumn(name = "id_nivel_educativo", referencedColumnName = "id_nivel_educativo")
    @ManyToOne(optional = false)
    private NivelesEducativos idNivelEducativo;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuarios idUsuario;

    public Titulos() {
    }

    public Titulos(Integer idTitulo) {
        this.idTitulo = idTitulo;
    }

    public Titulos(Integer idTitulo, String tituloObtenido, Date fechaTerminacion, String institucion) {
        this.idTitulo = idTitulo;
        this.tituloObtenido = tituloObtenido;
        this.fechaTerminacion = fechaTerminacion;
        this.institucion = institucion;
    }

    public Integer getIdTitulo() {
        return idTitulo;
    }

    public void setIdTitulo(Integer idTitulo) {
        this.idTitulo = idTitulo;
    }

    public String getTituloObtenido() {
        return tituloObtenido;
    }

    public void setTituloObtenido(String tituloObtenido) {
        this.tituloObtenido = tituloObtenido;
    }

    public Date getFechaTerminacion() {
        return fechaTerminacion;
    }

    public void setFechaTerminacion(Date fechaTerminacion) {
        this.fechaTerminacion = fechaTerminacion;
    }

    public String getInstitucion() {
        return institucion;
    }

    public void setInstitucion(String institucion) {
        this.institucion = institucion;
    }

    public NivelesEducativos getIdNivelEducativo() {
        return idNivelEducativo;
    }

    public void setIdNivelEducativo(NivelesEducativos idNivelEducativo) {
        this.idNivelEducativo = idNivelEducativo;
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
        hash += (idTitulo != null ? idTitulo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Titulos)) {
            return false;
        }
        Titulos other = (Titulos) object;
        if ((this.idTitulo == null && other.idTitulo != null) || (this.idTitulo != null && !this.idTitulo.equals(other.idTitulo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.serviapp.jpa.entities.Titulos[ idTitulo=" + idTitulo + " ]";
    }
    
}
