<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <jsp:include page="../admin/layout/adminhead.jsp"/>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../admin/layout/menu.jsp"/>
            <main class="page-content bg-light">
                <jsp:include page="../admin/layout/headmenu.jsp"/>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <!-- New Post Form -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Đăng bài mới</h5>
                                        <form action="post?action=create" method="POST" enctype="multipart/form-data">
                                            <div class="mb-3">
                                                <input type="text" class="form-control" name="title" placeholder="Tiêu đề bài viết" required>
                                            </div>
                                            <div class="mb-3">
                                                <textarea class="form-control" name="content" rows="3" placeholder="Bạn đang nghĩ gì?" required></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <input type="file" class="form-control" name="image" accept="image/*">
                                            </div>
                                            <input type="hidden" name="author_id" value="${currentUserId}">
                                            <button type="submit" class="btn btn-primary">Đăng bài</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Existing Posts -->
                        <div class="row">
                            <div class="col-12">
                                <h5 class="mb-3">Bài viết gần đây</h5>
                            </div>
                            <c:forEach var="post" items="${posts}">
                                <div class="col-12 mb-4">
                                    <a href="post?action=view&id=${post.postId}" class="card text-decoration-none">
                                        <div class="row g-0">
                                            <div class="col-md-4">
                                                <c:if test="${not empty post.thumnailUrl}">
                                                    <img src="${post.thumnailUrl}" class="img-fluid rounded-start" alt="Post Image">
                                                </c:if>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <h5 class="card-title">${post.title}</h5>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${post.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </small>
                                                    <p class="card-text">${post.content}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>


                        </div>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </main>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
