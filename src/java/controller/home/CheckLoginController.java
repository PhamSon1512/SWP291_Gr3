/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import config.EncodeData;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author sodok
 */
public class CheckLoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginController at " + request.getContextPath() + "</h1>");
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

        AccountDAO dal = new AccountDAO();
        Account account = dal.getAccountByEmail(email);

        if (account == null) {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("loginError", "Email or Pasword is incorrect ");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (account != null) {
            Cookie userCookies = new Cookie("email", email);
            Cookie passwordCookies = new Cookie("password", password);
            Cookie phoneCookies = new Cookie("phone", account.getPhone_number());
            // 15 ngày, tính bằng giây.
            userCookies.setMaxAge(3600 * 24 * 15);
            passwordCookies.setMaxAge(3600 * 24 * 15);
            response.addCookie(userCookies);
            response.addCookie(passwordCookies);
            response.addCookie(phoneCookies);

            if (account.getRoleID() == 1) {
                response.sendRedirect("adminController");
            } else {
                request.setAttribute("UserLogin", account.getName());
                response.sendRedirect("homeAfter.jsp");
            }
        } else {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("loginError", "Email or Password is incorrect");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
