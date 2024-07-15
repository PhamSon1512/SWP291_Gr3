package controller.manager;

import dal.ClubDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Club;

public class ClubManager extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Retrieve club_id parameter from request
        String club_id = request.getParameter("club_id");
        
        try {
            int clubId = Integer.parseInt(club_id);
            
            // Retrieve club information
            Club club = new ClubDBContext().getClubById(clubId);
            request.setAttribute("club", club);
            
            // Get total members for this club
            int totalMembers = new ClubDBContext().getTotalMemberByClubId(clubId);
            request.setAttribute("totalMembers", totalMembers);
            
            // Get department statistics
            int totalDepartments = new ClubDBContext().getTotalDistinctSpecialitiesByClubId(clubId);
            
            
            // Set department statistics in request attributes
            request.setAttribute("totalDepartments", totalDepartments);
         
            // Forward to JSP page
            request.getRequestDispatcher("layout/clubmanage.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            // Handle invalid club_id parameter
            response.getWriter().println("Invalid club ID.");
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
        return "Club Manager Servlet";
    }
}
