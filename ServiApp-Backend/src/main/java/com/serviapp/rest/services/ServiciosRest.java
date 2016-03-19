package com.serviapp.rest.services;

import com.serviapp.jpa.entities.Servicios;
import com.serviapp.jpa.entities.Usuarios;
import com.serviapp.jpa.sessions.ServiciosFacade;
import com.serviapp.rest.auth.AuthUtils;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;


@Path("servicios")
public class ServiciosRest {

    @EJB
    private ServiciosFacade ejbServiciosFacade;

    @Context
    private HttpServletRequest request;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response create(Servicios servicio) {
        GsonBuilder builder = new GsonBuilder();
        Gson gson = builder.create();
        try {
            servicio.getIdServicio();
                    new Servicios(
                            Integer.parseInt(
                                    AuthUtils.getSubject(
                                            request.getHeader(AuthUtils.AUTH_HEADER_KEY)
                                    )
                            )
                    );
            
            ejbServiciosFacade.create(servicio);
            return Response.ok().entity(gson.toJson("El servicio fue creado exitosamente")).build();
        } catch (EJBException ex) {
            String msg = "";
            Throwable cause = ex.getCause();
            if (cause != null) {
                if (cause instanceof ConstraintViolationException) {
                    ConstraintViolationException constraintViolationException = (ConstraintViolationException) cause;
                    for (ConstraintViolation<?> constraintViolation : constraintViolationException.getConstraintViolations()) {
                        msg += "{";
                        msg += "entity: " + constraintViolation.getLeafBean().toString() + ",";
                        msg += "field: " + constraintViolation.getPropertyPath().toString() + ",";
                        msg += "invalidValue: " + constraintViolation.getInvalidValue().toString() + ",";
                        msg += "error: " + constraintViolation.getMessage();
                        msg += "}";
                    }
                } else {
                    msg = cause.getLocalizedMessage();
                }
            }
            if (msg.length() > 0) {
                return Response.status(Status.BAD_REQUEST).entity(gson.toJson(msg)).build();
            } else {
                return Response.status(Status.BAD_REQUEST).entity(gson.toJson("Error de persistencia")).build();
            }
        } catch (Exception ex) {
            Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
            return Response.status(Status.BAD_REQUEST).entity(gson.toJson("Error de persistencia")).build();
        }
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        ejbServiciosFacade.remove(ejbServiciosFacade.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Servicios> findAll() {
        return ejbServiciosFacade.findAll();
    }
    
    @GET
    @Path("nombre/{nombre}")
   public List<Servicios > findByNombre(@PathParam("nombre") String nombre) {
        return ejbServiciosFacade.findByNombre(nombre);
    }

}
