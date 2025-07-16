package MMS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class Table1 {

    public static void main(String[] args) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");
            
            if (con != null) {
                System.out.println("Connection established");
            }

            Statement stat = con.createStatement();
            Scanner sc = new Scanner(System.in);
            int choice = 0;

            while (choice <= 4) {
                System.out.println("\n1. Insert\n2. Delete\n3. Update\n4. Select\n5. Exit");
                System.out.print("Enter your choice: ");
                choice = sc.nextInt();

                switch (choice) {
                    case 1:
                        // Insert Operation
                        PreparedStatement ps = con.prepareStatement("INSERT INTO signin (name, email, password, role) VALUES (?, ?, ?, ?)");
                        System.out.print("Enter Name: ");
                        String name = sc.next();
                        ps.setString(1, name);

                        System.out.print("Enter Email: ");
                        String mail = sc.next();
                        ps.setString(2, mail);

                        System.out.print("Enter Password: ");
                        String password = sc.next();
                        ps.setString(3, password);

                        System.out.print("Enter Role: ");
                        String role = sc.next();
                        ps.setString(4, role);

                        ps.executeUpdate();
                        System.out.println("Record Inserted Successfully");
                        break;

                    case 2:
                        // Delete Operation
                        PreparedStatement ps1 = con.prepareStatement("DELETE FROM signin WHERE email = ?");
                        System.out.print("Enter Email to Delete: ");
                        String deleteMail = sc.next();
                        ps1.setString(1, deleteMail);
                        int deleted = ps1.executeUpdate();
                        if (deleted > 0)
                            System.out.println("Record Deleted Successfully");
                        else
                            System.out.println("No Record Found with given Email");
                        break;

                    case 3:
                        // Update Operation (Optional - updating password)
                        PreparedStatement ps2 = con.prepareStatement("UPDATE signin SET password = ? WHERE email = ?");
                        System.out.print("Enter Email to Update Password: ");
                        String updateMail = sc.next();
                        System.out.print("Enter New Password: ");
                        String newPassword = sc.next();
                        ps2.setString(1, newPassword);
                        ps2.setString(2, updateMail);
                        int updated = ps2.executeUpdate();
                        if (updated > 0)
                            System.out.println("Password Updated Successfully");
                        else
                            System.out.println("No Record Found with given Email");
                        break;

                    case 4:
                        // Select Operation
                        String str = "SELECT * FROM signin";
                        ResultSet rs = stat.executeQuery(str);
                        System.out.println("\nName\t\tEmail\t\t\tPassword\tRole");
                        System.out.println("------------------------------------------------------------");
                        while (rs.next()) {
                            System.out.println(rs.getString("name") + "\t\t" + rs.getString("email") + "\t" + rs.getString("password") + "\t" + rs.getString("role"));
                        }
                        System.out.println("Data Retrieved Successfully");
                        break;

                    case 5:
                        // Exit
                        System.out.println("Exiting...");
                        sc.close();
                        con.close();
                        System.exit(0);
                        break;

                    default:
                        System.out.println("Invalid Choice. Please try again.");
                }
            }

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
