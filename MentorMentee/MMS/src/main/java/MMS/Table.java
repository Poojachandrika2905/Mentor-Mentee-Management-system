package MMS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Table
 */
@WebServlet("/Table")
public class Table extends HttpServlet {
    public static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
            if (con != null) {
                System.out.println("Connection established");
            }

            Scanner sc = new Scanner(System.in);
            int choice = 0;

            while (choice <= 4) {
                System.out.println("1. Insert 2. Delete 3. Update 4. Select");
                System.out.print("Enter your choice: ");
                choice = sc.nextInt();

                switch (choice) {
                    case 1:
                        insertRecord(con, sc);
                        break;
                    case 2:
                        deleteRecord(con, sc);
                        break;
                    case 3:
                        // Implement update logic if needed
                        break;
                    case 4:
                        selectRecords(con);
                        break;
                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            }
            sc.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void insertRecord(Connection con, Scanner sc) throws Exception {
        PreparedStatement ps = con.prepareStatement("INSERT INTO signin (name, mail, password, role) VALUES (?, ?, ?, ?)");
        System.out.print("Enter name: ");
        String name = sc.next();
        ps.setString(1, name);

        System.out.print("Enter mail: ");
        String mail = sc.next();
        ps.setString(2, mail);

        System.out.print("Enter password: ");
        String pwd = sc.next();
        ps.setString(3, pwd);

        System.out.print("Enter role: ");
        String role = sc.next();
        ps.setString(4, role);

        ps.executeUpdate();
        System.out.println("Values inserted");
    }

    private void deleteRecord(Connection con, Scanner sc) throws Exception {
        PreparedStatement ps1 = con.prepareStatement("DELETE FROM signin WHERE name = ?");
        System.out.print("Enter name to delete: ");
        String name = sc.next();
        ps1.setString(1, name);
        ps1.executeUpdate();
        System.out.println("Required record is deleted");
    }

    private void selectRecords(Connection con) throws Exception {
        Statement stat = con.createStatement();
        String str1 = "SELECT * FROM stattendance";
        ResultSet rs = stat.executeQuery(str1);
        while (rs.next()) {
            System.out.println(rs.getString(1) + "\t" + rs.getString(2) + "\t" + rs.getString(3) + "\t" + rs.getString(4));
        }
        System.out.println("Data retrieved");
    }
}