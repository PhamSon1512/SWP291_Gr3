package controller.admin;

import dal.AccountDAO;
import dal.CommentDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpSession;
import model.Post;
import dal.PostDAO;
import model.Account;
import model.Comment;

@WebServlet("/admin/post")
@MultipartConfig
public class PostController extends HttpServlet {

    private final PostDAO postDAO = new PostDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listPosts(request, response);
                break;
            case "create":
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    createPost(request, response);
                } else {
                    showCreateForm(request, response);
                }
                break;
            case "edit":
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    updatePost(request, response);
                } else {
                    showEditForm(request, response);
                }
                break;
            case "delete":
                deletePost(request, response);
                break;
            case "view":
                viewPost(request, response);
                break;
            case "createComment":
                createComment(request, response);
                break;
            default:
                listPosts(request, response);
        }

    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Post> posts = postDAO.getAllPosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("admin/post.jsp").forward(request, response);
    }

    private void createPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        Part filePart = request.getPart("image");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
   
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String contentType = filePart.getContentType();

            // Check if the uploaded file is an image
            if (contentType.startsWith("image/")) {
                String uploadDirPath = getServletContext().getRealPath("/assets/uploads");
                File uploadDir = new File(uploadDirPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Generate unique file name to avoid conflicts
                String uniqueFileName = generateUniqueFileName(uploadDirPath, fileName);

                String filePath = uploadDirPath + File.separator + uniqueFileName;
                Path path = Paths.get(filePath);

                try {
                    // Save new file
                    Files.copy(filePart.getInputStream(), path);

                    // Set post details
                    Post post = new Post();
                    post.setTitle(title);
                    post.setThumnailUrl("assets/uploads/" + uniqueFileName);
                    post.setContent(content);
                    post.setStatus(1);
                    post.setAuthorId(userId);
                    post.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                    post.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

                    // Insert post into database
                    postDAO.insertPost(title, "assets/uploads/" + uniqueFileName, content, userId);
                    response.sendRedirect("post?action=list");
                } catch (IOException ex) {
                    // Handle exceptions
                    Logger.getLogger(PostController.class.getName()).log(Level.SEVERE, null, ex);
                    response.sendRedirect("post?action=create&success=false&error=sql");
                }
            } else {
                // Handle case where the uploaded file is not an image
                response.sendRedirect("post?action=create&success=false&error=Invalid file type");
            }
        } else {
            // Handle case where no image is uploaded
            response.sendRedirect("post?action=create&success=false&error=No image");
        }
    }

    private String generateUniqueFileName(String uploadDirPath, String fileName) {
        String uniqueFileName = fileName;
        File file = new File(uploadDirPath + File.separator + uniqueFileName);
        while (file.exists()) {
            String baseName = fileName.substring(0, fileName.lastIndexOf('.'));
            String extension = fileName.substring(fileName.lastIndexOf('.'));
            uniqueFileName = baseName + "_" + System.currentTimeMillis() + extension;
            file = new File(uploadDirPath + File.separator + uniqueFileName);
        }
        return uniqueFileName;
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/post-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Post post = postDAO.getPostById(postId);
        request.setAttribute("post", post);
        request.getRequestDispatcher("admin/post-form.jsp").forward(request, response);
    }

    private void createComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String content = request.getParameter("content");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        CommentDAO commentDAO = new CommentDAO();
        commentDAO.insertComment(postId, userId, content);

        response.sendRedirect("post?action=view&id=" + postId);
    }

    private void viewPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        Post post = postDAO.getPostById(postId);

        // Retrieve comments for the post
        CommentDAO commentDAO = new CommentDAO();
        List<Comment> comments = commentDAO.getCommentsByPostId(postId);

        // Set attributes for JSP
        request.setAttribute("post", post);
        request.setAttribute("comments", comments);

        request.getRequestDispatcher("admin/postDetail.jsp").forward(request, response);
    }

    private void updatePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int status = Integer.parseInt(request.getParameter("status"));
        int authorId = Integer.parseInt(request.getParameter("author_id"));

        Post post = new Post();
        post.setPostId(postId);
        post.setTitle(title);
        post.setContent(content);
        post.setStatus(status);
        post.setAuthorId(authorId);
        post.setUpdatedAt(new Timestamp(System.currentTimeMillis()));

        postDAO.updatePost(post);
        response.sendRedirect("post?action=list");
    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));
        postDAO.deletePost(postId);
        response.sendRedirect("post?action=list");
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
        return "Post Controller Servlet";
    }
}
