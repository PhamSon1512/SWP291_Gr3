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
                        <c:forEach var="entry" items="${departmentMembersMap}">
                            <c:set var="deptInfo" value="${departmentInfoMap[entry.key]}" />
                            <div class="department-section mb-5">
                                <h2 class="department-title mb-4">${specialityMap[entry.key]}</h2>
                                
                                <div id="department-info-${entry.key}" class="department-info card mb-4">
                                    <div class="card-header bg-primary text-white">
                                        <h3 class="mb-0">Department Information</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover mb-0">
                                                <thead class="bg-light">
                                                    <tr>
                                                        <th>Description</th>
                                                        <th>Current Projects</th>
                                                        <th>Regular Meeting Schedule</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>${deptInfo.description}</td>
                                                        <td>${deptInfo.currentProjects}</td>
                                                        <td>${deptInfo.regularMeetingSchedule}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div id="members-${entry.key}" class="members card">
                                    <div class="card-header bg-success text-white">
                                        <h3 class="mb-0">Members</h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover mb-0">
                                                <thead>
                                                    <tr>
                                                        <th>Image</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Active Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="member" items="${entry.value}">
                                                        <tr class="member">
                                                            <td>
                                                                <img src="${not empty member.imageUrl ? member.imageUrl : 'assets/images/avata.png'}" 
                                                                     alt="Member Image" 
                                                                     class="avatar rounded-circle" width="40" height="40">
                                                            </td>
                                                            <td>${member.fullName}</td>
                                                            <td>${member.email}</td>
                                                            <td>
                                                              <button class="btn btn-sm ${member.active_status ? 'btn-success' : 'btn-danger'} toggle-active" 
        data-member-id="${member.user_id}" 
        data-active-status="${member.active_status}">
    ${member.active_status ? 'Active' : 'Non-Active'}
</button>
                                                            </td>

                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </main>
        </div>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/simplebar.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>

        <style>
            .department-section {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .department-title {
                color: #343a40;
                border-bottom: 2px solid #007bff;
                padding-bottom: 10px;
            }
            .card {
                border: none;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            .card-header {
                font-weight: bold;
            }
            .table th {
                font-weight: 600;
            }
            .avatar {
                object-fit: cover;
            }
        </style>

        <script>
            function showDepartmentInfo(specialityId) {
                document.querySelectorAll('.department-info, .members').forEach(function (element) {
                    element.classList.remove('active');
                });

                document.getElementById('department-info-' + specialityId).classList.add('active');
                document.getElementById('members-' + specialityId).classList.add('active');
            }
        </script>
    </body>
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
                    var newStatus = !currentStatus;
                    button.toggleClass('btn-success btn-danger');
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
</html>