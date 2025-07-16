package MMS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
   

       // private static final long serialVersionUID = 1L;

       // @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setContentType("text/html");
            PrintWriter pw = response.getWriter();
            HttpSession session = request.getSession();

            String username = request.getParameter("username");   // capturing username from form
            String password = request.getParameter("password");

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
                     // ✅ Check by 'name' instead of 'email'
                		PreparedStatement ps = con.prepareStatement(
                			    "SELECT role FROM signin WHERE LOWER(TRIM(name)) = LOWER(TRIM(?)) AND password = ?"
                			)){
                			ps.setString(1, username);
                			ps.setString(2, password);

                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String role = rs.getString("role");

                        session.setAttribute("userName", username);
                        session.setAttribute("userRole", role);

                        // ✅ Redirect based on role
                        if (role.equals("Mentee")) {
                            response.sendRedirect("dashboard.jsp");
                        } else {
                            response.sendRedirect("mentordashboard.jsp");
                        }

                    } 
                }
            } catch (Exception e) {
                e.printStackTrace();
                pw.println("<html><body><h3>Error occurred: " + e.getMessage() + "</h3></body></html>");
            } finally {
                pw.close();
            }
        }
    }

