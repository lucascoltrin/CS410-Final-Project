import java.sql.*;

public class ConnTest {
  public static void main(String[] args) throws Exception {
    String url = "jdbc:mysql://localhost:3306/";
    try (Connection c = DriverManager.getConnection(url, System.getenv("DB_USER"), System.getenv("DB_PASS"));
         Statement s = c.createStatement();
         ResultSet r = s.executeQuery("SELECT VERSION()")) {
      r.next();
      System.out.println("Connected to MySQL " + r.getString(1) + " at " + url);
    }
  }
}