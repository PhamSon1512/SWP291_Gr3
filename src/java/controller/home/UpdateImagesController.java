package controller.home;

import dal.AccountDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import model.Account;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 100) // 100MB
public class UpdateImagesController extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/uploads"; // Updated upload directory

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateImagesController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateImagesController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        Account account = (Account) request.getSession().getAttribute("account");
        int userId = account.getUser_id();
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadDirPath = getServletContext().getRealPath("/assets/uploads");
            File uploadDir = new File(uploadDirPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String filePath = uploadDirPath + File.separator + fileName;
            Path path = Paths.get(filePath);
            Files.deleteIfExists(path); // Xóa tệp cũ nếu nó tồn tại
            filePart.write(filePath); // Lưu tệp mới
            String avatarUrl = "assets/uploads/" + fileName;
            AccountDAO accountDAO = new AccountDAO();
            try {
                accountDAO.updateAvatar(userId, avatarUrl);
                account.setAvatar_url(avatarUrl);
                request.getSession().setAttribute("account", account);
                response.sendRedirect("profile.jsp?success=true");
            } catch (SQLException ex) {
                Logger.getLogger(UpdateImagesController.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("profile.jsp?success=false&error=sql");
            }
        } else {
            response.sendRedirect("profile.jsp?success=false&error=noimage");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
