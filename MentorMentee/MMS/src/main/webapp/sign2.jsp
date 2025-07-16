<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    Connection conn = null;
    PreparedStatement ps = null;
    PreparedStatement mentorPs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        // Insert into signin table
        String sql = "INSERT INTO signin (name, email, password, role) VALUES (?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, role);
        int result = ps.executeUpdate();

        // If mentor, insert into mentor table with default image name
        if (role != null && role.equalsIgnoreCase("mentor")) {
            String mentorSql = "INSERT INTO mentor (username, email, password, role, image) VALUES (?, ?, ?, ?, ?)";
            mentorPs = conn.prepareStatement(mentorSql);
            mentorPs.setString(1, name);
            mentorPs.setString(2, email);
            mentorPs.setString(3, password);
            mentorPs.setString(4, role);
            mentorPs.setString(5, "logo.jpg");  // default image filename
            mentorPs.executeUpdate();
        }

        // Set session attributes after successful insert
        if (result > 0) {
            session.setAttribute("userName", name);  // Use input name directly
            session.setAttribute("UserRole", role);  // Use input role directly

            if ("mentor".equalsIgnoreCase(role)) {
                response.sendRedirect("mentordashboard.jsp");
            } else {
                response.sendRedirect("dashboard.jsp");
            }
        } else {
            response.sendRedirect("signup.jsp?error=fail");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("signup.jsp?error=exception");
    } finally {
        try { if (mentorPs != null) mentorPs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
