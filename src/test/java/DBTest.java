import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet; // Import ResultSet
import java.sql.SQLException;
import java.sql.Statement; // Import Statement

public class DBTest {

    public static void main(String[] args) {
        // --- Database Connection Details ---
        String url = "jdbc:sqlserver://localhost:1433;databaseName=TechSignDB;encrypt=false;trustServerCertificate=true;";
        String user = "techsign";
        String pass = "1234";

        Connection connection = null;
        Statement statement = null; // Declare Statement object
        ResultSet resultSet = null; // Declare ResultSet object

        try {
            // --- Step 1: Load the SQL Server JDBC Driver ---
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("SQL Server JDBC Driver registered successfully!");

            // --- Step 2: Establish the Connection ---
            System.out.println("Attempting to connect to SQL Server database...");
            connection = DriverManager.getConnection(url, user, pass);

            if (connection != null) {
                System.out.println("------------------------------------------");
                System.out.println("SUCCESS: Connected to SQL Server database!");
                System.out.println("------------------------------------------");

                // --- Step 3: Test User Retrieval ---
                System.out.println("\n--- Testing User Retrieval ---");
                
                // Create a Statement object for executing SQL queries
                statement = connection.createStatement();
                
                // SQL query to select all users (adjust columns if your table is different)
                String sqlQuery = "SELECT id, email, full_name, status, created_at FROM users";
                System.out.println("Executing query: " + sqlQuery);
                
                // Execute the query and get the ResultSet
                resultSet = statement.executeQuery(sqlQuery);
                
                // Process the ResultSet
                if (!resultSet.isBeforeFirst()) { // Check if there are any rows
                    System.out.println("No users found in the 'users' table.");
                } else {
                    System.out.println("\n--- Retrieved Users ---");
                    // Loop through each row in the ResultSet
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String email = resultSet.getString("email");
                        String fullName = resultSet.getString("full_name");
                        String status = resultSet.getString("status");
                        java.sql.Timestamp createdAt = resultSet.getTimestamp("created_at"); // DATETIME maps to Timestamp

                        System.out.println("ID: " + id + 
                                           ", Email: " + email + 
                                           ", Name: " + fullName + 
                                           ", Status: " + status +
                                           ", Created At: " + createdAt);
                    }
                    System.out.println("--------------------------");
                }

            } else {
                System.out.println("FAILURE: Failed to establish connection to SQL Server database. Connection object is null.");
            }

        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: SQL Server JDBC Driver not found. Please ensure 'mssql-jdbc-X.X.X.jar' is correctly added to your project's classpath.");
            System.err.println("Details: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("ERROR: SQL Exception occurred.");
            System.err.println("Reason: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("ERROR: An unexpected error occurred.");
            System.err.println("Details: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // --- Step 4: Close Resources ---
            // Close ResultSet, Statement, and Connection in reverse order of creation
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
                System.out.println("Database resources closed successfully.");
            } catch (SQLException e) {
                System.err.println("WARNING: Error closing database resources.");
                System.err.println("Details: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
}