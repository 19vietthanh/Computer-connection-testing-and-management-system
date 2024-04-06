/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */


import Data.User;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

/**
 *
 * @author Viet Thanh
 */
public class Welcome extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

//        processRequest(request, response);
        HttpSession session = request.getSession();
        User user;
        user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("dangnhap.html");
        }
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Welcome Servlet</title>");
            out.println("<link rel=\"stylesheet\" href=\"welstyle.css\">");
            out.println("<link rel=\"shortcut icon\" type=\"image/png\" href=\"favicon.ico\"/>\n");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Chào bạn: " + user.getUsername() + "</h1>");
            out.println("<a href=\"./index.jsp\" class=\"button\">Trang chủ</a>");
            out.println("<form class=\"logout-form\" action=\"./Logout\" method=\"post\">");
            out.println("<input type=\"submit\" class=\"button\" name=\"logout\" value=\"Đăng xuất\">"); 
            out.println("</form>");
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
        }
    }

}
