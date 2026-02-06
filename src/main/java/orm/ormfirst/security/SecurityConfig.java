package orm.ormfirst.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;  // ✅ ADD THIS
import org.springframework.security.core.context.SecurityContextHolder;  // ✅ ADD THIS
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)  // JWT is stateless
            .and()
            .authorizeRequests()
                // ✅ PUBLIC ENDPOINTS
                .antMatchers("/", "/home", "/login", "/signup", "/admin-signup").permitAll()
                .antMatchers("/css/**", "/js/**", "/images/**").permitAll()
                .antMatchers("/*.jpg", "/*.jpeg", "/*.png", "/*.gif", "/*.svg", "/*.ico").permitAll()
                .antMatchers("/*.css", "/*.js", "/*.html").permitAll()
                .antMatchers("/api/auth/**").permitAll()  // Login/signup APIs
                .antMatchers("/api/*/health").permitAll()  // Health checks
                
                // ✅ ADMIN-ONLY ENDPOINTS
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/api/admin/**").hasRole("ADMIN")
                
                // ✅ STUDENT-ONLY ENDPOINTS  
                .antMatchers("/student-dashboard/**").hasRole("STUDENT")
                .antMatchers("/exam/**").hasRole("STUDENT")
                .antMatchers("/api/student/**").hasRole("STUDENT")
                
                // ✅ MICROSERVICE APIs (Allow for internal calls)
                .antMatchers("/api/users/**").permitAll()
                .antMatchers("/api/questions-service/**").permitAll() 
                .antMatchers("/api/exams/**").permitAll()
                
                // ✅ ALL OTHER REQUESTS NEED AUTHENTICATION
                .anyRequest().authenticated()
            .and()
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
            .exceptionHandling()
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    Authentication auth = SecurityContextHolder.getContext().getAuthentication();  // ✅ NOW WORKS
                    System.out.println("=== ACCESS DENIED DEBUG ===");
                    System.out.println("User: " + (auth != null ? auth.getName() : "null"));
                    System.out.println("Authorities: " + (auth != null ? auth.getAuthorities() : "null"));
                    System.out.println("Requested URL: " + request.getRequestURI());
                    System.out.println("Required role: ROLE_ADMIN");
                    response.sendRedirect("/login?error=access_denied");
                })
                .authenticationEntryPoint((request, response, authException) -> {
                    // ✅ REDIRECT TO LOGIN WITH CLEAR MESSAGE  
                    response.sendRedirect("/login?error=authentication_required");
                })
            .and()
            .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout=success")
                .deleteCookies("authToken")  // ✅ AUTO-DELETE JWT COOKIE
                .clearAuthentication(true)
                .invalidateHttpSession(true);

        return http.build();
    }
}
