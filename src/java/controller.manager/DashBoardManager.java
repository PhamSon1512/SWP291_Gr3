package controller.manager;


import dal.ClubDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.ClubMember;

/**
 *
 * @author Admin
 */
public class DashBoardManager extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get the logged-in user's email from the session
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        
        ClubDBContext pdb = new ClubDBContext();
        List<ClubMember> listClubs = pdb.getAllClubMember();
        
        Integer userClubId = null;
        for (ClubMember clubmember : listClubs) {
            if (clubmember.getEmail().equalsIgnoreCase(userEmail)) {
                userClubId = clubmember.getClub_id();
                break;  // Stop looping once we find the user's club
            }
        }

        request.setAttribute("userClubId", userClubId);

        // Forward to JSP page
        request.getRequestDispatcher("managerHomePage.jsp").forward(request, response);
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
