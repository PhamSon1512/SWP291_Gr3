package controller.home;

import config.Encode;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author sodok
 */
public class ChangePasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        request.getRequestDispatcher("profile.jsp.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String oldPassword = request.getParameter("oldpassword");
        String newPassword = request.getParameter("newpassword");
        String confirmPassword = request.getParameter("renewpassword");

        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            String decodedPassword = Encode.deCode(account.getPassword());
            if (decodedPassword.equals(oldPassword)) {
                if (newPassword.equals(confirmPassword)) {
                    String encodedNewPassword = Encode.enCode(newPassword);
                    AccountDAO accountDAO = new AccountDAO();
                    accountDAO.updatePasswordByEmail(account.getEmail(), encodedNewPassword);

                    account.setPassword(encodedNewPassword);
                    session.setAttribute("account", account);

                    request.setAttribute("passsuccess", "You have successfully changed your password!");
                } else {
                    request.setAttribute("passerror", "New password does not match!");
                }
            } else {
                request.setAttribute("passerror", "Old password is incorrect!");
            }
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
