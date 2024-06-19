<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="layout/head.jsp"/>

    <body>
        <jsp:include page="layout/preloader.jsp"/>

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
                                <h4 class="text-center">Login</h4> 
                                <c:set var="cookie" value="${pageContext.request.cookies}"/>

                                <form action="user?action=checklogin" method="POST" onSubmit="document.getElementById('submit').disabled = true;">
                                    <p style="color: red; align-content: center;">
                                        ${requestScope.loginError}
                                    </p>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input type="email" id="email" class="form-control" placeholder="Email" name="email" value="${email != null ? email : cookie.email.value}">
                                                <div id="emailError" class="text-danger" style="display: none;">Email must be filled out</div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" id="password" class="form-control" name="password" placeholder="Password" value="${cookie.pass.value}">
                                                <div id="passwordError" class="text-danger" style="display: none;">Password must be filled out</div>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-between">
                                                <div class="mb-3">
                                                    <div class="form-check">
                                                        <input class="form-check-input align-middle" type="checkbox" name="remember" id="remember-check">
                                                        <label class="form-check-label" for="remember-check">Lưu tài khoản</label>
                                                    </div>
                                                </div>
                                                <a href="user?action=forgotpass" class="text-dark h6 mb-0">Forgot Password ?</a>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary" id="submit" type="submit">Đăng nhập</button>
                                            </div>
                                        </div>

                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email 
                                                   profile openid &redirect_uri=http://localhost:8080/Iter2/registerclub&response_type=code &client_id=754575437351-ll510639upa1os3lpv867iad3n9a1anr.apps.googleusercontent.com&approval_prompt=force" class="btn btn-soft-primary"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div>
                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Does not have account?</small> <a href="user?action=register" class="text-dark fw-bold">Sign up</a></p>
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