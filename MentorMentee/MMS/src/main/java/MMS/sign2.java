package MMS;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import AMS.databaseconnect; 

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class sign2
 */
@WebServlet("/sign2")
public class sign2 extends HttpServlet {

	 private static final long serialVersionUID = 1L; 
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	     response.setContentType("text/html");
	     PrintWriter pw = response.getWriter();
	     HttpSession session = request.getSession();

	     try {
	         Class.forName("oracle.jdbc.driver.OracleDriver");
	         try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
	              PreparedStatement ps = con.prepareStatement("INSERT INTO signin VALUES (?, ?, ?, ?)")) {

	             String name = request.getParameter("name");
	             String email = request.getParameter("email");
	             String password = request.getParameter("password");
	             String role = request.getParameter("role");

	             // Input validation
	             if (name == null || email == null || password == null || role == null) {
	                 pw.println("<h3>Invalid Input! All fields are required.</h3>");
	                 return;
	             }

	             ps.setString(1, name);
	             ps.setString(2, email);
	             ps.setString(3, password);
	             ps.setString(4, role);

	             int result = ps.executeUpdate();

	             
	                 session.setAttribute("userName", name);
	                 session.setAttribute("userRole", role);
	                 if (role == "Mentee") {
	                	 response.sendRedirect("dashboard.jsp");
	                 }
	                 else {
	                	 response.sendRedirect("mentordashboard.jsp");
	                 }
	                
	                 //response.sendRedirect("dashboard.jsp");
	              
	         }
	     } catch(Exception e) {
	         e.printStackTrace();
	         pw.println("<html><body><h3>Error occurred: " + e.getMessage() + "</h3></body></html>");
	     } finally {
	         pw.close();
	     }
	 }
}