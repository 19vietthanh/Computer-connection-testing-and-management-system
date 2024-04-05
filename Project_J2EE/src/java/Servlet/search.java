package Servlet;

import java.io.*;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class search extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/db_quanlymaytinh";
    private static final String DB_USER = "root";  // Replace with a secure username
    private static final String DB_PASSWORD = ""; // Replace with a secure password (store securely)

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ipToSearch = request.getParameter("IP_Search");

        // Prepare a secure SQL statement to prevent SQL injection
        String query = "SELECT * FROM tt_computer WHERE IP = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish a connection
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Use a PreparedStatement to prevent SQL injection
            statement = connection.prepareStatement(query);
            statement.setString(1, ipToSearch);   // Bind the search parameter

            // Execute the query
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String IP = resultSet.getString("IP");
                String HeDieuHanh = resultSet.getString("HeDieuHanh");
                String VaiTro = resultSet.getString("VaiTro");
                String user = resultSet.getString("user");
                String ram = resultSet.getString("in4_Ram");
                String rom = resultSet.getString("in4_Rom");
                String TrangThai = resultSet.getString("status");

            } else {
            }
        } catch (SQLException e) {
        } finally {
            // Close resources in a finally block to ensure proper cleanup
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException se) {
                se.printStackTrace(); // Handle exceptions more gracefully in production
            }
        }
    }
}
