package controller.home;

import dal.AccountDAO;
import java.io.IOException;
import config.Validate;
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
public class UpdateProfileController extends HttpServlet {

    Validate validate = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");

        AccountDAO dal = new AccountDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        if (account != null) {
            // Update account information
            int userId = account.getUser_id();  // Get the user_id of the logged-in user
            dal.changeInformations(fullname, username, phone, userId);

            account.setFullname(fullname);
            account.setUsername(username);
            account.setPhone_number(phone);

            // Update account object in session
            session.setAttribute("account", account);

            // Update other session attributes if needed
            session.setAttribute("fullname", fullname);
            session.setAttribute("username", username);
            session.setAttribute("phone", phone);

            // Handle avatar URL
            String avatarUrl = account.getAvatar_url();
            if (avatarUrl == null || avatarUrl.isEmpty()) {
                avatarUrl = "assets/images/avata.png";
            }
            session.setAttribute("avatar_url", avatarUrl);

            request.setAttribute("success", "You have successfully changed your information!");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
