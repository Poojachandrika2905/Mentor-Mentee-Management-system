package MMS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnection {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
				try {
				// Step 1: Register the driver loading the driver class;
				Class.forName("oracle.jdbc.driver.OracleDriver");
				// step 2: Establishing a connection with database creating connection object;
				Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","Durga");
				if(con!=null) {
					System.out.println("connection established Successfully");
				}
				//step 3: statement object creation;
				return;
				}
				catch(ClassNotFoundException e) {
					System.out.println(e);
				}
				catch(SQLException e) {
					System.out.println(e);
				}
				
	}

}
