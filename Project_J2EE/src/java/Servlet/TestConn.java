package Servlet;

import java.io.*;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.net.InetAddress;

public class TestConn extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Connection objects
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement updateStmt = null; // New for updating the database

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");
            stmt = conn.createStatement();

            // Truy vấn lấy tất cả IP
            String sql = "SELECT IP FROM tt_computer";
            rs = stmt.executeQuery(sql);

            // Duyệt qua từng IP and ping
            while (rs.next()) {
                String ip = rs.getString("IP");
                String status = ping(ip);

                // Update the database with the ping status
                updateStmt = conn.prepareStatement("UPDATE tt_computer SET status = ? WHERE IP = ?");
                updateStmt.setString(1, status);
                updateStmt.setString(2, ip);
                updateStmt.executeUpdate(); // Execute the update
          
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Lỗi: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (updateStmt != null) { // Close the update statement
                    updateStmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }

        // Chuyển về trang index.jsp
        response.sendRedirect("index.jsp");
    }

    private String ping(String ip) {
        String status = "Offline ❌";
        try {
            // Replace "1000" with your preferred timeout in milliseconds
            if (InetAddress.getByName(ip).isReachable(1000)) {
                status = "Online ✅️";
            }
        } catch (IOException e) {

        }
        return status;
    }
}
