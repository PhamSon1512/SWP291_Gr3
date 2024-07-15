package controller.manager;

import Email.JavaMail;
import dal.ClubRegistrationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ClubRegistration;

public class RejectRegistrationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int registrationId = Integer.parseInt(request.getParameter("registrationId"));
        ClubRegistrationDAO dao = new ClubRegistrationDAO();
        ClubRegistration registration = dao.getRegistrationById(registrationId);

        if (registration != null) {
            dao.updateRegistrationStatus(registrationId, "rejected");

            String subject = "Registration Rejection Notification";
            String message = "<html><body>"
                    + "<h2>Registration Rejected</h2>"
                    + "<p>Dear " + registration.getName() + ",</p>"
                    + "<p>We regret to inform you that your registration for the club has been rejected. "
                    + "Thank you for your interest in our club.</p>"
                    + "</body></html>";

            boolean isSent = JavaMail.sendEmail(registration.getEmail(), subject, message);

            if (isSent) {
                request.setAttribute("successMessage", "Registration rejected and notification email sent.");
            } else {
                request.setAttribute("errorMessage", "Registration rejected but failed to send notification email.");
            }
        } else {
            request.setAttribute("errorMessage", "Registration not found.");
        }

        request.getRequestDispatcher("viewregistration.jsp").forward(request, response);
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
        return "Servlet to reject registration and send rejection notification.";
    }
}
