<%@ page import="java.sql.*" %>
<%
    String mentor = request.getParameter("mentor_username");
    String course = request.getParameter("course_name");
    String org = request.getParameter("organization");
    String duration = request.getParameter("duration");

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

        PreparedStatement ps = con.prepareStatement("INSERT INTO education (mentor_username, course_name, organization, duration) VALUES (?, ?, ?, ?)");
        ps.setString(1, mentor);
        ps.setString(2, course);
        ps.setString(3, org);
        ps.setString(4, duration);
        ps.executeUpdate();

        con.close();

        // Redirect back to dashboard
        response.sendRedirect("mentordashboard.jsp");
    } catch (Exception e) {
        out.println();
    }
%>
