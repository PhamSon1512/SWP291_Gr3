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
        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        
        request.setAttribute("fullname", name);
        request.setAttribute("phone", phone);
        request.setAttribute("username", username);

        AccountDAO dal = new AccountDAO();
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");

        boolean hasErrors = false;
        if (!validate.checkFullName(name)) {
            request.setAttribute("fullnameError", "Invalid full name. Please enter a valid name.");
            hasErrors = true;
        }
        if (!validate.checkPhone(phone)) {
            request.setAttribute("phoneNumberError", "Invalid phone number. Please enter a valid 10-digit phone number.");
            hasErrors = true;
        }
        if(!validate.checkUsername(username)){
            request.setAttribute("usernameError", "Invalid username. Please enter a valid username");
            hasErrors = true;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
