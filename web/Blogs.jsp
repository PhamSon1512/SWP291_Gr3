<%-- 
    Document   : Blogs
    Created on : May 30, 2024, 11:14:10 AM
    Author     : sodok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>
    <body>
        <jsp:include page="layout/preloader.jsp"/>

        <jsp:include page="layout/menu.jsp"/>

        <!-- Start Hero -->
        <!DOCTYPE html>
<html lang="en">
    <head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Các liên kết khác -->
</head>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .bg-half-260 {
            position: relative;
            height: 100vh;
            display: table;
            width: 100%;
            background-size: cover;
            background-position: center;
        }

        .bg-overlay {
            background-color: rgba(0, 0, 0, 0.5); /* Điều chỉnh độ mờ */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }

        .container {
            position: relative;
            z-index: 1;
        }

        .text-white {
            color: #fff !important;
        }

        .font-weight-bold {
            font-weight: 700 !important;
        }

        .arrow-down {
            display: inline-block;
            margin-top: 20px;
            cursor: pointer;
            transition: transform 0.3s;
            animation: blink 1s infinite;
        }

        .arrow-down:hover {
            transform: translateY(5px);
        }

        @keyframes blink {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0;
            }
        }
    </style>
</head>
<body>
    <section class="bg-half-260 d-table w-100" style="background: url('assets/images/imgClub/img4.jpg') center/cover; position: relative;">
        <div class="bg-overlay"></div>
        <div class="container position-relative" style="z-index: 1;">
            <div class="row mt-5 mt-lg-0">
                <div class="col-12 text-center">
                    <h1 class="text-white font-weight-bold">Welcome to Our Blogs</h1>
                    <p class="text-white mt-3">Discover the best activities and join us for an unforgettable experience.</p>
                    <h1 class="text-white font-weight-bold">Discover Hot News</h1>
                    <a href="#blogSection" class="arrow-down mt-4">
                        <i class="fas fa-chevron-down fa-2x text-white"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Phần blog bên dưới -->
    <section id="blogSection">
        <!-- Nội dung blog -->
    </section>

    <script>
        document.querySelector('.arrow-down').addEventListener('click', function(e) {
            e.preventDefault();
            document.querySelector('#blogSection').scrollIntoView({ behavior: 'smooth' });
        });
    </script>
</body>
</html>



<!-- Phần blog bên dưới -->
<section id="blogSection">
    <!-- Nội dung blog -->
    <section class="section">
            <div class="container mt-100 mt-60">
    <div class="row">
        <div class="col-lg-12">
            <div class="section-title">
                <h4 class="title mb-0">Blog List:</h4>
            </div>
        </div><!--end col-->
    </div><!--end row-->

    <div class="row mt-4 pt-2">
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/imgClub/img1.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">medicine research course for doctors</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div><!--end col-->

        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/imgClub/img2.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">Comparing Nitrogen And Mechanical Freezers</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div><!--end col-->

        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/imgClub/img3.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">It Is Very Important To Wear Proper Clothing</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div><!--end col-->

        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/chien.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">Hollowed-Out Faces More Cuts Amid Virus</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div><!--end col-->

        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/don.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">A Researcher Is Research On Coronavirus In Lab</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div><!--end col-->
        
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/manh.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">A Researcher Is Research On Coronavirus In Lab</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div>
        
        
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/son.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">A Researcher Is Research On Coronavirus In Lab</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div>
        
        
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/tien.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">A Researcher Is Research On Coronavirus In Lab</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                <img src="assets/images/feedback/chutich.jpg" class="img-fluid" alt="">
                <div class="card-body p-4">
                    <ul class="list-unstyled mb-2">
                        <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                        <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                    </ul>
                    <a href="blog-detail.html" class="text-dark title h5">A Researcher Is Research On Coronavirus In Lab</a>
                    <div class="post-meta d-flex justify-content-between mt-3">
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                            <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                        </ul>
                        <a href="blog-detail.html" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                    </div>
                </div>
            </div>
        </div>
        
        
    </div><!--end row-->
</div><!--end container-->
        </section>
</section>


</body>
</html>


</html>

        
        

        <jsp:include page="layout/footer.jsp"/>

        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>

        <jsp:include page="layout/search.jsp"/>

        <jsp:include page="layout/facebookchat.jsp"/>
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
        <script src="assets/js/tiny-slider.js "></script>
        <script src="assets/js/tiny-slider-init.js "></script>
        <script src="assets/js/counter.init.js "></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>

