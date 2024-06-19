package controller.home;

import config.Encode;
import config.Validate;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Setting;

/**
 *
 * @author sodok
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100) // 100MB
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
            }
            // checklogin
            if (action.equals("checklogin")) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String remember = request.getParameter("remember");

                Account user = dal.getAccountByUP(email, password);

                if (user == null) {
                    if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
                    } else {
                        request.setAttribute("loginError", "Email or password is incorrect!");
                        request.setAttribute("email", email);
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
                                    response.sendRedirect("dashboard?action=home");
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
            if (action.equals("recoverpass")) {
                // chưa biết đường dẫn web ntn
            }
            // profile
            if (action.equals("profile")) {
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
            // update image
            if (action.equals("update_image")) {
                Account account = (Account) request.getSession().getAttribute("account");
                int userId = account.getUser_id();
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDirPath = getServletContext().getRealPath("/assets/uploads");
                    File uploadDir = new File(uploadDirPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadDirPath + File.separator + fileName;
                    Path path = Paths.get(filePath);
                    Files.deleteIfExists(path); // Delete old file if it exists
                    filePart.write(filePath); // Save new file
                    String avatarUrl = "assets/uploads/" + fileName;
                    try {
                        dal.updateAvatar(userId, avatarUrl);
                        account.setAvatar_url(avatarUrl);
                        request.getSession().setAttribute("account", account);
                        response.sendRedirect("profile.jsp?success=true");
                    } catch (SQLException ex) {
                        Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                        response.sendRedirect("profile.jsp?success=false&error=sql");
                    }
                } else {
                    response.sendRedirect("profile.jsp?success=false&error=No image");
                }
            }
            // update profile
            if (action.equals("update_profile")) {
                String fullname = request.getParameter("fullname");
                String phone = request.getParameter("phone");
                String username = request.getParameter("username");

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

                request.getRequestDispatcher("user?action=profile").forward(request, response);
            }
            // change pasword
            if (action.equals("changepassword")) {
                String oldPassword = request.getParameter("oldpassword");
                String newPassword = request.getParameter("newpassword");
                String confirmPassword = request.getParameter("renewpassword");

                Account account = (Account) session.getAttribute("account");

                if (account != null) {
                    String decodedPassword = Encode.deCode(account.getPassword());
                    if (decodedPassword.equals(oldPassword)) {
                        if (newPassword.equals(confirmPassword)) {
                            String encodedNewPassword = Encode.enCode(newPassword);
                            dal.updatePasswordByEmail(account.getEmail(), encodedNewPassword);

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

                request.getRequestDispatcher("user?action=profile").forward(request, response);
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
