package orm.ormfirst.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    // private static final Logger logger = LoggerFactory.getLogger(JwtAuthenticationFilter.class);

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                  FilterChain filterChain) throws ServletException, IOException {

        String requestURI = request.getRequestURI();
        System.out.println("=== JWT FILTER === URI: " + requestURI); // ✅ DEBUG
        
        String token = getTokenFromCookies(request);
        System.out.println("Token from cookies: " + (token != null ? token.substring(0, Math.min(20, token.length())) + "..." : "NULL")); // ✅ DEBUG

        if (token != null && !token.isEmpty()) {
            try {
                if (jwtUtil.validateToken(token)) {
                    System.out.println("Token is valid"); // ✅ DEBUG
                    String username = jwtUtil.getUsernameFromToken(token);
                    String role = jwtUtil.getRoleFromToken(token);
                    System.out.println("Username: " + username + ", Role: " + role); // ✅ DEBUG

                    if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                        UserDetails userDetails = customUserDetailsService.loadUserByUsername(username);
                        System.out.println("UserDetails loaded: " + userDetails.getUsername()); // ✅ DEBUG

                        Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
                        authorities.add(new SimpleGrantedAuthority("ROLE_" + role));

                        UsernamePasswordAuthenticationToken authToken =
                            new UsernamePasswordAuthenticationToken(userDetails, null, authorities);

                        SecurityContextHolder.getContext().setAuthentication(authToken);
                        System.out.println("Authentication set successfully"); // ✅ DEBUG
                    }
                } else {
                    System.out.println("Token validation failed!"); // ✅ DEBUG
                }
            } catch (Exception e) {
                System.out.println("JWT processing error: " + e.getMessage()); // ✅ DEBUG
                e.printStackTrace();
            }
        } else {
            System.out.println("No token found in cookies"); // ✅ DEBUG
        }

        filterChain.doFilter(request, response);
    }

    private String getTokenFromCookies(HttpServletRequest request) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("authToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    // ✅ ADD METHOD TO CLEAR INVALID TOKENS
    private void clearInvalidToken(HttpServletResponse response) {
        Cookie clearCookie = new Cookie("authToken", "");
        clearCookie.setHttpOnly(true);
        clearCookie.setMaxAge(0);
        clearCookie.setPath("/");
        response.addCookie(clearCookie);
        SecurityContextHolder.clearContext();
    }
}
