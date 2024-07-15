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
                request.getRequestDispatcher("admin/viewregistration.jsp").forward(request, response);
                return;
            }
        }
        
        HttpSession session = request.getSession(false);
        if (!isAuthenticatedManager(session)) {
            response.sendRedirect("user?action=login");
            return;
        }
        
        Integer loggedInClubId = (Integer) session.getAttribute("loggedInClubId");
        if (loggedInClubId == null) {
            response.sendRedirect("error.jsp");
            return;
        }
        //phan trang
        List<ClubRegistration> registrations = dao.getPendingRegistrations(loggedInClubId);
        if (registrations != null && !registrations.isEmpty()) {
            int page = 1;
            int numPerPage = 8;
            int size = registrations.size();
            int num = (size % numPerPage == 0) ? (size / numPerPage) : ((size / numPerPage) + 1);
            String xPage = request.getParameter("page");
            if (xPage != null) {
                page = Integer.parseInt(xPage);
            }
            int start = (page - 1) * numPerPage;
            int end = Math.min(page * numPerPage, size);
            List<ClubRegistration> pagedViews = dao.getListByPage(registrations, start, end);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("registrations", pagedViews);
            request.getRequestDispatcher("admin/viewregistration.jsp").forward(request, response);
        } else {
            response.sendRedirect("no-registrations.jsp");
        }
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
