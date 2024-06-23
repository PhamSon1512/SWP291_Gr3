
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String keyword = request.getParameter("keyword");
        
        // Ki?m tra xem keyword có null ho?c r?ng không
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui l?ng nh?p t? khóa t?m ki?m.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Th?c hi?n t?m ki?m
        ClubDBContext clubDBContext = new ClubDBContext();
        List<Club> listClubs = clubDBContext.search(keyword.trim());
        
        // L?y danh sách categories
        ClubDAO clubDAO = new ClubDAO();
        List<Category> listCategories = clubDAO.getAllCategories();
        
        // Ð?t các thu?c tính
        request.setAttribute("listCategories", listCategories);
        request.setAttribute("listClubs", listClubs);
        request.setAttribute("keyword", keyword);
        
        // Thêm thông báo k?t qu? t?m ki?m
        if (listClubs.isEmpty()) {
            request.setAttribute("searchMessage", "Không t?m th?y k?t qu? nào cho '" + keyword + "'.");
        } else {
            request.setAttribute("searchMessage", "T?m th?y " + listClubs.size() + " k?t qu? cho '" + keyword + "'.");
        }
        
        // Chuy?n hý?ng ð?n trang k?t qu? t?m ki?m
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
        return "Search Controller for Club search";
    }
}


