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

public class CategoryClubController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get categoryId from request parameter
        String categoryIdParam = request.getParameter("categoryId");

        if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdParam);

                List<Category> listCategories = new ClubDAO().getAllCategories();
                request.setAttribute("listCategories", listCategories);

                List<Club> listClubs = new ClubDBContext().getClubsByCategoryId(categoryId);

                int page = 1;
                int recordsPerPage = 3;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                int start = (page - 1) * recordsPerPage;

                int end = Math.min(start + recordsPerPage, listClubs.size());

                List<Club> sublistClubs = listClubs.subList(start, end);

                // Set attributes for JSP
                request.setAttribute("listClubs", sublistClubs);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", Math.ceil((double) listClubs.size() / recordsPerPage));
                request.setAttribute("tag", categoryId);

                // Forward to index.jsp for rendering
                request.getRequestDispatcher("index.jsp").forward(request, response);

            } catch (NumberFormatException e) {

                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid categoryId parameter");
            }
        } else {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing categoryId parameter");
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
