<%-- 
    Document   : profile
    Created on : May 27, 2024, 10:49:05 PM
    Author     : Pham Son
--%>

<%@page import="model.Account, dal.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>
    <body>
        <style>
            .Choicefile{
                display: block;
                background: #396CF0;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }
        </style>
        <jsp:include page="layout/menu_white.jsp"/>
        <section class="bg-dashboard">
            <div class="container">
                <div class="row justify-content-center">
                    <jsp:include page="layout/profileMenu.jsp"/>
                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <h3 class="mb-0"></h3>
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">User Information</h5>
                                <p style="color: blue; align-content: center;">
                                    ${requestScope.success}
                                </p>
                            </div>
                            <div class="p-4">
                                <form action="user?action=update_image" method="POST" enctype="multipart/form-data">
                                    <h5 class="mb-0">Changes Information :</h5>
                                    <c:if test="${param.success == 'true'}">
                                        <p style="color: blue;">Update Success</p>
                                    </c:if>
                                    <c:if test="${param.success == 'false'}">
                                        <p style="color: red;">Update Fail: ${param.error}</p>
                                    </c:if>
                                    <div>
                                        <p class="text-muted">Update avatar.</p>
                                        <div id="myfileupload">
                                            <input type="file" name="image" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                                        </div>
                                        <div id="thumbbox">
                                            <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage" style="display: none" />
                                            <a class="removeimg" href="javascript:"></a>
                                        </div>
                                        <div id="boxchoice">
                                            <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Choose image</a>
                                            <p style="clear:both"></p>
                                            <input type="submit" id="submit" style="display: none" name="send" class="Update btn btn-primary" value="Changes">
                                            <p style="clear:both"></p>
                                        </div> 
                                    </div>
                                </form>
                                <%
                                    Account account = null;
                                    if (session.getAttribute("account") != null) {
                                        account = (Account) session.getAttribute("account");
                                    }
                                    if (account != null) {
                                %>            
                                <form action="user?action=update_profile" method="POST">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label class="form-label">Full Name<span class="text-danger">*</span></label>
                                                <input name="fullname" id="fullName" value="<%= account.getFullname() %>" type="text" class="form-control">
                                                <div id="fullnameError" class="text-danger">
                                                    <%= request.getAttribute("fullnameError") != null ? request.getAttribute("fullnameError") : "" %>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label class="form-label">Username<span class="text-danger">*</span></label>
                                                <input name="username" value="<%= account.getUsername() %>" id="username" type="text" class="form-control">
                                                <div id="usernameError" class="text-danger">
                                                    <%= request.getAttribute("usernameError") != null ? request.getAttribute("usernameError") : "" %>
                                                </div>
                                            </div>                                                                               
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label class="form-label">Email<span class="text-danger">*</span></label>
                                                <input name="email" oninvalid="CheckEmail(this);" oninput="CheckEmail(this);" value="<%= account.getEmail() %>" id="email" type="email" class="form-control" readonly>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label class="form-label">Phone Number<span class="text-danger">*</span></label>
                                                <input name="phone" value="<%= account.getPhone_number() %>" id="number" type="text" class="form-control">
                                                <div id="phoneNumberError" class="text-danger">
                                                    <%= request.getAttribute("phoneNumberError") != null ? request.getAttribute("phoneNumberError") : "" %>
                                                </div>
                                            </div>                                                                               
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-4">
                                                <label class="form-label">Role<span class="text-danger">*</span></label>
                                                <c:choose>
                                                    <c:when test="${account.getStatus() == 0}">
                                                        <input name="role" value="User" id="role" type="text" class="form-control" readonly>
                                                    </c:when>
                                                    <c:when test="${account.getStatus() == 1}">
                                                        <input name="role" value="Admin" id="role" type="text" class="form-control" readonly>
                                                    </c:when>
                                                    <c:when test="${account.getStatus() == 2}">
                                                        <input name="role" value="Manager" id="role" type="text" class="form-control" readonly>
                                                    </c:when>
                                                </c:choose>
                                            </div>                                                                               
                                        </div>

                                    </div>        
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="submit" id="submit" name="send" class="btn btn-primary" value="Save changes">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div id="changePasswordSection" class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Change Password :</h5>
                                <p style="color: red; align-content: center;">
                                    ${requestScope.passerror}
                                </p>
                                <p style="color: blue; align-content: center;">
                                    ${requestScope.passsuccess}
                                </p>
                            </div>

                            <div class="p-4">
                                <form action="user?action=changepassword" method="POST">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Old Password :<span class="text-danger">*</span></label>
                                                <input value="${oldPassword}" type="password"  name="oldpassword" class="form-control" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">New Password :<span class="text-danger">*</span></label>
                                                <input value="${newPassword}" id="password" type="password" name="newpassword" class="form-control" required="">
                                                <div id="passwordError" class="text-danger">
                                                    ${requestScope.passwordError}
                                                </div>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Confirm New Password :<span class="text-danger">*</span></label>
                                                <input value="${confirmPassword}" type="password" name="renewpassword" class="form-control" required="">
                                            </div>
                                        </div>
                                        <!--end col-->
                                        <div class="col-lg-12 mt-2 mb-0">
                                            <button class="btn btn-primary">Changes</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        </section>  
                        <% } else {
                        response.sendRedirect("401.jsp");
                        }
                        %>

                        <jsp:include page="layout/footer.jsp"/>
                        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
                            <jsp:include page="layout/search.jsp"/>

                        <script src="assets/js/bootstrap.bundle.min.js"></script>
                        <script src="assets/js/feather.min.js"></script>
                        <script src="assets/js/app.js"></script>
                        <script>
                            function readURL(input, thumbimage) {
                                if (input.files && input.files[0]) { //Sử dụng  cho Firefox - chrome
                                    var reader = new FileReader();
                                    reader.onload = function (e) {
                                        $("#thumbimage").attr('src', e.target.result);
                                    }
                                    reader.readAsDataURL(input.files[0]);
                                } else { // Sử dụng cho IE
                                    $("#thumbimage").attr('src', input.value);

                                }
                                $("#thumbimage").show();
                                $('.filename').text($("#uploadfile").val());
                                $(".Choicefile").hide();
                                $(".Update").show();
                                $(".removeimg").show();
                            }
                            $(document).ready(function () {
                                $(".Choicefile").bind('click', function () {
                                    $("#uploadfile").click();

                                });
                                $(".removeimg").click(function () {
                                    $("#thumbimage").attr('src', '').hide();
                                    $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
                                    $(".removeimg").hide();
                                    $(".Choicefile").show();
                                    $(".Update").hide();
                                    $(".filename").text("");
                                });
                            })
                        </script>
                        </body>

                        </html>
