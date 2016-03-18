package com.serviapp.rest.auth;

import com.serviapp.jpa.sessions.UsuariosFacade;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jwt.JWTClaimsSet;
import java.io.IOException;
import java.text.ParseException;
import javax.ejb.EJB;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.joda.time.DateTime;

public class RestAuthenticationFilter implements Filter {

    private static final String AUTH_ERROR_MSG = "Please make sure your request has an Authorization header",
            EXPIRE_ERROR_MSG = "Token has expired",
            JWT_ERROR_MSG = "Unable to parse JWT",
            JWT_INVALID_MSG = "Invalid JWT token";

    @EJB
    private UsuariosFacade ejbFacadeUsuario;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    /**
     *
     * @param request
     * @param response
     * @param chain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (request instanceof HttpServletRequest && response instanceof HttpServletResponse) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            System.out.println("Method: " + httpRequest.getMethod());

            if (!httpRequest.getMethod().equalsIgnoreCase("OPTIONS")) {
                filter(response);
                String authHeader = httpRequest.getHeader(AuthUtils.AUTH_HEADER_KEY);

                String url = httpRequest.getPathInfo();
                System.out.println("Resource: " + url);

                if (authHeader == null || authHeader.isEmpty() || authHeader.split(" ").length != 2) {
                    filter(response);
                    httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, AUTH_ERROR_MSG);
                } else {
                    JWTClaimsSet claimSet = null;
                    try {
                        claimSet = (JWTClaimsSet) AuthUtils.decodeToken(authHeader);
                    } catch (ParseException e) {
                        httpResponse.sendError(HttpServletResponse.SC_BAD_REQUEST, JWT_ERROR_MSG);
                        return;
                    } catch (JOSEException e) {
                        httpResponse.sendError(HttpServletResponse.SC_BAD_REQUEST, JWT_INVALID_MSG);
                        return;
                    }

                    // ensure that the token is not expired
                    if (new DateTime(claimSet.getExpirationTime()).isBefore(DateTime.now())) {
                        httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, EXPIRE_ERROR_MSG);
                    } else {
                        chain.doFilter(request, response);
                    }
                }
            } else {
                httpResponse.addHeader("Access-Control-Allow-Origin", "*");
                httpResponse.setHeader("Access-Control-Allow-Methods", "POST,GET,DELETE");
                httpResponse.setHeader("Access-Control-Max-Age", "3600");
                httpResponse.setHeader("Access-Control-Allow-Headers", "content-type,access-control-request-headers,access-control-request-method,accept,origin,authorization,x-requested-with");
                httpResponse.setStatus(HttpServletResponse.SC_OK);
            }
        }

    }

    public void filter(ServletResponse response) {

        if (response instanceof HttpServletResponse) {

            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

            httpServletResponse.setHeader("Access-Control-Allow-Origin", "*");
            httpServletResponse.setHeader("Access-Control-Allow-Methods", "POST,PUT,GET,OPTIONS,DELETE");
            httpServletResponse.setHeader("Access-Control-Allow-Max-Age", "3600");
            httpServletResponse.setHeader("Access-Control-Allow-Headers", "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        }
    }

    @Override
    public void destroy() {

    }

}
