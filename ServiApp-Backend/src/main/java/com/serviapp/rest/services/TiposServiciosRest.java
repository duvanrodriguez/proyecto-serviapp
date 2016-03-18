package com.serviapp.rest.services;

import com.serviapp.jpa.entities.TiposServicios;
import com.serviapp.jpa.sessions.TiposServiciosFacade;
import java.util.List;
import javax.ejb.EJB;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;


@Path("TipoServicio")
public class TiposServiciosRest {

    @EJB
    private TiposServiciosFacade ejbTiposServiciosFacade;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(TiposServicios categoria) {
        ejbTiposServiciosFacade.create(categoria);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void edit(@PathParam("id") String id, TiposServicios categoria) {
        ejbTiposServiciosFacade.edit(categoria);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Short id) {
        ejbTiposServiciosFacade.remove(ejbTiposServiciosFacade.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<TiposServicios> findAll() {
        return ejbTiposServiciosFacade.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public TiposServicios findById(@PathParam("id") String id) {
        return ejbTiposServiciosFacade.find(id);
    }
    
     @GET
    @Path("nombre/{nombre}")
    public List<TiposServicios> findByNombre(@PathParam("nombre") String nombre) {
        return ejbTiposServiciosFacade.findByNombre(nombre);
    }
}
