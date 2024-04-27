package Servlet;

import Data.User;
import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Servlet implementation class PingServlet
 */
public class PingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/db_quanlymaytinh";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "";

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String IP = request.getParameter("IP");
        String HDH = request.getParameter("HeDieuHanh");
        String Role = request.getParameter("Role");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String ND = user.getUsername();

        // Ping to the IP address
        boolean isReachable = isReachable(IP);

        // Get computer information if reachable
        String systemInfo = "";
        if (isReachable) {
            if (HDH.equalsIgnoreCase("Windows")) {
                systemInfo = getWindowsSystemInfo();
            } else if (HDH.equalsIgnoreCase("Linux")) {
                systemInfo = getLinuxSystemInfo();
            }else if (HDH.equalsIgnoreCase("MacOS")) {
//                systemInfo = getLinuxSystemInfo();
            }
        }

        // Extract RAM and ROM information from systemInfo
        String ram = "";
        String rom = "";

        String regexRam = "Total Physical Memory:\\s+(\\S+)";
        String regexRom = "Virtual Memory: Max Size:\\s+(\\S+)";

        Pattern patternRam = Pattern.compile(regexRam);
        Pattern patternRom = Pattern.compile(regexRom);

        Matcher matcherRam = patternRam.matcher(systemInfo);
        Matcher matcherRom = patternRom.matcher(systemInfo);

        if (matcherRam.find()) {
            ram = matcherRam.group(1);
        }

        if (matcherRom.find()) {
            rom = matcherRom.group(1);
        }

        // Set response content type
        response.setContentType("text/html");

        // Write response
        try (PrintWriter out = response.getWriter()) {
            if (isReachable) {
                String status = "Online ✅";
                // Save data to the database if connection successful
                try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD); PreparedStatement statement = connection.prepareStatement("INSERT INTO tt_computer (user, IP, HeDieuHanh, VaiTro, in4_Ram, in4_Rom, status) VALUES (?, ?, ?, ?, ?, ?, ?)")) {
                    statement.setString(1, ND);
                    statement.setString(2, IP);
                    statement.setString(3, HDH);
                    statement.setString(4, Role);
                    statement.setString(5, ram);
                    statement.setString(6, rom);
                    statement.setString(7, status);
                    statement.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Lỗi khi lưu dữ liệu vào database!</p>");
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

    private String getWindowsSystemInfo() {
        try {
            Process process = Runtime.getRuntime().exec("systeminfo");
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Total Physical Memory")) {
                    output.append(line).append("\n");
                } else if (line.startsWith("Virtual Memory: Max Size")) {
                    output.append(line).append("\n");
                }
            }
            return output.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return "Error getting system info";
        }
    }

    private String getLinuxSystemInfo() {
        try {
            Process process = Runtime.getRuntime().exec("free -h");
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith("Mem:") || line.startsWith("Swap:")) {
                    output.append(line).append("\n");
                }
            }
            return output.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return "Error getting system info";
        }
    }

}
