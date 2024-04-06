<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Data.User" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Thông tin cá nhân</title>
        <link rel="stylesheet" href="">
        <link rel="shortcut icon" type="image/png" href="favicon.ico"/>
    </head>

    <body>
        <%
            session = request.getSession();
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {
                response.sendRedirect("dangnhap.html");
            } else {
                Connection connection = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

                    String query = "SELECT fullname, username, email FROM users WHERE username=?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, loggedInUser.getUsername());
                    ResultSet rs = preparedStatement.executeQuery();

                    if (rs.next()) {
                        String fullname = rs.getString("fullname");
                        String username = rs.getString("username");
                        String email = rs.getString("email");
        %>
        <h1>User Information</h1>
        <p>Full Name: <%= fullname %></p>
        <p>Username: <%= username %></p>
        <p>Email: <%= email %></p>
        <form action="chinhsuathongtin" method="post">
            <input type="hidden" name="username" value="<%= username %>">
            <input type="submit" value="Edit">
        </form>
        <%
                    }
                    rs.close();
                    preparedStatement.close();
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    // Xử lý lỗi khi kết nối cơ sở dữ liệu hoặc thực hiện truy vấn
                } finally {
                    try {
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        // Xử lý lỗi khi đóng kết nối
                    }
                }
            }
        %>
    </body>
</html>
