package controller.home;

import Email.JavaMail;
import config.Encode;
import config.Validate;
import dal.AccountDAO;
import dal.ClubDBContext;
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
import java.util.Random;
import java.util.UUID;
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

    Validate validate = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        AccountDAO dal = new AccountDAO();
        ClubDBContext dao = new ClubDBContext();

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
                    if (!user.isVerified()) {
                        request.setAttribute("loginError", "Your account is not verified. <a style='color: red; font-weight: bold' href='user?action=checkmail'>Click here</a> to verify.");
                        request.getRequestDispatcher("user?action=login").forward(request, response);
                        return;
                    }
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
                            session.setAttribute("userEmail", email);
                            session.setAttribute("userId", user.getUser_id());
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
                                    int loggedInClubId = dao.getClubIdByEmail(email);
                                    session.setAttribute("loggedInClubId", loggedInClubId);
                                    response.sendRedirect("dashboard?action=home");
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
                String user_name = request.getParameter("fullname");
                int setting = 1; // Active user by default
                int status = 0; // Regular user by default
                boolean verified = false;

                request.setAttribute("fullname", name);
                request.setAttribute("email", email);

                // Validate input fields
                boolean hasErrors = false;
                if (!Validate.checkFullName(name)) {
                    request.setAttribute("fullnameError", "Invalid full name. Please enter a valid name.");
                    hasErrors = true;
                }
                if (!Validate.checkEmail(email)) {
                    request.setAttribute("emailError", "Invalid email format. Please enter a valid email.");
                    hasErrors = true;
                }
                if (!Validate.checkPassword(password)) {
                    request.setAttribute("passwordError", "Invalid password. Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit.");
                    hasErrors = true;
                }
                if (!password.equals(repassword)) {
                    request.setAttribute("confirmPasswordError", "Passwords do not match.");
                    hasErrors = true;
                }

                if (hasErrors) {
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                } else {
                    Account account = dal.getAccountsByEmail(email);
                    if (account != null) { // Account with this email already exists
                        request.setAttribute("emailError", "Email already exists!");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    } else { // No account with this email
                        // Check for existing user_name
                        Account existingUser = dal.getAccountsByUserName(user_name);
                        if (existingUser != null) {
                            // Append two random digits to user_name
                            user_name += String.valueOf((int) (Math.random() * 999 + 10));
                        }

                        // Encrypt password before storing in the database
                        String encryptedPassword = Encode.enCode(password);
                        dal.insertAccount(name, user_name, email, encryptedPassword, setting, status, verified);

                        // Generate OTP
                        String otp = generateOTP();

                        // Send OTP to user's email
                        String subject = "Email Verification";
                        String content = "<h1>Welcome to our platform!</h1>"
                                + "<p>Your OTP for email verification is: <strong>" + otp + "</strong></p>"
                                + "<p>Please enter this code on the verification page to complete your registration.</p>";

                        boolean emailSent = JavaMail.sendEmail(email, subject, content);

                        if (emailSent) {
                            // Save OTP in session (or database)
                            request.getSession().setAttribute("otp", otp);
                            request.getSession().setAttribute("email", email);

                            // Redirect to OTP verification page
                            response.sendRedirect("verifyOtp.jsp");
                        } else {
                            // Handle email sending failure
                            request.setAttribute("emailError", "Failed to send verification email. Please try again.");
                            request.getRequestDispatcher("register.jsp").forward(request, response);
                        }
                    }
                }
            }

            // verifyOtp
            if (action.equals("verifyOtp")) {
                String otp = request.getParameter("otp");
                String sessionOtp = (String) request.getSession().getAttribute("otp");
                String email = (String) request.getSession().getAttribute("email");

                if (otp != null && otp.equals(sessionOtp)) {
                    // OTP is correct, mark email as verified
                    dal.updateEmailVerifiedStatus(email);
                    request.getSession().removeAttribute("otp");
                    request.getSession().removeAttribute("email");
                    response.sendRedirect("login.jsp");
                } else {
                    // OTP is incorrect, show error message
                    request.setAttribute("otpError", "Invalid OTP. Please try again.");
                    request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
                }
            }
            // resend OTP
            if (action.equals("resendOtp")) {
                String email = (String) session.getAttribute("email");
                if (email != null) {
                    // Generate new OTP
                    String otp = generateOTP();

                    // Send OTP to user's email
                    String subject = "Resend OTP Verification";
                    String content = "<h1>Here is your new OTP!</h1>"
                            + "<p>Your OTP for email verification is: <strong>" + otp + "</strong></p>"
                            + "<p>Please enter this code on the verification page to complete your registration.</p>";

                    boolean emailSent = JavaMail.sendEmail(email, subject, content);

                    if (emailSent) {
                        // Save new OTP in session
                        session.setAttribute("otp", otp);
                        response.sendRedirect("verifyOtp.jsp");
                    } else {
                        request.setAttribute("otpError", "Failed to resend verification email. Please try again.");
                        request.getRequestDispatcher("verifyOtp.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("home");
                }
            }
            // recover
            if (action.equals("recover")) {
                request.getRequestDispatcher("checkMail.jsp").forward(request, response);
            }
            // check email
            if (action.equals("checkmail")) {
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String email = request.getParameter("email");
                    request.setAttribute("email", email);

                    Account account = dal.getAccountsByEmail(email);
                    if (account != null) {
                        String otp = generateOTP();

                        String subject = "Email Verification";
                        String content = "<h1>Welcome to our platform!</h1>"
                                + "<p>Your OTP for email verification is: <strong>" + otp + "</strong></p>"
                                + "<p>Please enter this code on the verification page to complete your registration.</p>";
                        boolean emailSent = JavaMail.sendEmail(email, subject, content);

                        if (emailSent) {
                            request.getSession().setAttribute("otp", otp);
                            request.getSession().setAttribute("email", email);
                            response.sendRedirect("verifyOtp.jsp");
                            return;
                        } else {
                            request.setAttribute("emailError", "Failed to send verification email. Please try again.");
                        }
                    } else {
                        request.setAttribute("emailError", "Email not found. Please check your email or register.");
                    }
                }
                request.getRequestDispatcher("checkMailVerified.jsp").forward(request, response);
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
                    String contentType = filePart.getContentType();

                    // Check if the uploaded file is an image
                    if (contentType.startsWith("image/")) {
                        String uploadDirPath = getServletContext().getRealPath("/assets/uploads");
                        File uploadDir = new File(uploadDirPath);

                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        // Generate unique file name to avoid conflicts
                        String uniqueFileName = generateUniqueFileName(uploadDirPath, fileName);

                        String filePath = uploadDirPath + File.separator + uniqueFileName;
                        Path path = Paths.get(filePath);

                        try {
                            // Delete old file if exists
                            if (account.getAvatar_url() != null && !account.getAvatar_url().isEmpty()) {
                                String oldFileName = account.getAvatar_url().substring(account.getAvatar_url().lastIndexOf('/') + 1);
                                Path oldFilePath = Paths.get(uploadDirPath + File.separator + oldFileName);
                                Files.deleteIfExists(oldFilePath);
                            }

                            // Save new file
                            Files.deleteIfExists(path); // Delete new file if it already exists (for safety)
                            Files.copy(filePart.getInputStream(), path);

                            // Update avatar URL in database
                            String avatarUrl = "assets/uploads/" + uniqueFileName;
                            dal.updateAvatar(userId, avatarUrl);

                            // Update session attribute
                            account.setAvatar_url(avatarUrl);
                            request.getSession().setAttribute("account", account);

                            // Redirect with success message
                            response.sendRedirect("profile.jsp?success=true");
                        } catch (IOException | SQLException ex) {
                            // Handle exceptions
                            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                            response.sendRedirect("profile.jsp?success=false&error=sql");
                        }
                    } else {
                        // Handle case where the uploaded file is not an image
                        response.sendRedirect("profile.jsp?success=false&error=Invalid file type");
                    }
                } else {
                    // Handle case where no image is uploaded
                    response.sendRedirect("profile.jsp?success=false&error=No image");
                }
            }

            // update profile
            if (action.equals("update_profile")) {
                String fullname = request.getParameter("fullname");
                String phone = request.getParameter("phone");
                String username = request.getParameter("username");

                boolean hasErrors = false;
                if (!Validate.checkFullName(fullname)) {
                    request.setAttribute("fullnameError", "Invalid full name. Please enter a valid name.");
                    hasErrors = true;
                }
                if (!Validate.checkPhone(phone)) {
                    request.setAttribute("phoneNumberError", "Invalid phone number. Please enter a valid 10-digit phone number.");
                    hasErrors = true;
                }
                if (!Validate.checkUsername(username)) {
                    request.setAttribute("usernameError", "Invalid user name. Please enter a valid user name.");
                    hasErrors = true;
                }

                request.setAttribute("fullname", fullname);
                request.setAttribute("username", username);
                request.setAttribute("phone", phone);

                if (hasErrors) {
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                    return;
                }
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

                request.setAttribute("oldPassword", oldPassword);
                request.setAttribute("newPassword", newPassword);
                request.setAttribute("confirmPass", confirmPassword);

                boolean hasErrors = false;

                // Validate new password
                if (!Validate.checkPassword(newPassword)) {
                    request.setAttribute("passwordError", "Invalid password. Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, and a digit.");
                    hasErrors = true;
                }

                Account account = (Account) session.getAttribute("account");

                if (account != null) {
                    String decodedPassword = Encode.deCode(account.getPassword());

                    // Check if old password is correct
                    if (!decodedPassword.equals(oldPassword)) {
                        request.setAttribute("passerror", "Old password is incorrect!");
                        hasErrors = true;
                    }

                    // Check if new password matches confirm password
                    if (!newPassword.equals(confirmPassword)) {
                        request.setAttribute("passerror", "New password does not match!");
                        hasErrors = true;
                    }

                    // If no errors, update the password
                    if (!hasErrors) {
                        String encodedNewPassword = Encode.enCode(newPassword);
                        dal.updatePasswordByEmail(account.getEmail(), encodedNewPassword);

                        account.setPassword(encodedNewPassword);
                        session.setAttribute("account", account);

                        request.setAttribute("passsuccess", "You have successfully changed your password!");
                        session.invalidate();
                        response.sendRedirect("login.jsp?message=Password changed successfully, please login again.");
                        return;
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

    private String generateUniqueFileName(String uploadDirPath, String fileName) {
        String baseName = fileName.substring(0, fileName.lastIndexOf('.'));
        String extension = fileName.substring(fileName.lastIndexOf('.'));
        String uniqueFileName = baseName + "_" + UUID.randomUUID().toString() + extension;
        File file = new File(uploadDirPath + File.separator + uniqueFileName);

        // Check if the file already exists with the same name
        while (file.exists()) {
            uniqueFileName = baseName + "_" + UUID.randomUUID().toString() + extension;
            file = new File(uploadDirPath + File.separator + uniqueFileName);
        }

        return uniqueFileName;
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

}
