package controller.home;

import dal.ClubDAO;
import dal.ClubDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Club;

public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Retrieve parameters

      
        String keyword = request.getParameter("keyword");

        // Perform search
        List<Club> listClubs = new ClubDBContext().search(keyword);
        List<Category> listCategories = new ClubDAO().getAllCategories();

        // Set attributes for JSP
        request.setAttribute("listCategories", listCategories);
        request.setAttribute("listClubs", listClubs);
        request.setAttribute("key", keyword);

        // Forward to the appropriate JSP based on categoryId
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
        return "SearchController handles search requests for clubs by keyword";
    }
}
