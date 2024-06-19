<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>

    <body>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-half-150 d-table w-100 bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="text-center mb-4">
                            <img src="assets/images/bg/fpt.png" alt="FPT Logo" class="img-fluid" style="max-width: 200px;">
                        </div>
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign Up</h4>

                                <!-- Display success message if exists -->
                                <%
                                    String successMessage = (String) request.getAttribute("success");
                                    if (successMessage != null) {
                                %>
                                <div class="alert alert-success alert-fixed" role="alert" id="successMessage">
                                    <%= successMessage %>
                                </div>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var successMessage = document.getElementById('successMessage');
                                        successMessage.classList.add('alert-show');
                                        setTimeout(function () {
                                            successMessage.classList.remove('alert-show');
                                            window.location.href = 'login.jsp';
                                        }, 2000); // 2 seconds delay
                                    });
                                </script>
                                <%
                                    }
                                %>

                                <form action="user?action=checkregister" class="login-form mt-4" method="post">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Full Name" name="fullname" id="fullName" value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : "" %>">
                                                <div id="fullnameError" class="text-danger">
                                                    <%= request.getAttribute("fullnameError") != null ? request.getAttribute("fullnameError") : "" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" name="email" id="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                                                <div id="emailError" class="text-danger">
                                                    <%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Phone Number" name="phoneNumber" id="phoneNumber" value="<%= request.getAttribute("phoneNumber") != null ? request.getAttribute("phoneNumber") : "" %>">
                                                <div id="phoneNumberError" class="text-danger">
                                                    <%= request.getAttribute("phoneNumberError") != null ? request.getAttribute("phoneNumberError") : "" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" 
                                                       oninput="CheckPassword(this);" 
                                                       class="form-control" 
                                                       name="password" 
                                                       id="password"
                                                       placeholder="Password" 
                                                       pattern="(?=.*[A-Z]).{8,}">
                                                <div id="passwordError" class="text-danger">
                                                    <%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" id="confirmPassword">
                                                <div id="confirmPasswordError" class="text-danger">
                                                    <%= request.getAttribute("confirmPasswordError") != null ? request.getAttribute("confirmPasswordError") : "" %>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Register</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div>
                                        <div class="col-12 mt-8">
                                            <div class="d-grid">    
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email 
                                                   profile openid &redirect_uri=http://localhost:8080/Iter2/registerclub&response_type=code &client_id=754575437351-ll510639upa1os3lpv867iad3n9a1anr.apps.googleusercontent.com&approval_prompt=force" class="btn btn-soft-primary"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div>
                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Already have an account ?</small> <a href="user?action=login" class="text-dark fw-bold">Sign in</a></p>
                                        </div>
                                    </div>
                                </form>

                                <!-- Hero End -->

                                <!-- javascript -->
                                <script src="assets/js/bootstrap.bundle.min.js"></script>
                                <!-- Icons -->
                                <script src="assets/js/feather.min.js"></script>
                                <!-- Main Js -->
                                <script src="assets/js/app.js"></script>
                                </body>

                                </html>
