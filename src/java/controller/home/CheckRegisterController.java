package controller.home;
import config.Encode;
import config.Validate;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

public class CheckRegisterController extends HttpServlet {
    Validate validate = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Forward to the registration page
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        String password = request.getParameter("password");
        String repassword = request.getParameter("confirmPassword");
        String rphone = request.getParameter("phoneNumber");
        String user_name = request.getParameter("fullname");
        int setting = 1; // Active user by default
        int status = 0; // Regular user by default

        // Keep the entered data
        request.setAttribute("fullname", name);
        request.setAttribute("email", email);
        request.setAttribute("phoneNumber", rphone);

        // Validate input fields
        boolean hasErrors = false;
        if (!validate.checkFullName(name)) {
            request.setAttribute("fullnameError", "Invalid full name. Please enter a valid name.");
            hasErrors = true;
        }
        if (!validate.checkEmail(email)) {
            request.setAttribute("emailError", "Invalid email format. Please enter a valid email.");
            hasErrors = true;
        }
        if (!validate.checkPassword(password)) {
            request.setAttribute("passwordError", "Invalid password. Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit, and a special character.");
            hasErrors = true;
        }
        if (!password.equals(repassword)) {
            request.setAttribute("confirmPasswordError", "Passwords do not match.");
            hasErrors = true;
        }
        if (!validate.checkPhone(rphone)) {
            request.setAttribute("phoneNumberError", "Invalid phone number. Please enter a valid 10-digit phone number.");
            hasErrors = true;
        }

        if (hasErrors) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // Encrypt password before storing in the database
            String encryptedPassword = Encode.enCode(password);
             
            AccountDAO adb = new AccountDAO();
            Account account = adb.getAccountsByEmail(email);
            if (account == null) {
                    adb.insertAccount(name, user_name, email, rphone, encryptedPassword, setting, status);
                    request.setAttribute("success", "Registration successful!");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("emailError", "Email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Register Controller";
    }
}