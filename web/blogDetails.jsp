<%@ page import="java.util.List" %>
<%@ page import="model.Blog" %>
<%@ page import="dal.BlogDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <jsp:include page="layout/head.jsp"/>
        <jsp:include page="layout/menu.jsp"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <title>Blog Detail</title>
        <style>
            body {
                background: linear-gradient(135deg, #2c3e50 0%, #FF66CC 100%);
                font-family: 'Poppins', sans-serif;
                color: #333;
            }
            .row {
                margin-top: 80px;
            };

            .blog-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: #fff;
                text-align: center;
                margin-bottom: 20px;
            }
            .blog-thumbnail {
                display: block;
                max-width: 100%;
                height: auto;
                margin: 20px auto;
                border-radius: 10px;
            }
            .blog-content {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            }
            .back-to-blog {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 999;
            }
            .card {
                background-color: #fff;
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .card img {
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                height: 200px;
                object-fit: cover;
            }
            .card-body {
                padding: 20px;
            }
            .card-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 10px;
            }
            .card-text {
                color: #666;
                line-height: 1.6;
            }
            .btn-read-more {
                background-color: #FF66CC;
                color: #fff;
                border: none;
            }
            .btn-read-more:hover {
                background-color: #E64980;
            }
            .comments {
                margin-top: 40px;
            }
            .comment-box {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 20px;
            }
            .comment-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
                border-bottom: 1px solid #ddd;
                padding-bottom: 10px;
            }
            .comment-author {
                font-weight: 600;
                color: #333;
            }
            .comment-date {
                color: #666;
            }
            .comment-content {
                margin-top: 10px;
                color: #333;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                font-weight: 600;
                margin-bottom: 10px;
            }
            .form-group textarea {
                resize: none;
                height: 120px;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
                font-size: 1rem;
                color: #333;
            }
            .btn-post-comment {
                background-color: #FF66CC;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 1rem;
            }
            .btn-post-comment:hover {
                background-color: #E64980;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <% 
                int blogId = Integer.parseInt(request.getParameter("id"));
                BlogDAO blogDAO = new BlogDAO();
                Blog blog = blogDAO.getBlogById(blogId);
            
                // Kiểm tra nếu blog không null trước khi truy cập các thuộc tính của nó
                if (blog != null) { 
            %>
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <a href="blog.jsp" class="btn btn-secondary mb-3">&larr; Back to Blog</a>
                    <h1 class="blog-title"><%= blog.getTitle() %></h1>
                    <p><img src="<%= blog.getThumbnailUrl() %>" class="blog-thumbnail img-fluid" alt="Blog Thumbnail"></p>
                    <div class="blog-content">
                        <p><%= blog.getContent() %></p>
                    </div>
                </div>
            </div>

            <!-- Hiển thị danh sách các blog liên quan -->
            <div class="row justify-content-center mt-5">
                <div class="col-md-10">
                    <h3>Other Blogs</h3>
                    <div class="row">
                        <% List<Blog> allBlogs = blogDAO.getAllBlogs();
                           int count = 0;
                           for (Blog otherBlog : allBlogs) {
                               if (count < 3 && otherBlog.getBlogId() != blog.getBlogId()) { // Giới hạn chỉ hiển thị 3 blog và loại bỏ blog hiện tại
                        %>
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <img src="<%= otherBlog.getThumbnailUrl() %>" class="card-img-top" alt="Blog Thumbnail">
                                <div class="card-body">
                                    <h5 class="card-title"><%= otherBlog.getTitle() %></h5>
                                    <p class="card-text"><%= otherBlog.getContent().substring(0, 100) %>...</p>
                                    <a href="blogDetails.jsp?id=<%= otherBlog.getBlogId() %>" class="btn btn-primary btn-read-more">Read More</a>
                                </div>
                            </div>
                        </div>
                        <% 
                           count++;
                           } 
                           } %>
                    </div>
                </div>
            </div>



            <!-- Phần bình luận -->
            <div class="row justify-content-center comments">
                <div class="col-md-10">
                    <h3>Comments</h3>
                    <%-- TODO: Lấy và hiển thị danh sách các comment từ database --%>
                    <%-- TODO: Hiển thị form để người dùng nhập comment --%>
                    <div class="comment-box">
                        <div class="comment-header">
                            <span class="comment-author">John Doe</span>
                            <span class="comment-date">May 15, 2024</span>
                        </div>
                        <div class="comment-content">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla convallis libero in dui tristique, ac scelerisque odio suscipit.
                        </div>
                    </div>
                    <div class="comment-box">
                        <div class="comment-header">
                            <span class="comment-author">Jane Smith</span>
                            <span class="comment-date">May 16, 2024</span>
                        </div>
                        <div class="comment-content">
                            Mauris eget elit posuere, dictum magna eu, consectetur sapien. Vivamus varius eros in justo dictum, vitae molestie quam fringilla.
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="comment">Leave a comment</label>
                        <textarea class="form-control" id="comment" name="comment" placeholder="Write your comment here..." required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-post-comment">Post Comment</button>
                </div>
            </div>

            <% } else { %>
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <h1 class="blog-title">Blog Not Found</h1>
                </div>
            </div>
            <% } %>
        </div>

        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top">
            <i class="fas fa-arrow-up"></i>
        </a>

        <jsp:include page="layout/footer.jsp"/>
        <jsp:include page="layout/search.jsp"/>
        <jsp:include page="layout/facebookchat.jsp"/>

        <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content video-modal rounded overflow-hidden">
                    <div class="ratio ratio-16x9">
                        <iframe src="https://www.youtube.com/embed/QIvIN8M91x4" title="YouTube video" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script>
            // Show back to top button when scrolling down
            window.onscroll = function () {
                let backToTopButton = document.getElementById("back-to-top");
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    backToTopButton.style.display = "block";
                } else {
                    backToTopButton.style.display = "none";
                }
            };

            // Scroll to top function
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }
        </script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <script src="assets/js/counter.init.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>