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
        
        // Kiểm tra xem keyword có null hoặc rỗng không
        if (keyword == null || keyword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập từ khóa tìm kiếm.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        // Thực hiện tìm kiếm
        ClubDBContext clubDBContext = new ClubDBContext();
        List<Club> listClubs = clubDBContext.search(keyword.trim());
        
        // Lấy danh sách categories
        ClubDAO clubDAO = new ClubDAO();
        List<Category> listCategories = clubDAO.getAllCategories();
        
        // Đặt các thuộc tính
        request.setAttribute("listCategories", listCategories);
        request.setAttribute("listClubs", listClubs);
        request.setAttribute("keyword", keyword);
        
        // Thêm thông báo kết quả tìm kiếm
        if (listClubs.isEmpty()) {
            request.setAttribute("searchMessage", "Không tìm thấy kết quả nào cho '" + keyword + "'.");
        } else {
            request.setAttribute("searchMessage", "Tìm thấy " + listClubs.size() + " kết quả cho '" + keyword + "'.");
        }
        
        // Chuyển hướng đến trang kết quả tìm kiếm
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