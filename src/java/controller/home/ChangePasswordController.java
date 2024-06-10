package controller.home;

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
        request.getRequestDispatcher("recover.jsp").forward(request, response);
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

        if (account != null && account.getPassword().equals(oldPassword)) {
            if (newPassword.equals(confirmPassword)) {
                AccountDAO accountDAO = new AccountDAO();
                accountDAO.updatePasswordByEmail(account.getEmail(), newPassword);

                account.setPassword(newPassword);
                session.setAttribute("account", account);

                request.setAttribute("passsuccess", "Bạn đã thay đổi mật khẩu thành công!");
            } else {
                request.setAttribute("passerror", "Mật khẩu mới không khớp!");
            }
        } else {
            request.setAttribute("passerror", "Mật khẩu cũ không đúng!");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
