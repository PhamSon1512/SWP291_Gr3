package controller.manager;

import dal.ClubDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ToggleMemberStatusController", urlPatterns = {"/toggleMemberStatus"})
public class ToggleMemberStatusController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        
        int memberId = Integer.parseInt(request.getParameter("memberId"));
        boolean newStatus = Boolean.parseBoolean(request.getParameter("activeStatus"));
        
        ClubDBContext dbContext = new ClubDBContext();
        boolean updated = dbContext.updateMemberActiveStatus(memberId, newStatus);
        
        if (updated) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}