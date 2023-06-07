package DB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
//import java.sql.Statement;

public class DBConnection {
	Connection con;
	PreparedStatement ps;
	public DBConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/radhakrishna","root","root");
		}	catch(ClassNotFoundException e) {}
			catch(SQLException a) {System.out.println(a.getMessage());}
		}
	
	public void closeConnection() {
		try {
			con.close();
		} catch (SQLException e) {}
		}
	
		public PreparedStatement getStatement(String query) throws Exception
		{
			ps= con.prepareStatement(query);
			return ps;
	}
}


