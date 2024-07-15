package controller.admin;

import dal.ClubDAO;
import dal.ClubDBContext;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Club;

public class NewClubController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
    String category_id = request.getParameter("categoryId");
    int categoryId = category_id != null ? Integer.parseInt(category_id) : 0;
    
    // Fetch data from database
    List<Category> listCategories = new ClubDAO().getAllCategories();
    List<Club> listAllClubs = new ClubDBContext().getAllClubs();
    List<Club> listClubs = categoryId != 0 ? new ClubDBContext().getClubsByCategoryId(categoryId) : listAllClubs;
    
    // Set attributes in request scope
    request.setAttribute("listCategories", listCategories);
    request.setAttribute("listAllClubs", listAllClubs);
    request.setAttribute("listClubs", listClubs);

    // Forward to JSP page
    request.getRequestDispatcher("admin/clubmanage.jsp").forward(request, response);
}

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String category_id = request.getParameter("category_id");
        String phoneNumber = request.getParameter("phoneNumber");
        String facebook = request.getParameter("facebook");

        if (code == null || name == null || description == null || imageUrl == null || category_id == null || phoneNumber == null || facebook == null) {
            request.setAttribute("error", "All fields are required.");
            doGet(request, response);
            return;
        }

        int categoryId = Integer.parseInt(category_id);
        ClubDBContext newClub = new ClubDBContext();
        newClub.insertClub(code, name, description, imageUrl, categoryId, phoneNumber, facebook);

        // Refresh the data and display the updated list
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "NewClubController handles club management";
    }
}
