<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
    <jsp:include page="../admin/layout/adminhead.jsp"/>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../admin/layout/menu.jsp"/>
            <main class="page-content bg-light">
                <jsp:include page="../admin/layout/headmenu.jsp"/>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-md-10 row">
                                <div class="col-md-4">
                                    <h5 class="mb-0">Members</h5>
                                    <div id="statusMessage" class="alert" role="alert" style="display: none;"></div>
                                </div>
                                <div class="col-md-6">
                                    <div class="search-bar p-0 d-lg-block ms-2">
                                        <div id="search" class="menu-search mb-0">
                                            <form action="memberdetail?action=search" method="POST" id="searchform" class="searchform">
                                                <div>
                                                    <input type="text" class="form-control border rounded-pill" name="query" id="s" placeholder="Search members..." value="${param.query}">
                                                    <input type="submit" id="searchsubmit" value="Search">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3">Serial No.</th>
                                                <th class="border-bottom p-3">Image</th>
                                                <th class="border-bottom p-3">Full Name</th>
                                                <th class="border-bottom p-3">Position</th>
                                                <th class="border-bottom p-3">Email</th>
                                                <th class="border-bottom p-3">Active Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty clubMembers}">
                                                    <c:forEach var="member" items="${clubMembers}" varStatus="status">
                                                        <tr>
                                                            <td class="p-3">${status.index + 1}</td>
                                                            <td class="p-3">
                                                                <img src="${not empty member.imageUrl ? member.imageUrl : 'assets/images/avata.png'}" 
                                                                     alt="Member Image" 
                                                                     class="avatar avatar-ex-small rounded-circle">
                                                            </td>
                                                            <td class="p-3">${member.fullName}</td>
                                                            <td class="p-3">${specialityMap[member.speciality_id]}</td>
                                                            <td class="p-3">${member.email}</td>
                                                            <td class="p-3">
                                                                <button class="btn btn-sm ${member.active_status ? 'btn-success' : 'btn-danger'} toggle-active" 
                                                                        data-member-id="${member.user_id}" 
                                                                        data-active-status="${member.active_status}">
                                                                    ${activeStatusMap[member.active_status]}
                                                                </button>
                                                            </td>

                                                        </tr>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="6" class="text-center">No members to display.</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </main>
        </div>

        <!-- Add Member Modal -->

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/simplebar.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script>
            $(document).ready(function () {
                $('.toggle-active').click(function () {
                    var button = $(this);
                    var memberId = button.data('member-id');
                    var currentStatus = button.data('active-status');

                    $.ajax({
                        url: 'toggleMemberStatus',
                        type: 'POST',
                        data: {
                            memberId: memberId,
                            activeStatus: !currentStatus
                        },
                        success: function (response) {
                            if (response === 'success') {
                                // Update button appearance
                                button.toggleClass('btn-success btn-danger');
                                var newStatus = !currentStatus;
                                button.data('active-status', newStatus);
                                button.text(newStatus ? 'Active' : 'Non-Active');

                                // Show status message
                                $('#statusMessage').text('Member status updated successfully')
                                        .removeClass('alert-danger')
                                        .addClass('alert-success')
                                        .show()
                                        .delay(3000)
                                        .fadeOut();
                            } else {
                                // Show error message
                                $('#statusMessage').text('Failed to update member status')
                                        .removeClass('alert-success')
                                        .addClass('alert-danger')
                                        .show()
                                        .delay(3000)
                                        .fadeOut();
                            }
                        },
                        error: function () {
                            // Show error message
                            $('#statusMessage').text('An error occurred while updating member status')
                                    .removeClass('alert-success')
                                    .addClass('alert-danger')
                                    .show()
                                    .delay(3000)
                                    .fadeOut();
                        }
                    });
                });
            });
        </script>
    </body>
</html>
