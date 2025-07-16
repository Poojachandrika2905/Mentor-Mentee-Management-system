<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("userName");
    String courseName = request.getParameter("courseName");

    if (username == null || courseName == null) {
        response.sendRedirect("coursesMentor.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    try {
        // Step 1: Register the driver loading the driver class;
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // Step 2: Establishing a connection with the database creating connection object;
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
        
        // Step 3: Prepare the SQL query to insert enrollment data
        String sql = "INSERT INTO enrollMentor (username, courseName) VALUES (?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, courseName);
        
        // Step 4: Execute the query
        ps.executeUpdate();

        // Set session attribute and redirect to learning page
        session.setAttribute("enrolledCourse", courseName);
        out.println("<script type='text/javascript'>");
        out.println("alert('You have successfully enrolled in " + courseName + "!');");
        out.println("window.location.href = 'coursesMentor.jsp?success=true';");
        out.println("</script>");


    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
