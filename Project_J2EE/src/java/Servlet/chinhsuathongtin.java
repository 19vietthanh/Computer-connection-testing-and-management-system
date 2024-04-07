package Servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 *
 * @author Viet Thanh
 */

public class chinhsuathongtin extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String newFullName = request.getParameter("fullname");
        String newEmail = request.getParameter("email");
        String newPassword = request.getParameter("password");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

            String query = "UPDATE users SET fullname=?, email=?, password=? WHERE username=?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, newFullName);
            preparedStatement.setString(2, newEmail);
            preparedStatement.setString(3, newPassword);
            preparedStatement.setString(4, username);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Chỉnh sửa thành công');");
                out.println("window.location.href = 'dangnhap.html';");
                out.println("</script>");
                HttpSession session = request.getSession();
                session.invalidate(); // Hủy session để đăng xuất
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Không thể chỉnh sửa. Vui lòng thử lại sau');");
                out.println("window.location.href = 'inf_user.jsp';");
                out.println("</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Đã xảy ra lỗi khi chỉnh sửa');");
            out.println("window.location.href = 'inf_user.jsp';");
            out.println("</script>");
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
