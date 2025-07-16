package MMS;

import java.beans.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Signin
 */
@WebServlet("/learnMentor")
public class learnMentor extends HttpServlet {
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
				java.sql.Statement stmt =  con.createStatement();
				//step 4: query processing;
				String str = "create table enrollMentor(username varchar(20),courseName varchar(100))";
								//running ;
				((java.sql.Statement) stmt).executeUpdate(str);
				// step 5 : connection close;
				con.close();
				System.out.println("table created");
				}
				catch(ClassNotFoundException e) {
					System.out.println(e);
				}
				catch(SQLException e) {
					System.out.println(e);
				}
				
	}

}























