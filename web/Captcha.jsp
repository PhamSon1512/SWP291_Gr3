<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="config.Captcha" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>FPT Club Management System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://unpkg.com/feather-icons"></script>

        <style>
            .alert-fixed {
                position: fixed;
                top: -100px;
                left: 0;
                right: 0;
                z-index: 1050;
                transition: top 0.5s;
            }

            .alert-show {
                top: 0;
            }
        </style>
    </head>

    <body>
        <!-- Loader -->

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="home" class="btn btn-icon btn-primary">
                <i data-feather="home" class="icons"></i>
            </a>
        </div>

        <script>
            feather.replace();
        </script>

        <!-- Hero Start -->

        <section class="bg-home d-flex bg-light align-items-center" style="background-image: url('assets/images/bg/fptu.jpg'); background-size: cover; background-position: center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="../assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                        <div class="text-center mb-4">
                            <img src="assets/images/bg/fpt.png" alt="FPT Logo" class="img-fluid" style="max-width: 200px;">
                        </div>
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">

                                <h4 class="text-center">Sign Up</h4>

                                <!-- Display error message if exists -->
                                <%
                                    String errorMessage = (String) request.getAttribute("error");
                                    String errorField = (String) request.getAttribute("errorField");
                                    if (errorMessage != null) {
                                %>
                                <div class="alert alert-danger" role="alert">
                                    <%= errorMessage %>
                                </div>
                                <%
                                    }
                                %>

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
                                    });
                                </script>
                                <%
                                    }
                                %>

                                <form action="register" class="login-form mt-4" method="post">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">First name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control <%= "firstName".equals(errorField) ? "is-invalid" : "" %>" placeholder="First Name" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Last name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control <%= "lastName".equals(errorField) ? "is-invalid" : "" %>" placeholder="Last Name" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control <%= "email".equals(errorField) ? "is-invalid" : "" %>" placeholder="Email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control <%= "phoneNumber".equals(errorField) ? "is-invalid" : "" %>" placeholder="Phone Number" name="phoneNumber" value="<%= request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "" %>" required="">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" oninvalid="CheckPassword(this);" oninput="CheckPassword(this);" class="form-control <%= "password".equals(errorField) ? "is-invalid" : "" %>" name="password" placeholder="Password" pattern="(?=.*[A-Z])(?=.*\W).{8,}" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>" required>
                                            </div>
                                        </div>

                                        <script>
                                            function CheckPassword(input) {
                                                const pattern = /^(?=.*[A-Z]).{8,}$/;
                                                if (!pattern.test(input.value)) {
                                                    input.setCustomValidity('Password must be at least 8 characters long and include at least one uppercase letter.');
                                                } else {
                                                    input.setCustomValidity('');
                                                }
                                            }
                                        </script>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control <%= "confirmPassword".equals(errorField) ? "is-invalid" : "" %>" placeholder="Confirm Password" name="confirmPassword" value="<%= request.getParameter("confirmPassword") != null ? request.getParameter("confirmPassword") : "" %>" required="">
                                            </div>
                                        </div>

                                        <!-- CAPTCHA Integration -->
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">CAPTCHA <span class="text-danger">*</span></label>
                                                <div class="captcha">
                                                    <%
                                                        String captcha = Captcha.getCaptcha(8);
                                                        session.setAttribute("captcha", captcha);
                                                    %>
                                                    <%= captcha %>
                                                </div>
                                                <input type="text" class="form-control" placeholder="Enter CAPTCHA" name="userCaptcha" required="">
                                            </div>
                                        </div>
                                        <!-- End CAPTCHA Integration -->

                                        <div class="col-md-12">
                                            <div class="d-grid">
                                                <button class="btn btn-primary">Register</button>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div>
                                        <div class="col-6 mt-3">
                                            <div class="d-grid">
                                                <a href="javascript:void(0)" class="btn btn-soft-primary"><i class="uil uil-facebook"></i> Facebook</a>
                                            </div>
                                        </div>
                                        <div class="col-6 mt-3">
                                            <div class="d-grid">
                                                <a href="javascript:void(0)" class="btn btn-soft-primary"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div>
                                        <div class="mx-auto">
                                            <span class="mb-0 mt-3"><small class="text-dark me-2">Already have an account ?</small> <a href="login.jsp" class="ms-auto">Sign in</a> </span>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero End -->

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
    </body>

</html>
