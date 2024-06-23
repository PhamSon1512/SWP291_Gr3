<%-- 
    Document   : index.jsp
    Created on : Jan 5, 2022, 5:51:49 PM
    Author     : Khuong Hung
--%>
<%@ page import="java.util.List" %>
<%@ page import="model.Club" %>
<%@ page import="model.Category" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<style>
    body {
        background: linear-gradient(135deg, #2c3e50 0%, #4ca1af 100%);
        font-family: 'Poppins', sans-serif;
        color: #333;
    }
    
</style>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>

    <body>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="categoryclub?categoryId=${clubId.category_id}" class="btn btn-icon btn-primary">
                <i data-feather="home" class="icons"></i>
            </a>
        </div>

                <section class="py-5" style="margin-top: -100px;">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <h1 class="display-5 fw-bolder text-center my-5" style="color: white;">${clubId.name}</h1>
                    <div class="col-md-12">
                        <img class="card-img-top mb-5 mb-md-0" src="${clubId.imageUrl}" style="width: 100%; height: 900px; object-fit: cover;" alt="..." />
                    </div>
                    <div style="margin-top: 20px;">
                        <div class="description-box" style="height: auto; display: inline-block; padding: 20px; border: 1px solid #ccc; border-radius: 8px;">
                            <p class="lead" style="color: white;">${clubId.description}</p>
                            <p style="color: white;">Thông tin liên hệ: </p>
                            <div style="color: white;"> Số điện thoại: ${clubId.phoneNumber}</div>
                            <div style="color: white;"> Fanpage: <a href="${clubId.facebook}">${clubId.facebook}</a></div><br>
                            <br>
                            <div class="d-flex">
                                <a href="registerclub" class="btn btn-primary flex-shrink-0" type="button">
                                    <i class="bi-cart-fill me-1"></i>
                                    Join
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>



        <style>
            .row.align-items-center {
                display: flex;
                align-items: center;
            }
        </style>

        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Đáng chú ý</h2>
                <div class="row">
                    <c:forEach items="${listBlogs}" var="blog">
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <img src="${blog.imageBlog}" class="card-img-top" alt="Blog Image">
                                <div class="card-body">
                                    <h5 class="card-title">${blog.title}</h5>
                                    <p class="card-text">${blog.content}</p>
                                    <a href="blogclub?blog_id=${blog.blog_id}" class="btn btn-primary">Read More</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${empty listBlogs}">
                    <p>No blogs found for this club.</p>
                </c:if>
            </div>
        </div>
    </section>


    <section class="py-5 bg-light">
        <div class="container px-4 px-lg-5 mt-5">
            <h2 class="fw-bolder mb-4">The Other Clubs</h2>
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

                <c:forEach items="${listLast}" var="L">
                    <c:if test="${L.club_id != clubId.club_id}">
                        <div class="col mb-5">
                            <div class="card h-100" style="width: 250px;">

                                <a href="detail?club_id=${L.club_id} ">
                                    <img class="card-img-top" src="${L.imageUrl}" style="width: 100%; height: 250px; object-fit: cover;" alt="..." />
                                    <!-- Product details-->
                                    <div class="card-body p-4">
                                        <div class="text-center">
                                            <!-- Product name-->
                                            <h5 class="fw-bolder">${L.name}</h5>
                                            <!-- Product reviews-->
                                            <div class="d-flex justify-content-center small text-warning mb-2">
                                                <div class="bi-star-fill"></div>
                                                <div class="bi-star-fill"></div>
                                                <div class="bi-star-fill"></div>
                                                <div class="bi-star-fill"></div>
                                                <div class="bi-star-fill"></div>
                                            </div>
                                            <span class="text-muted" style="text-decoration: none;">${L.code}</span>

                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="add-to-cart?productId=${L.club_id}">Join</a></div>
                                    </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>


            </div>
        </div>
    </section>
    <jsp:include page="layout/footer.jsp"/>




    <jsp:include page="layout/search.jsp"/>

    <jsp:include page="layout/facebookchat.jsp"/>


    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/tiny-slider.js "></script>
    <script src="assets/js/tiny-slider-init.js "></script>
    <script src="assets/js/counter.init.js "></script>
    <script src="assets/js/feather.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>
</html>