/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.home;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author sodok
 */
public class RememberController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RememberController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RememberController at " + request.getContextPath () + "</h1>");
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        // Xử lý lưu tài khoản nếu người dùng chọn "Lưu tài khoản"
        if (rememberMe != null && rememberMe.equals("ON")) {
            Cookie cookieEmail = new Cookie("email", email);
            Cookie cookiePassword = new Cookie("password", password);
            cookieEmail.setMaxAge(60 * 60 * 24); // Thời gian sống là 1 ngày
            cookiePassword.setMaxAge(60 * 60 * 24); // Thời gian sống là 1 ngày
            response.addCookie(cookieEmail);
            response.addCookie(cookiePassword);
            request.setAttribute("email", cookieEmail);
            request.setAttribute("password", cookiePassword);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Xóa cookie tài khoản nếu người dùng không chọn "Lưu tài khoản"
            Cookie cookieEmail = new Cookie("email", "");
            Cookie cookiePassword = new Cookie("password", "");
            cookieEmail.setMaxAge(0);
            cookiePassword.setMaxAge(0);
            response.addCookie(cookieEmail);
            response.addCookie(cookiePassword);
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
