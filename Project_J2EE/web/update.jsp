<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Chỉnh sửa thông tin máy tính</title>
    <a href="index.jsp" class="homebutton">Trang chủ</a>
    <link rel="stylesheet" href="update.css">
    <link rel="shortcut icon" type="image/png" href="favicon.ico"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <header>
        <h1>Cập nhật thông tin</h1>
    </header>

    <form action="" method="POST">
        <label>Tìm thông tin máy: </label>
        <input type="text" name="IP_Search" placeholder="IP" required> 
        <input type="submit" value="Tìm" class="find">
    </form>
    <br>
    <%-- Retrieve and display data based on search or entire table --%>
    <%
      Connection connection = null;
      PreparedStatement preparedStatement = null;
      ResultSet resultSet = null;

      try {
        // Database connection details (replace with your actual credentials)
        String jdbcDriver = "com.mysql.jdbc.Driver";
        Class.forName(jdbcDriver);
        String dbURL = "jdbc:mysql://localhost:3306/db_quanlymaytinh";
        String username = "root";
        String password = "";  // Replace with your actual password

        connection = DriverManager.getConnection(dbURL, username, password);

        // Check if IP search parameter is present
        String ipSearch = request.getParameter("IP_Search");

        String query;
        if (ipSearch != null && !ipSearch.isEmpty()) {
          query = "SELECT * FROM tt_computer WHERE IP = ?";
          preparedStatement = connection.prepareStatement(query);
          preparedStatement.setString(1, ipSearch);
          resultSet = preparedStatement.executeQuery();
        } else {
          query = "SELECT * FROM tt_computer";
          preparedStatement = connection.prepareStatement(query);
          resultSet = preparedStatement.executeQuery();
        }

        if (resultSet.next()) {
          // Display table header
    %>
    <table>
        <tr>
            <th rowspan="2">Địa chỉ máy</th>
            <th rowspan="2">Hệ điều hành</th>
            <th rowspan="2">Vai trò</th>
            <th rowspan="2">Người quản trị</th>
            <th colspan="2">Thông tin</th>
            <th rowspan="2">Trạng thái</th>
            <th rowspan="2">Chỉnh sửa thông tin</th>
        </tr>
        <tr>
            <th>RAM</th>
            <th>Tổng bộ nhớ ảo</th>
        </tr>
        <%
              do {
                String IP = resultSet.getString("IP");
                String HeDieuHanh = resultSet.getString("HeDieuHanh");
                String VaiTro = resultSet.getString("VaiTro");
                String user = resultSet.getString("user");
                String ram = resultSet.getString("in4_Ram");
                String rom = resultSet.getString("in4_Rom");
                String TrangThai = resultSet.getString("status");
        %>
        <tr>
            <td><%= IP %></td>
            <td><%= HeDieuHanh %></td>
            <td><%= VaiTro %></td>
            <td><%= user %></td>
            <td><%= ram %></td>
            <td><%= rom %></td>
            <td><%= TrangThai %></td>
            <td colspan="7"><button type="button" class="capnhat" onclick="showUpdateForm('<%= IP %>', '<%= HeDieuHanh %>', '<%= VaiTro %>', '<%= ram %>', '<%= rom %>')">Chỉnh sửa</button></td>
        </tr>
        <%
              } while (resultSet.next());
        %>
    </table>
    <%
        } else {
          // No results found message
          if (ipSearch != null && !ipSearch.isEmpty()) {
    %>
    <p>Không tìm thấy máy tính với IP: <%= ipSearch %></p>
    <%
          }
        }
      } catch (SQLException e) {
        // Handle database errors (e.g., print error message)
        out.println("Error connecting to database: " + e.getMessage());
      } finally {
        // Close resources
        try {
          if (resultSet != null) {
            resultSet.close();
          }
          if (preparedStatement != null) {
            preparedStatement.close();
          }
          if (connection != null) {
            connection.close();
          }
        } catch (SQLException e) {
          out.println("Error closing resources: " + e.getMessage());
        }
      }
    %>

    <form action="./Update" method="POST" style="display: none">
        <table>
            <h3>Chỉnh sửa thông tin máy tính hệ thống</h3>
            <td colspan="5"><h3>Nhập thông tin chỉnh sửa </h3></td>

            <tr>
                <th>Địa chỉ máy</th>
                <th>Hệ điều hành</th>
                <th>Vai trò</th>
                <th>Dung lượng RAM (GB)</th>
                <th>Dung lượng bộ nhớ ảo (GB)</th>
            </tr>
            <tr>
                <td><input type="text" name="IP" placeholder="Nhập địa chỉ máy" readonly></td>
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
                    <input type="text" name="RAM" placeholder="Nhập dung lượng RAM" required>
                </td>
                <td>
                    <input type="text" name="ROM" placeholder="Nhập dung lượng bộ nhớ ảo"required>
                </td>
            </tr>
            <tr>
                <td colspan="5"><input type="submit" value="Chỉnh sửa thông tin"></td>
            </tr>
        </table>
    </form>
    <script>
        function showUpdateForm(IP, HeDieuHanh, VaiTro, ram, rom) {
            document.querySelector('form[action="./Update"] input[name="IP"]').value = IP;
            document.querySelector('form[action="./Update"] select[name="HeDieuHanh"]').value = HeDieuHanh;
            document.querySelector('form[action="./Update"] select[name="Role"]').value = VaiTro;
            document.querySelector('form[action="./Update"] input[name="RAM"]').value = ram;
            document.querySelector('form[action="./Update"] input[name="ROM"]').value = rom;
            document.querySelector('form[action="./Update"]').style.display = "block";
        }
    </script>


</body>
</html>
