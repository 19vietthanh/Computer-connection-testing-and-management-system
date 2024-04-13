<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Data.User" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Thông tin cá nhân</title>
        <link rel="stylesheet" href="inf_user.css">
        <link rel="shortcut icon" type="image/png" href="favicon.ico"/>    


    </head>

    <body class="container">

        <a href="index.jsp"><button>Trang chủ</button></a>
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

                    String query = "SELECT fullname, username, email, password FROM users WHERE username=?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, loggedInUser.getUsername());
                    ResultSet rs = preparedStatement.executeQuery();

                    if (rs.next()) {
                        String fullname = rs.getString("fullname");
                        String username = rs.getString("username");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
        %>
        <h1>Thông tin cá nhân </h1>
        <p>Họ và tên: <%= fullname %></p>
        <p>Username: <%= username %></p>
        <p>Email: <%= email %></p>
        <p id="password">Mật khẩu: ********</p>
        <button onclick="document.getElementById('password').innerHTML = 'Mật khẩu: <%= password %>';">Hiện mật khẩu</button>
        <button class="nutchinhsua" type="button" class="cap nhat thong tin" onclick="showUpdateForm('<%= fullname %>', '<%= password %>', '<%= email %>')">Chỉnh sửa</button>

        <form action="./chinhsuathongtin" method="POST" style="display: none">
            <h3>Chỉnh sửa thông tin người dùng</h3>
            <table>
                <tr>
                    <th>Full Name</th>
                    <th>Password</th>
                    <th>Email</th>
                </tr>
                <tr>
                    <td><input type="text" name="fullname" placeholder="Nhập họ tên" required></td>
                    <td><input type="password" name="password" placeholder="Nhập password" required></td>
                    <td><input type="email" name="email" placeholder="Nhập email" required></td>
                <input type="hidden" name="username" value="<%= username %>">
                </tr>
                <tr>
                    <td colspan="4"><input type="submit" value="Chỉnh sửa thông tin"></td>
                </tr>
            </table>
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

        <script>
            function showUpdateForm(fullname, password, email) {
                document.querySelector('form[action="./chinhsuathongtin"] input[name="fullname"]').value = fullname;
                document.querySelector('form[action="./chinhsuathongtin"] input[name="password"]').value = password;
                document.querySelector('form[action="./chinhsuathongtin"] input[name="email"]').value = email;
                document.querySelector('form[action="./chinhsuathongtin"]').style.display = "block";
            }
        </script>

    </body>
</html>
