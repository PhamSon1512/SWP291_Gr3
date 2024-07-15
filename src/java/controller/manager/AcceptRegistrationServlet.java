package controller.manager;

import dal.ClubRegistrationDAO;
import dal.ClubDBContext;
import model.ClubRegistration;
import Email.JavaMail;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AcceptRegistrationServlet extends HttpServlet {

    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int registrationId = Integer.parseInt(request.getParameter("registrationId"));
        ClubRegistrationDAO dao = new ClubRegistrationDAO();
        ClubRegistration registration = dao.getRegistrationById(registrationId);

        if (registration != null) {
            dao.updateRegistrationStatus(registrationId, "accepted");

            String subject = "Interview Notification";
            String message = "<html><body>"
                    + "<h2>Interview Invitation</h2>"
                    + "<p>Dear " + registration.getName() + ",</p>"
                    + "<p>We are pleased to inform you that your registration for the club has been accepted. "
                    + "Please wait for further instructions regarding the interview schedule.</p>"
                    + "</body></html>";

            boolean isSent = JavaMail.sendEmail(registration.getEmail(), subject, message);

          
        }

        request.getRequestDispatcher("admin/viewregistration.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int registrationId = Integer.parseInt(request.getParameter("registrationId"));
        ClubRegistrationDAO dao = new ClubRegistrationDAO();
        ClubRegistration registration = dao.getRegistrationById(registrationId);

        if (registration != null) {
            // Update registration status
            dao.updateRegistrationStatus(registrationId, "accepted");

            // Send email notification
            String subject = "Interview Notification";
            String message = "<html><body>"
                    + "<h2>Interview Invitation</h2>"
                    + "<p>Dear " + registration.getName() + ",</p>"
                    + "<p>We are pleased to inform you that your registration for the club has been accepted. "
                    + "Please wait for further instructions regarding the interview schedule.</p>"
                    + "</body></html>";

            boolean isSent = JavaMail.sendEmail(registration.getEmail(), subject, message);
            
            // Add member to club_member table
            dao.addMemberToClub(registration.getClubId(), registration.getEmail(), registration.getCommittees(), 1);

            if (isSent) {
                request.setAttribute("successMessage", "Registration accepted, member added to club, and notification email sent.");
            } else {
                request.setAttribute("errorMessage", "Registration accepted and member added to club, but failed to send notification email.");
            }
        } else {
            request.setAttribute("errorMessage", "Registration not found.");
        }

        request.getRequestDispatcher("admin/viewregistration.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Servlet to accept registration and send interview notification.";
    }
}
