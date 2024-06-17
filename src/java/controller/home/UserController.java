package controller.home;

import config.Encode;
import config.Validate;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Setting;

/**
 *
 * @author sodok
 */
public class UserController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        Validate validate = new Validate();

        HttpSession session = request.getSession();
        AccountDAO dal = new AccountDAO();

        String action = request.getParameter("action");

        try {
            // login
            if (action.equals("login")) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
                // checklogin
            } else if (action.equals("checklogin")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String remember = request.getParameter("remember");

                Account user = dal.getAccountByUP(email, password);

                if (user == null) {
                    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
                    } else {
                        request.setAttribute("loginError", "Email or password is incorrect!");
                    }
                    request.getRequestDispatcher("user?action=login").forward(request, response);
                } else {
                    Setting userSetting = user.getSetting();
                    int settingStatus = userSetting.getSetting_id();

                    switch (settingStatus) {
                        case 0: // deactive
                            request.setAttribute("loginError", "Your account is deactivated. Please contact support.");
                            request.getRequestDispatcher("user?action=login").forward(request, response);
                            break;
                        case 1: // active
                            int userStatus = user.getStatus();
                            session.setAttribute("account", user);

                            Cookie cemail = new Cookie("email", email);
                            Cookie cpass = new Cookie("pass", password);
                            Cookie rem = new Cookie("remember", remember);

                            if (remember != null) {
                                // 30 days
                                cemail.setMaxAge(60 * 60 * 24 * 30);
                                cpass.setMaxAge(60 * 60 * 24 * 3);
                                rem.setMaxAge(60 * 60 * 24 * 30);
                            } else {
                                cemail.setMaxAge(0);
                                cpass.setMaxAge(0);
                                rem.setMaxAge(0);
                            }

                            response.addCookie(cemail);
                            response.addCookie(cpass);
                            response.addCookie(rem);

                            switch (userStatus) {
                                case 0: // user
                                    response.sendRedirect("home");
                                    break;
                                case 1: // admin
                                    response.sendRedirect("admin/dashboard.jsp");
                                    break;
                                case 2: // manager
                                    response.sendRedirect("managerHomePage.jsp");
                                    break;
                                default:
                                    request.setAttribute("loginError", "Unknown user status. Please contact support.");
                                    request.getRequestDispatcher("user?action=login").forward(request, response);
                                    break;
                            }
                            break;
                        case 2: // banned
                            request.setAttribute("loginError", "Your account is banned. Please contact support.");
                            request.getRequestDispatcher("user?action=login").forward(request, response);
                            break;
                        default:
                            request.setAttribute("loginError", "Unknown account status. Please contact support.");
                            request.getRequestDispatcher("user?action=login").forward(request, response);
                            break;
                    }
                }
            }
            // logout
            if (action.equals("logout")) {
                session.invalidate();
                response.sendRedirect("home");
            }
            // register
            if (action.equals("register")) {
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
            // check register
            if (action.equals("checkregister")) {
                String name = request.getParameter("fullname");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String repassword = request.getParameter("confirmPassword");
                String rphone = request.getParameter("phoneNumber");
                String user_name = request.getParameter("fullname");
                int setting = 1; // Active user by default
                int status = 0; // Regular user by default

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
                    request.setAttribute("passwordError", "Invalid password. Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit.");
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
                    Account account = dal.getAccountsByEmail(email);
                    if (account != null) { // Đã có tài khoản với email này
                        request.setAttribute("emailError", "Email already exists!");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    } else { // Chưa có tài khoản với email này
                        // Encrypt password before storing in the database
                        String encryptedPassword = Encode.enCode(password);
                        dal.insertAccount(name, user_name, email, rphone, encryptedPassword, setting, status);
                        request.setAttribute("success", "Registration successful!");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }
                }
            }
            // recover
            if (action.equals("recover")) {
                request.getRequestDispatcher("checkMail.jsp").forward(request, response);
            }
            // check email
            if (action.equals("checkmail")) {
                String email = request.getParameter("email");
                request.setAttribute(email, "email");

                Account account = dal.getAccountsByEmail(email);
                if (account != null) {
                    request.getRequestDispatcher("OTPMail.jsp").forward(request, response);
                } else {
                    request.setAttribute("emailError", "Email not found");
                    request.getRequestDispatcher("checkMail.jsp").forward(request, response);
                }
            }
            // recover pass
            if(action.equals("recoverpass")){
                // chưa biết đường dẫn web ntn
            }
            if(action.equals("update_images")){
                
            }
            if(action.equals("update_profile")){
                
            }
        } catch (IOException | ServletException e) {
            System.out.println(e);
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
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
