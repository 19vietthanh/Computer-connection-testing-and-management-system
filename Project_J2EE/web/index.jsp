<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Data.User" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Trang quản lý máy tính</title>
        <link rel="stylesheet" href="home.css">
        <link rel="shortcut icon" type="image/png" href="favicon.ico"/>

        <%
            session = request.getSession();
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {             
                response.sendRedirect("dangnhap.html");
                return;
            }
        %>
    <div class="nav">    
        <p class="hello">Xin chào:<h2 class="hello_user"> <%= loggedInUser.getUsername()%></h2></p>
    <form action="inf_user.jsp" method="post">
        <input type="submit" class="homebutton" value="Thông tin User">
    </form>
    <form class="logout-form" action="./Logout" method="post">
        <input type="submit" class="button" name="logout" value="Đăng xuất">
    </form>
</div>
<script>
    // Hàm cập nhật thời gian kết nối
    function updateConnectionTime() {
        var connectionTimeElements = document.querySelectorAll('.connection-time');

        // Lặp qua từng phần tử và cập nhật thời gian kết nối
        connectionTimeElements.forEach(function (element) {
            var currentTime = new Date();
            var lastConnectionTime = new Date(element.dataset.connectionTime);
            var elapsedTime = Math.floor((currentTime - lastConnectionTime) / (1000 * 60)); // Tính thời gian kết nối dựa trên phút

            var displayTime = elapsedTime;
            var timeUnit = 'phút';

            // Nếu thời gian kết nối lớn hơn hoặc bằng 60 phút
            if (elapsedTime >= 60) {
                displayTime = Math.floor(elapsedTime / 60); // Chuyển đổi sang giờ
                timeUnit = 'giờ';
                if (displayTime >= 24) {
                    displayTime = Math.floor(displayTime / 24); // Chuyển đổi sang ngày
                    timeUnit = 'ngày';
                }
            }

            element.textContent = displayTime + " " + timeUnit + " trước";
        });
    }

    // Cập nhật thời gian kết nối mỗi 1 giây
    setInterval(updateConnectionTime, 1000);


</script>
</head>

<body>

    <header>
        <h1>Hệ thống quản lý kết nối máy tính</h1>
    </header>

    <form action="./PingServlet" method="POST">
        <table>
            <h3>Thêm máy tính vào hệ thống</h3>
            <td colspan="5"><h3>Nhập thông tin máy tính </h3></td>


            <tr>
                <th>Địa chỉ máy</th>
                <th>Hệ điều hành</th>
                <th>Vai trò</th>
                <th>Dung lượng RAM (GB)</th>
                <th>Dung lượng đĩa cứng (GB)</th>
            </tr>
            <tr>
                <td><input type="text" name="IP" placeholder="Nhập địa chỉ máy" required></td>
                <td>
                    <select name="HeDieuHanh" required>
                        <option value="">-- Chọn hệ điều hành --</option>
                        <option value="Windows">Windows</option>
                        <option value="Linux">Linux</option>
                        <option value="MacOS">MacOS</option>
                    </select>
                </td>
                <td>
                    <select name="Role" required>
                        <option value="">-- Chọn vai trò --</option>
                        <option value="QuanTri">Quản trị</option>
                        <option value="CaNhan">Cá nhân</option>
                    </select>
                </td>
                <td>
                    <input type="Number" name="RAM" placeholder="Nhập dung lượng RAM" required></td>
                <td>
                    <input type="Number" name="ROM" placeholder="Nhập dung lượng đĩa cứng" required>
                </td>
            </tr>
            <tr>
                <td colspan="5"><input type="submit" value="Thêm máy tính"></td>
            </tr>
        </table>
    </form>

    <%
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            // Kết nối đến cơ sở dữ liệu
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_quanlymaytinh", "root", "");

            // Truy vấn dữ liệu từ bảng tt_computer cho user đăng nhập
            String query = "SELECT * FROM tt_computer WHERE user=?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, loggedInUser.getUsername());
            resultSet = preparedStatement.executeQuery();

            // Hiển thị dữ liệu trong bảng
    %>
    <hr>
    <h3>Danh sách máy tính</h3>
    <table>
        <tr>
        <form action="./TestConn" method="GET">
            <input type="submit" class="button" value="Kiểm tra kết nối">
        </form>
        <a href="update.jsp" class="update">Chỉnh sửa thông tin</a>

        <form action="./delete" method="POST" onsubmit="return confirmAllDelete();">
            <input type="submit" class="delete" value="Xóa tất cả dữ liệu">
        </form>

    </tr>
    <br>
    <tr>
        <th rowspan="2">Địa chỉ máy</th>
        <th rowspan="2">Hệ điều hành</th>
        <th rowspan="2">Vai trò</th>
        <th colspan="2">Thông tin</th>
        <th rowspan="2">Trạng thái</th>
        <th rowspan="2">Thời gian kết nối</th>
        <th rowspan="2" style="color: #ff6600">Xóa</th>
    </tr>
    <tr>
        <th>RAM</th>
        <th>Hard disk</th>
    </tr>
    <%
            while (resultSet.next()) {
                String IP = resultSet.getString("IP");
                String HeDieuHanh = resultSet.getString("HeDieuHanh");
                String VaiTro = resultSet.getString("VaiTro");
                String ram = resultSet.getString("in4_Ram");
                String rom = resultSet.getString("in4_Rom");
                String TrangThai = resultSet.getString("status");
                String lastConnectionTimeString = resultSet.getString("Time_conn");

    %>
    <tr>
        <td><%= IP %></td>
        <td><%= HeDieuHanh %></td>
        <td><%= VaiTro %></td>
        <td><%= ram %></td>
        <td><%= rom %></td>
        <td><%= TrangThai %></td>
        <td class="connection-time" data-connection-time="<%= lastConnectionTimeString %>">0 phút trước</td>
        <td>
            <%--Xóa từng máy trong hệ thống--%>
            <form action="./xoamay" method="POST" onsubmit="return confirmDelete();">
                <input type="hidden" name="IP" value="<%= IP %>">
                <input type="submit" value="️🗑️">
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối, câu lệnh và bộ kết quả
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</table>
<script>
    function confirmAllDelete() {
        return confirm("Bạn có chắc chắn muốn xóa tất cả dữ liệu không?");
    }
    function confirmDelete() {
        return confirm("Bạn có chắc chắn muốn xóa máy này không?");
    }
</script>

</body>


</html>
