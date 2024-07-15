<%@ page import="model.Account, dal.AccountDAO" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp" />
    <body>
       
        <jsp:include page="layout/menu.jsp" />

        <section class="section">
            <div class="container">
                <h2 class="mb-0">Register Club</h2>
                <div class="row">
                    <%
                        Account account = (Account) session.getAttribute("account");
                        if (account == null) {
                            response.sendRedirect("login.jsp");
                        }
                    %>
                    <div class="col-lg-5">
                        <img src="${clubId.imageUrl}" class="img-fluid" alt="Club Image">
                    </div>
                    <div class="col-lg-7">
                        <div class="card border-0 shadow rounded overflow-hidden">
                            <div class="tab-content p-4" id="pills-tabContent">
                                <form action="userRegisterClub?club_id=${param.club_id}" method="POST">
                                    <div class="row">
                                        <div class="p-6">
                                            <h4 class="mb-0">Profile</h4>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Name<span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" name="name" value="<%= account != null ? account.getFullname() : "" %>">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email<span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" name="email" value="<%= account != null ? account.getEmail() : "" %>">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Purpose of participation<span class="text-danger">*</span></label>
                                                <input type="text" name="purpose" class="form-control" id="purpose-input" placeholder="Enter your purpose" required>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Committees<span class="text-danger">*</span></label>
                                                <select required name="commit" class="form-control" id="commit-select">
                                                    <option value="Ban Chuyen Mon">Ban Chuyen Mon</option>
                                                    <option value="Ban Van Hoa">Ban Van Hoa</option>
                                                    <option value="Ban Truyen Thong">Ban Truyen Thong</option>
                                                    <option value="Ban Hau Can">Ban Hau Can</option>
                                                    <option value="Ban Noi Dung">Ban Noi Dung</option>
                                                    <option value="Ban Media">Ban Media</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Introduce Yourself<span class="text-danger">*</span></label>
                                                <textarea required name="description" id="comments2" rows="4" class="form-control"></textarea>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <button type="submit" class="btn btn-primary">Register</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="layout/footer.jsp" />
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        

        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/flatpickr.min.js"></script>
        <script src="assets/js/flatpickr.init.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/select2.init.js"></script>
        <script src="assets/js/jquery.timepicker.min.js"></script>
        <script src="assets/js/timepicker.init.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/vn.js"></script>
        <script src="assets/js/app.js"></script>
        <script src="assets/js/sweetalert.min.js"></script>

        <c:if test="${not empty successMessage}">
            <script>
            $(document).ready(function () {
                swal("Success", "${successMessage}", "success");
            });
            </script>
        </c:if>
            <c:if test="${not empty errorMessage}">
    <script>
        $(document).ready(function () {
            swal("Error", "${errorMessage}", "error");
        });
    </script>
</c:if>
            <c:if test="${not empty errorMessages}">
    <script>
        $(document).ready(function () {
            swal("Error", "${errorMessages}", "error");
        });
    </script>
</c:if>
    </body>
</html>
