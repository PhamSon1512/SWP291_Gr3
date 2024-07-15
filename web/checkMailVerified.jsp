<%-- 
    Document   : checkMailVerified
    Created on : Jul 3, 2024, 10:13:25 AM
    Author     : sodok
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>
    <body>
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>
        <!-- Hero Start -->
        <section class="bg-home d-flex bg-light align-items-center">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="text-center mb-4">
                            <img src="assets/images/bg/fpt.png" alt="FPT Logo" class="img-fluid" style="max-width: 200px;">
                        </div>
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Verify your email</h4>
                                <c:if test="${not empty emailError}">
                                    <p style="color: red; text-align: center;">
                                        ${emailError}
                                    </p>
                                </c:if>
                                <form action="user?action=checkmail" method="POST" class="login-form mt-4" onSubmit="document.getElementById('submit').disabled = true;">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <p class="text-muted">Enter your email, we will send a verification OTP code to your email.</p>
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input value="${email}" oninvalid="CheckEmail(this);" oninput="CheckEmail(this);" placeholder="Your email..." type="email" class="form-control" name="email" required="">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button id="submit" class="btn btn-primary">Verify</button>
                                            </div>
                                        </div>
                                        <div class="col-12 text-center">
<p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account verified?</small> <a href="user?action=login" class="text-dark fw-bold">Login</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
