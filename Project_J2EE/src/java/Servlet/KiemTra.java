package Servlet;

import Data.User;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 *
 * @author Viet Thanh
 */

public class KiemTra extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            // Lấy thông tin từ form đăng nhập
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            User nd = new User();
            nd.setUsername(username);
            nd.setPassword(password);

            // Thực hiện việc kết nối cơ sở dữ liệu
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

                // Tạo truy vấn để kiểm tra thông tin đăng nhập từ cơ sở dữ liệu
                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);

                // Thực thi truy vấn
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    // Đăng nhập thành công đưa người dùng vào vào session
                    HttpSession session = request.getSession();
                    session.setAttribute("user", nd);
                    // Chuyển hướng đến trang chủ (index.jsp) 
                    response.sendRedirect("index.jsp");
                } else {
                    // Đăng nhập thất bại alert 
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Incorrect username or password');");
                    out.println("location='dangnhap.html';");
                    out.println("</script>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } finally {
                // Đóng kết nối và tài nguyên
                try {
                    if (rs != null) {
                        rs.close();
                    }
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

            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
