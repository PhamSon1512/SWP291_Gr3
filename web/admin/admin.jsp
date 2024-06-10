<%-- 
    Document   : admin
    Created on : May 27, 2024, 8:03:42 AM
    Author     : sodok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="layout/head.jsp"/>
    <body>
        <jsp:include page="layout/preloader.jsp"/>

        <jsp:include page="layout/menuAfter.jsp"/>

        <section class="bg-half-260 d-table w-100" style="background: url('assets/images/bg/logo.jpg') center;">
            <div class="bg-overlay bg-overlay-"></div>
            <div class="container">
                <div class="row mt-5 mt-lg-0">
                    <div class="col-12">
                        <div class="heading-title">
                            <img src="assets/images/bg/fpt.png" height="50" alt="">
                            <h4 class="display-4 fw-bold text-white title- mt-3 mb-4">Simplifying <br> Club Management</h4>
                            <p class="para-desc text-white-50 mb-0">Our club management website makes organizing and managing school clubs easy. With tools for event planning and member management, students and teachers can connect and work efficiently.   </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <span class="badge badge-pill badge-soft-primary mb-3">Read News</span>
                            <h4 class="title mb-4">Latest News & Blogs</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Our club management website makes organizing and managing school clubs easy. With tools for event planning and member management, students and teachers can connect and work efficiently.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                        <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                            <img src="<c:url value='assets/images/imgClub/img1.jpg' />" class="img-fluid" alt="">
                            <div class="card-body p-4">
                                <ul class="list-unstyled mb-2">
                                    <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>30th December, 2022</li>
                                    <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                                </ul>
                                <a href="blog-detail.html" class="text-dark title h5">🚩𝐄𝐓𝐇𝐈𝐂𝐀𝐋 𝐇𝐀𝐂𝐊𝐄𝐑𝐒 𝐂𝐋𝐔𝐁 𝐑𝐄𝐂𝐑𝐔𝐈𝐌𝐄𝐍𝐓 𝐆𝐄𝐍 𝟔🚩 EHC - CÂU LẠC BỘ AN TOÀN THÔNG TIN TUYỂN QUÂN</a>
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

                    <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                        <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                            <img src="<c:url value='assets/images/imgClub/img2.jpg' />" class="img-fluid" alt="">
                            <div class="card-body p-4">
                                <ul class="list-unstyled mb-2">
                                    <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>14th May, 2024</li>
                                    <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                                </ul>
                                <a href="blog-detail.html" class="text-dark title h5">FGC SHOW NHẠC KỊCH 2024 - ILLUMINATE
                                    ‼️Show nhạc kịch đình đám của FU Guitar Club chính thức quay trở lại.</a>
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

                    <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                        <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                            <img src="<c:url value='assets/images/imgClub/img3.jpg' />" class="img-fluid" alt="">
                            <div class="card-body p-4">
                                <ul class="list-unstyled mb-2">
                                    <li class="list-inline-item text-muted small me-3"><i class="uil uil-calendar-alt text-dark h6 me-1"></i>20th November, 2020</li>
                                    <li class="list-inline-item text-muted small"><i class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                                </ul>
                                <a href="blog-detail.html" class="text-dark title h5">[HỖ TRỢ TRUYỀN THÔNG]
                                    𝐈𝐍𝐓𝐄𝐑𝐍𝐀𝐓𝐈𝐎𝐍𝐀𝐋 𝐃𝐀𝐘 𝟐𝟎𝟐𝟒 | ONE TEAM, ONE DREAM</a>
                                <div class="post-meta d-flex justify-content-between mt-3">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item me-2 mb-0"><a href="#" class="text-muted like"><i class="mdi mdi-heart-outline me-1"></i>33</a></li>
                                        <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>08</a></li>
                                    </ul>
                                    <a href="BlogDetail.jsp" class="link">Read More <i class="mdi mdi-chevron-right align-middle"></i></a>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div>

            <div class="container mt-100 mt-60">
                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-6">
                        <div class="position-relative">
                            <img src="<c:url value='assets/images/imgClub/img4.jpg' />" class="img-fluid" alt="">
                            <div class="play-icon">
    <a href="<c:url value='/assets/images/imgClub/video.mp4' />" data-bs-toggle="modal" data-bs-target="#watchvideomodal" class="play-btn video-play-icon">
        <i class="mdi mdi-play text-primary rounded-circle bg-white title-bg-shadow"></i>
    </a>
