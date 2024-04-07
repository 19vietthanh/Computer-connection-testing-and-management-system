package Servlet;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Viet Thanh
 */
public class xoamay extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String IP = request.getParameter("IP");

        if (IP == null || IP.isEmpty()) {
            response.getWriter().println("IP address is required");
            return;
        }
        try {
            // Connect to database (replace with your connection details)
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

            // Prepare delete statement
            Statement statement = null;
            statement = connection.createStatement();

            String query = "DELETE FROM tt_computer WHERE IP=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, IP);

            // Execute the delete statement
            preparedStatement.executeUpdate();

            // Close resources
            preparedStatement.close();
            connection.close();

            // Redirect to main page after successful delete
            response.sendRedirect("index.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(delete.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
