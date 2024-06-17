package controller.home;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.GoogleAccount;

public class CheckLoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Extract the Google authorization code
        String code = request.getParameter("code");
        if (code != null) {
            Google gg = new Google();
            String accessToken = gg.getToken(code);
            System.out.println("Access Token: " + accessToken);
            GoogleAccount googleAccount = gg.getUserInfo(accessToken);
            System.out.println("Google Account: " + googleAccount);

            AccountDAO adb = new AccountDAO();
            Account existingAccount = adb.getAccountsByEmail(googleAccount.getEmail());

            if (existingAccount == null) {
                // Google account doesn't exist, create a new one
                adb.insertAccount(googleAccount.getName(), googleAccount.getFamily_name(), googleAccount.getEmail(), "", "defaultPassword", 1, 0);
                request.setAttribute("success", "Login successful!");
            }
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
        Account account = dal.getAccountByUP(email, password); // No need to decode the password

        request.setAttribute("email", email);

        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);

            if (account.getSetting().getStatus() == 1 && account.getStatus() == 1) {
                response.sendRedirect("adminController");
            } else {
                request.setAttribute("UserLogin", account.getFullname());
                response.sendRedirect("home");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
