package Servlet;

import Data.User;
import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.net.*;
import java.util.Scanner;

/**
 *
 * @author Viet Thanh
 */

public class PingServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/db_quanlymaytinh";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String IP = request.getParameter("IP");
        String HDH = request.getParameter("HeDieuHanh");
        String Role = request.getParameter("Role");
        String tt_ram = request.getParameter("RAM");
        String tt_rom = request.getParameter("ROM");

        HttpSession session = request.getSession();
        User user;
        user = (User) session.getAttribute("user");
        String ND = user.getUsername();

        // Ping to the IP address
        boolean isReachable = isReachable(IP);

        // Get computer information if reachable
        if (isReachable) {
        }

        // Set response content type
        response.setContentType("text/html");

        // Write response
        try (PrintWriter out = response.getWriter()) {

            if (isReachable) {
                String status = "Online ✅";
                // Lưu dữ liệu vào database nếu kết nối thành công
                if (isReachable) {
                    try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD); 
                        PreparedStatement statement = connection.prepareStatement("INSERT INTO tt_computer (user, IP, HeDieuHanh, VaiTro, in4_Ram, in4_Rom, status) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
                        statement.setString(1, ND);
                        statement.setString(2, IP);
                        statement.setString(3, HDH);
                        statement.setString(4, Role);
                        statement.setString(5, tt_ram);
                        statement.setString(6, tt_rom);
                        statement.setString(7, status);

                        statement.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Lỗi khi lưu dữ liệu vào database!</p>");
                    }
                }
            }
            out.println("</body>");
            out.println("</html>");
            response.sendRedirect("index.jsp");
        }
    }

    private boolean isReachable(String IP) {
        try {
            // Replace "1000" with your preferred timeout in milliseconds
            return InetAddress.getByName(IP).isReachable(1000);
        } catch (IOException e) {
            return false;
        }
    }

}
