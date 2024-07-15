package controller.home;

import Email.JavaMail;
import config.Encode;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import model.GoogleAccount;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginWithGoogle", urlPatterns = {"/logingoogle"})
public class LoginWithGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        Google gg = new Google();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);

        String name = acc.getFamily_name();
        String email = acc.getEmail();
        int setting = 1; // Active user by default
        int status = 0; // Regular user by default
        boolean verified = false;
        String password = RandomPasswordGenerator.generateRandomPassword();
        AccountDAO dal = new AccountDAO();

        GoogleAccount account = dal.getGoogleAccountByEmail(email);
        if (account != null) {
            request.setAttribute("emailError", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            String encodePass = Encode.enCode(password);
            dal.insertAccount(name, name, email, encodePass, setting, status, verified);
            request.setAttribute("success", "Registration successful!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

        boolean isSend = JavaMail.sendEmail(email, password, acc.getFamily_name());
        if (!isSend) {
          
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

      
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    public static class RandomPasswordGenerator {
        private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        private static final SecureRandom random = new SecureRandom();
        private static final int PASSWORD_LENGTH = 16;

        public static String generateRandomPassword() {
            StringBuilder password = new StringBuilder(PASSWORD_LENGTH);
            for (int i = 0; i < PASSWORD_LENGTH; i++) {
                password.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
            }
            return password.toString();
        }
    }
}

//    public class RandomPasswordGenerator {
//
//        private static final SecureRandom random = new SecureRandom();
//        private static final int PASSWORD_LENGTH = 16;
//
//        public static String generateRandomPassword() {
//            byte[] passwordBytes = new byte[PASSWORD_LENGTH];
//            random.nextBytes(passwordBytes);
//            return Base64.getEncoder().encodeToString(passwordBytes);
//        }
//    }