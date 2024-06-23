package controller.home;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/list-images")
public class ListImages extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDirFile = new File(uploadDir);

        if (uploadDirFile.exists() && uploadDirFile.isDirectory()) {
            File[] files = uploadDirFile.listFiles((dir, name) -> name.matches(".*\\.(jpg|jpeg|png|gif)"));

            response.setContentType("text/html");
            response.getWriter().println("<html><body>");
            response.getWriter().println("<h1>Uploaded Images</h1>");

            if (files != null) {
                for (File file : files) {
                    String fileName = file.getName();
                    response.getWriter().println("<div>");
                    response.getWriter().println("<img src='uploads/" + fileName + "' width='200'><br>");
                    response.getWriter().println(fileName);
                    response.getWriter().println("</div>");
                }
            } else {
                response.getWriter().println("No images found.");
            }

            response.getWriter().println("</body></html>");
        } else {
            response.getWriter().println("Upload directory not found.");
        }
    }
}
