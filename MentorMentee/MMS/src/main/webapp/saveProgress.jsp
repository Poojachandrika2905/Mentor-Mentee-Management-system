<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String taskName = request.getParameter("taskName");
    String userName = (String) session.getAttribute("userName");

    if (taskName != null && userName != null) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

            // Check if already exists to avoid duplicates
            String checkQuery = "SELECT * FROM progress WHERE userName=? AND courseName=? AND taskName=?";
            ps = conn.prepareStatement(checkQuery);
            ps.setString(1, userName);
            ps.setString(2, "Full Stack Development");
            ps.setString(3, taskName);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                // Insert if not already present
                ps.close();
                String insertQuery = "INSERT INTO progress(userName, courseName, taskName) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setString(1, userName);
                ps.setString(2, "Full Stack Development");
                ps.setString(3, taskName);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
%>
