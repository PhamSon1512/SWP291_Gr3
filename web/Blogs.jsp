<%-- 
    Document   : blog
    Created on : Jun 12, 2024, 10:35:22 PM
    Author     : FANCY
--%>

<%@ page import="model.Blog" %>
<%@ page import="dal.BlogDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<%
    int postsPerPage = 6; // Số bài viết trên mỗi trang
    int maxPagesDisplayed = 5; // Số trang tối đa được hiển thị
%>
<%
    BlogDAO blogDAO = new BlogDAO();
    List<Blog> allBlogs = blogDAO.getAllBlogs(); // Lấy danh sách tất cả các bài viết từ DAO

    int totalPosts = allBlogs.size(); // Tổng số bài viết

    // Xác định trang hiện tại từ tham số truyền lên
    int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;

    // Tính chỉ số bắt đầu và kết thúc của danh sách bài viết trên trang hiện tại
    int startIndex = (currentPage - 1) * postsPerPage;
    int endIndex = Math.min(startIndex + postsPerPage, totalPosts);

    // Lấy danh sách bài viết cho trang hiện tại
    List<Blog> displayedBlogs = allBlogs.subList(startIndex, endIndex);
%>
<!DOCTYPE html>
<jsp:include page="layout/head.jsp"/>
<jsp:include page="layout/menu.jsp"/>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <style>
            body {
                background: linear-gradient(135deg, #2c3e50 0%, #4ca1af 100%);
                font-family: 'Poppins', sans-serif;
                color: #333;
            }
            .navbar {
                position: fixed;
                width: 100%;
                z-index: 1000;
            }
            .container {
                margin-top: 0px;
            }
            .header-title {
                text-align: center;
                font-size: 3rem; /* Tăng kích cỡ font lên một chút */
                font-weight: 900; /* Tăng độ đậm của font */
                margin-bottom: 2rem;
                color: #fff;
                margin-top: 100px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4); /* Đổ bóng chữ */
            }
            .row{
                margin-top: 30px
            }

            .card {
                border: none;
                border-radius: 20px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }
            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }
            .card-img-top {
                height: 250px;
                object-fit: cover;
                border-top-left-radius: 20px;
                border-top-right-radius: 20px;
            }
            .card-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #495057;
            }
            .card-text {
                color: #6c757d;
                font-size: 1rem;
            }
            .btn-primary {
                background-color: #0069d9;
                border-color: #0062cc;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }
            #back-to-top {
                position: fixed;
                bottom: 30px;
                right: 30px;
                display: none;
                z-index: 100;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="header-title">Club Blog</div>


            <!-- Form tìm kiếm -->
            <div class="row mt-4">
                <div class="col-md-6 offset-md-3">
                    <form action="blog" method="GET" class="d-flex">
                        <input class="form-control me-2" type="search" name="keyword" placeholder="Search blogs..." aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </form>
                </div>
            </div>


            <% 
          String keyword = request.getParameter("keyword");
          List<Blog> searchResults = new ArrayList<>();

          if (keyword != null && !keyword.isEmpty()) {
              // Lọc danh sách bài viết theo từ khóa
              for (Blog blog : allBlogs) {
                  if (blog.getTitle().toLowerCase().contains(keyword.toLowerCase()) || 
                      blog.getContent().toLowerCase().contains(keyword.toLowerCase())) {
                      searchResults.add(blog);
                  }
              }
          } else {
              searchResults = allBlogs; // Nếu không có từ khóa, hiển thị tất cả bài viết
          }

          // Cập nhật danh sách bài viết hiển thị
          totalPosts = searchResults.size();
          currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
          startIndex = (currentPage - 1) * postsPerPage;
          endIndex = Math.min(startIndex + postsPerPage, totalPosts);
          displayedBlogs = searchResults.subList(startIndex, endIndex);
            %>

            <div class="row">
                <% for (Blog blog : displayedBlogs) { %>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <img class="card-img-top" src="<%= blog.getThumbnailUrl() %>" alt="Blog image">
                        <div class="card-body">
                            <h5 class="card-title"><%= blog.getTitle() %></h5>
                            <p class="card-text"><%= blog.getContent().length() > 100 ? blog.getContent().substring(0, 100) + "..." : blog.getContent() %></p>
                            <a href="blogDetails.jsp?id=<%= blog.getBlogId() %>" class="btn btn-primary">Read More</a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Phân trang -->
            <div class="pagination justify-content-center mt-4">
                <%-- Nút Previous --%>
                <% if (currentPage > 1) { %>
                <a class="btn btn-primary me-2" href="blog?page=<%= currentPage - 1 %>">Previous</a>
                <% } %>

                <%-- Các nút trang --%>
                <% 
                    int startPage = Math.max(1, currentPage - maxPagesDisplayed / 2);
                    int endPage = Math.min(startPage + maxPagesDisplayed - 1, (int) Math.ceil((double) totalPosts / postsPerPage));

                    for (int i = startPage; i <= endPage; i++) { 
                %>
                <a class="btn btn-primary me-2 <%= (i == currentPage) ? "active" : "" %>" href="blog?page=<%= i %>"><%= i %></a>
                <% } %>

                <%-- Nút Next --%>
                <% if (currentPage < (int) Math.ceil((double) totalPosts / postsPerPage)) { %>
                <a class="btn btn-primary" href="blog?page=<%= currentPage + 1 %>">Next</a>
                <% } %>
            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>

        <jsp:include page="layout/footer.jsp"/>

        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i class="fas fa-arrow-up"></i></a>

        <jsp:include page="layout/search.jsp"/>
        <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content video-modal rounded overflow-hidden">
                    <div class="ratio ratio-16x9">
                        <iframe src="https://www.youtube.com/embed/QIvIN8M91x4" title="YouTube video" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <script src="assets/js/counter.init.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>

        <script>
            $(document).ready(function () {
                $(window).scroll(function () {
                    if ($(this).scrollTop() > 100) {
                        $('#back-to-top').fadeIn();
                    } else {
                        $('#back-to-top').fadeOut();
                    }
                });
                $('#back-to-top').click(function () {
                    $('html, body').animate({scrollTop: 0}, 800);
                    return false;
                });
            });
        </script>
    </body>
</html>