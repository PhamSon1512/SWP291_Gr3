package controller.manager;

import dal.ClubRegistrationDAO;
import model.ClubRegistration;
import model.Account;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ViewRegistrationsServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        ClubRegistrationDAO dao = new ClubRegistrationDAO();
        String token = request.getParameter("token");
        
        if (token != null) {
            int clubId = dao.getClubIdFromToken(token);
            
            if (clubId != -1 && dao.isValidToken(token, clubId)) {
                List<ClubRegistration> registrations = dao.getPendingRegistrations(clubId);
                request.setAttribute("registrations", registrations);
                request.getRequestDispatcher("viewregistration.jsp").forward(request, response);
                return;
            }
        }
        
        // Nếu không có token hợp lệ, tiếp tục với xác thực session
        HttpSession session = request.getSession(false);
        if (!isAuthenticatedManager(session)) {
            response.sendRedirect("user?action=login");
            return;
        }
        
        // Lấy club_id từ session
        Integer loggedInClubId = (Integer) session.getAttribute("loggedInClubId");
        if (loggedInClubId == null) {
            response.sendRedirect("error.jsp");
            return;
        }
        
        List<ClubRegistration> registrations = dao.getPendingRegistrations(loggedInClubId);
        request.setAttribute("registrations", registrations);
        request.getRequestDispatcher("viewregistration.jsp").forward(request, response);
    }
    
    private boolean isAuthenticatedManager(HttpSession session) {
        if (session == null) {
            return false;
        }
        Account account = (Account) session.getAttribute("account");
        return account != null && account.getStatus() == 2; // 2 là status cho manager
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