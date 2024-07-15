/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.home;

import dal.AccountDAO;
import dal.ClubDAO;
import dal.ClubDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Category;
import model.Club;
import model.GoogleAccount;

/**
 *
 * @author sodok
 */
public class RegisterClubController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("registerclub.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ClubDAO clubDao = new ClubDAO();
        List<Category> listCategories = clubDao.getAllCategories();
        request.setAttribute("listCategories", listCategories);

        String categoryIdParam = request.getParameter("categoryId");

        if (categoryIdParam != null) {
            int categoryId = Integer.parseInt(categoryIdParam);
            request.setAttribute("tag", categoryId);
            List<Club> listClubs = new ClubDBContext().getClubNameByCategoryId(categoryId);
            request.setAttribute("listClubs", listClubs);
        }

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccountByUP(email, password);

        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            request.setAttribute("successMessage", "Yêu cầu thành công, vui lòng chờ đợi kết quả");
        }

        request.getRequestDispatcher("registerclub.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
