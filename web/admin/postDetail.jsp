<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="../admin/layout/adminhead.jsp"/>
    <head>
        <style>
            .main-content-padding {
                padding-top: 80px; /* Điều chỉnh giá trị này tùy theo chiều cao của menu */
            }
            .post-title {
                word-wrap: break-word;
                overflow-wrap: break-word;
                hyphens: auto;
            }
            .your-menu-class {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1030;
            }
            .container-fluid {
                min-height: calc(100vh - 80px);
            }
        </style>
    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../admin/layout/menu.jsp"/>
            <main class="page-content bg-light main-content-padding">
                <jsp:include page="../admin/layout/headmenu.jsp"/>
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-lg-10 col-md-12">
                            <div class="card shadow-sm my-4">
                                <div class="card-body">
                                    <h1 class="card-title mb-3 post-title"><strong>${post.title}</strong></h1>
                                    <p class="text-muted">
                                        <i class="fas fa-calendar-alt me-2"></i>
                                        <em><fmt:formatDate value="${post.createdAt}" pattern="dd MMMM yyyy, HH:mm"/></em>
                                        <span class="ms-3"><i class="fas fa-user me-2"></i><strong>${post.userName}</strong></span>
                                    </p>

                                    <c:if test="${not empty post.thumnailUrl}">
                                        <div class="text-center my-4">
                                            <img src="${post.thumnailUrl}" class="img-fluid rounded" alt="Post Image" style="max-width: 100%; height: auto;">
                                        </div>
                                    </c:if>

                                    <div class="post-content mt-4" style="word-wrap: break-word; overflow-wrap: break-word;">
                                        ${post.content}
                                    </div>

                                    <hr class="my-4">

                                    <div class="comments-section">
                                        <h3 class="mb-3"><strong>Comments</strong></h3>
                                        <c:forEach var="comment" items="${comments}">
                                            <div class="comment mb-3 p-3 bg-light rounded">
                                                <p class="mb-1"><strong>${comment.userName}</strong></p>
                                                <p class="mb-2">${comment.content}</p>
                                                <small class="text-muted">
                                                    <em><fmt:formatDate value="${comment.createdAt}" pattern="dd MMM yyyy, HH:mm"/></em>
                                                </small>
                                            </div>
                                        </c:forEach>

                                        <form action="post?action=createComment" method="post" class="mt-4">
                                            <input type="hidden" name="postId" value="${post.postId}" />
                                            <div class="form-group">
                                                <label for="commentContent"><strong>Add a comment</strong></label>
                                                <textarea id="commentContent" name="content" class="form-control" rows="3" required></textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary mt-2"><strong>Submit Comment</strong></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </main>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
    </body>
</html>