</div>

<!-- Modal Structure -->
<div class="modal fade" id="watchvideomodal" tabindex="-1" aria-labelledby="watchvideomodalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="watchvideomodalLabel">Watch Video</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <video id="videoPlayer" width="100%" controls>
                    <source src="<c:url value='/assets/images/imgClub/video.mp4' />" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
        </div>
    </div>
</div>
<style>
    #videoPlayer {
        width: 100%; /* Makes the video take full width of the modal */
        max-height: 80vh; /* Ensures video does not exceed viewport height */
    }
    .modal-xl {
        max-width: 90%; /* Makes the modal wider */
    }
</style>
                        </div>
                    </div>

                    <div class="col-lg-7 col-md-6 mt-4 mt-lg-0 pt- pt-lg-0">
                        <div class="ms-lg-4">
                            <div class="section-title">
                                <h4 class="title mb-4">Comprehensive Club Management Tools - Optimize operation and enhance member interaction</h4>
                                <p class="text-muted para-desc">Welcome to our club management website - a comprehensive solution to help optimize the club's activities and enhance the interaction between members.</p>
                                <p class="text-muted para-desc mb-0">Our website is designed with the goal of providing powerful and easy -to -use tools, helping club managers effectively manage their activities, events and members.</p>
                            </div>

                            <div class="mt-4">
                                <a href="#" class="btn btn-primary">Search for more <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
<section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title mb-4">FeedBack</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Enhancing club efficiency and member satisfaction with our advanced features.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row justify-content-center">
                    <div class="col-lg-8 mt-4 pt-2 text-center">
                        <div class="client-review-slider">
                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">"I love the clean design and how all the important features are easily accessible."</p>
                                <img src="<c:url value='assets/images/feedback/chutich.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Truong Gia Binh <small class="text-muted">Founder</small></h6>
                            </div><!--end customer testi-->

                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">"The event management feature is fantastic. It has made organizing club activities so much easier."</p>
                                <img src="<c:url value='assets/images/feedback/manh.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Van Manh <small class="text-muted">C.E.O</small></h6>
                            </div><!--end customer testi-->

                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">" "The dashboard provides a comprehensive overview of all club activities, which is incredibly helpful."</p>
                                <img src="<c:url value='assets/images/feedback/don.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Quy Don <small class="text-muted">Student</small></h6>
                            </div><!--end customer testi-->

                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">"I appreciate the responsive design. The site works perfectly on both desktop and mobile devices."</p>
                                <img src="<c:url value='assets/images/feedback/son.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Pham Son <small class="text-muted">Manager</small></h6>
                            </div><!--end customer testi-->

                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">"The search functionality is fast and accurate, making it easy to find specific members or events."</p>
                                <img src="<c:url value='assets/images/feedback/tien.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Hoang Nam Tien <small class="text-muted">C.E.O</small></h6>
                            </div><!--end customer testi-->

                            <div class="tiny-slide text-center">
                                <p class="text-muted h6 fw-normal fst-italic">"The automated notifications for upcoming events and deadlines are very useful."</p>
                                <img src="<c:url value='assets/images/feedback/chien.jpg' />" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow my-3" alt="">
                                <ul class="list-unstyled mb-0">
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                    <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                </ul>
                                <h6 class="text-primary">- Xuan Chien <small class="text-muted">Student</small></h6>
                            </div><!--end customer testi-->
                        </div><!--end carousel-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <!--end container-->
        </section><!--end section-->
        <!-- End -->


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
