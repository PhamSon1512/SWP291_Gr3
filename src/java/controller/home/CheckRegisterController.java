package controller.home;

import config.EncodeData;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

public class CheckRegisterController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Accessing Data Access Object for Account
        // Retrieving user input from the registration form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String name = firstName + lastName;
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("confirmPassword");
        String enpassword = EncodeData.enCode(password);
        String rphone = request.getParameter("phoneNumber");
        int role_id = 0;
        if (!password.equals(repassword)) {

            request.setAttribute("error", "Password do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } else {

            AccountDAO adb = new AccountDAO();
            Account a = adb.getAccountByEmail(email);
            if (a == null) {
                String encodedPassword = EncodeData.enCode(password);
                adb.insertAccount(name, email, rphone, password, role_id, 0);
                request.setAttribute("success", "Registration successful!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);

            }
        }
//        // Assuming default values for role_id, img, and status
//       
//
//        // Encoding password
//        String enpassword = EncodeData.enCode(password);
//
//        // Converting phone number to integer
//        int phone = Integer.parseInt(rphone);
//
//        // Capitalizing the first letter of the name
//        String fullname = Validate.capitalizeFirstLetter(name);
//
//        // Checking if the email already exists in the database
//        Account existingAccount = accountDAO.getAccountByEmail(email);
//
//        // If the account already exists, forward back to registration page with an error message
//        if (existingAccount != null) {
//            request.setAttribute("error", "Email hoặc username đã tồn tại trên hệ thống!");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
//
//        // If passwords match, insert the new account into the database
//        if (password.equals(repassword)) {
//            accountDAO.insertAccount(acc_ID, fullname, email, rphone, enpassword, role_id, phone, img);  //fullname, email, rphone, enpassword, role_id, 1, img
//            request.setAttribute("success", "Bạn đã đăng kí thành công !!!");
//            request.getRequestDispatcher("register.jsp").forward(request, response);
//            return;
//        }
//
//        // If passwords don't match, forward back to registration page with an error message
//        request.setAttribute("error", "Mật khẩu không khớp!");
//        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        return "Register Controller";
    }
}
