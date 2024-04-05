package Servlet;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.sql.*;

public class DangKy extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Lấy thông tin từ form đăng ký
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Thực hiện việc kết nối cơ sở dữ liệu
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

            // Tạo truy vấn để thêm thông tin đăng ký vào cơ sở dữ liệu
            String sql = "INSERT INTO users (fullname, username, password, email) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, fullname);
            pstmt.setString(2, username);
            pstmt.setString(3, password);
            pstmt.setString(4, email);

            // Thực thi truy vấn
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Đăng ký thành công
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Đăng ký thành công');");
                out.println("location='dangnhap.html';");
                out.println("</script>");
            } else {
                // Đăng ký thất bại
                response.sendRedirect("dangky.html");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối và tài nguyên
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }
}