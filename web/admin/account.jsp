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
                                    <a href="account?action=all"><h5 class="mb-0">Account</h5></a>
                                    <div id="statusMessage" class="alert" role="alert" style="display: none;"></div>
                                    <c:if test="${not empty param.success}">    
                                        <div class="alert alert-success" role="alert">
                                            User added successfully.
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success" role="alert">
                                            ${successMessage}
                                        </div>
                                    </c:if>
                                </div>
                                <div class="col-md-6">
                                    <div class="search-bar p-0 d-lg-block ms-2">                                                        
                                        <div id="search" class="menu-search mb-0">
                                            <form action="account?action=search" method="POST" id="searchform" class="searchform">
                                                <div>
                                                    <input type="text" class="form-control border rounded-pill" name="search" id="s" placeholder="Find account..." value="${searchTerm}">
                                                    <input type="submit" id="searchsubmit" value="Search">
                                                </div>
                                            </form>
                                        </div>
                                    </div> 
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="justify-content-md-end row">
                                    <div class="d-grid">
                                        <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">Add New User</a>
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
                                                <th class="border-bottom p-3" >ID</th>
                                                <th class="border-bottom p-3" >Full Name</th>
                                                <th class="border-bottom p-3" >Username</th>
                                                <th class="border-bottom p-3" >Email</th>
                                                <th class="border-bottom p-3" >Phone Number</th>
                                                <th class="border-bottom p-3" >Role</th>
                                                <th class="border-bottom p-3" >Status</th>
                                                <th class="border-bottom p-3" ></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${accountList}" var="account">
                                                <tr>
                                                    <td class="p-3">${account.user_id}</td>
                                                    <td class="p-3">${account.fullname}</td>
                                                    <td class="p-3">${account.username}</td>
                                                    <td class="p-3">${account.email}</td>
                                                    <td class="p-3">${account.phone_number}</td>
                                                    <td class="p-3">
                                                        <c:choose>
                                                            <c:when test="${account.status == 0}">User</c:when>
                                                            <c:when test="${account.status == 1}">Admin</c:when>
                                                            <c:when test="${account.status == 2}">Manager</c:when>
                                                            <c:otherwise>Unknown</c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="p-3">
                                                        <button class="btn btn-sm status-toggle ${account.setting.setting_id == 1 ? 'btn-success' : 'btn-danger'}" 
                                                                data-user-id="${account.user_id}" 
                                                                data-status="${account.setting.setting_id}">
                                                            ${account.setting.setting_id == 1 ? 'Active' : 'Block'}
                                                        </button>
                                                    </td>
                                                    <td class="p-3">
                                                        <a href="#" class="edit-user" data-bs-toggle="modal" data-bs-target="#editUserModal" data-user-id="${account.user_id}">
                                                            <i class="uil uil-edit h5 mb-2"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <!-- Edit User Modal -->
                                        <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-xl">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form id="editUserForm" method="POST" action="account?action=updateUser">
                                                            <input type="hidden" name="userId" id="editUserId">
                                                            <div class="row">
                                                                <div class="col-md-4 text-center">
                                                                    <img id="editUserAvatar" src="" alt="User Avatar" class="img-fluid rounded-circle mb-3">
                                                                    <p id="editUserEmail" class="text-muted mb-3"></p>
                                                                </div>
                                                                <div class="col-md-8">
                                                                    <div class="mb-3">
                                                                        <label for="editFullname" class="form-label">Full Name<span class="text-danger">*</span></label>
                                                                        <input type="text" class="form-control" id="editFullname" name="fullname" required>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="editUsername" class="form-label">Username<span class="text-danger">*</span></label>
                                                                        <input type="text" class="form-control" id="editUsername" name="username" required>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="editPhone" class="form-label">Phone Number<span class="text-danger">*</span></label>
                                                                        <input type="tel" class="form-control" id="editPhone" name="phone">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="editRole" class="form-label">Role<span class="text-danger">*</span></label>
                                                                        <select class="form-control" id="editRole" name="role" required>
                                                                            <option value="0">User</option>
                                                                            <option value="1">Admin</option>
                                                                            <option value="2">Manager</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" form="editUserForm" class="btn btn-primary">Save changes</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Confirmation Modal -->
                                        <div class="modal fade" id="confirmStatusModal" tabindex="-1" aria-labelledby="confirmStatusModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="confirmStatusModalLabel">Confirm Status Change</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure you want to change the status of this account?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                        <button type="button" class="btn btn-primary" id="confirmStatusChange">Confirm</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </tbody>
                                    </table>
                                </div>
                            </div>


                            <c:set var="page" value="${page}"/>
                            <div class="row text-center">
                                <div class="col-12 mt-4">
                                    <div class="d-md-flex align-items-center text-center justify-content-between">
                                        <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                            <c:forEach begin="${1}" end="${num}" var="i">
                                                <li class="page-item ${i==page?"active":""}"><a class="page-link" href="account?action=all&page=${i}">${i}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </main>
        </div>

        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="addUserForm" method="POST" action="account?action=add">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="fullname" class="form-label">Full Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="fullname" name="fullname" required>
                                <div id="fullnameError" class="text-danger">
                                    <c:out value="${requestScope.fullnameError}" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email<span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" required>
                                <div id="emailError" class="text-danger">
                                    <c:out value="${requestScope.emailError}" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="setting" class="form-label">Status<span class="text-danger">*</span></label>
                                <select class="form-control" id="setting" name="setting" required>
                                    <option value="0">Deactivated</option>
                                    <option value="1">Activated</option>
                                    <option value="2">Banned</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="status" class="form-label">Role<span class="text-danger">*</span></label>
                                <select class="form-control" id="status" name="status" required>
                                    <option value="0">User</option>
                                    <option value="1">Admin</option>
                                    <option value="2">Manager</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/simplebar.min.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/select2.init.js"></script>
        <script src="assets/js/flatpickr.min.js"></script>
        <script src="assets/js/flatpickr.init.js"></script>
        <script src="assets/js/jquery.timepicker.min.js"></script> 
        <script src="assets/js/timepicker.init.js"></script> 
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>

        <script>
            $(document).ready(function () {
            <% if (request.getAttribute("showAddUserModal") != null) { %>
                $('#addUserModal').modal('show');
            <% } %>
            });
        </script>
        <script>
            $(document).ready(function () {
                var statusToggleButton;
                var userId, newStatus;

                $('.status-toggle').click(function () {
                    statusToggleButton = $(this);
                    userId = statusToggleButton.data('user-id');
                    var currentStatus = statusToggleButton.data('status');
                    newStatus = currentStatus == 1 ? 0 : 1;

                    // Show confirmation modal
                    $('#confirmStatusModal').modal('show');
                });

                $('#confirmStatusChange').click(function () {
                    // Hide confirmation modal
                    $('#confirmStatusModal').modal('hide');

                    // Perform AJAX request
                    $.ajax({
                        url: 'account',
                        method: 'POST',
                        data: {
                            action: 'toggleStatus',
                            userId: userId,
                            newStatus: newStatus
                        },
                        success: function (response) {
                            if (response === 'success') {
                                if (newStatus == 1) {
                                    statusToggleButton.removeClass('btn-danger').addClass('btn-success');
                                    statusToggleButton.text('Active');
                                } else {
                                    statusToggleButton.removeClass('btn-success').addClass('btn-danger');
                                    statusToggleButton.text('Deactive');
                                }
                                statusToggleButton.data('status', newStatus);

                                // Show success message
                                showStatusMessage('Status updated successfully.', 'success');
                            } else {
                                // Show error message
                                showStatusMessage('Failed to update status.', 'danger');
                            }
                        },
                        error: function () {
                            // Show error message
                            showStatusMessage('An error occurred while updating status.', 'danger');
                        }
                    });
                });

                function showStatusMessage(message, type) {
                    var statusMessage = $('#statusMessage');
                    statusMessage.removeClass('alert-success alert-danger').addClass('alert-' + type);
                    statusMessage.text(message);
                    statusMessage.show();
                }
            });
        </script>
        <script>
            $(document).ready(function () {
                $('.edit-user').on('click', function (e) {
                    e.preventDefault();
                    var userId = $(this).data('user-id');
                    $.ajax({
                        url: 'account?action=edit&userId=' + userId,
                        type: 'GET',
                        dataType: 'json',
                        success: function (account) {
                            $('#editUserId').val(account.user_id);
                            $('#editFullname').val(account.fullname);
                            $('#editUsername').val(account.username);
                            $('#editPhone').val(account.phone_number);
                            $('#editRole').val(account.status);
                            $('#editUserAvatar').attr('src', account.avatar_url || 'assets/images/avata.png');
                            $('#editUserEmail').text(account.email);
                            $('#editUserModal').modal('show');
                        },
                        error: function (xhr, status, error) {
                            alert('Error fetching user information: ' + xhr.responseText);
                        }
                    });
                });

                $('#editUserForm').on('submit', function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: $(this).attr('action'),
                        type: 'POST',
                        data: $(this).serialize(),
                        success: function (response) {
                            if (response === 'success') {
                                $('#editUserModal').modal('hide');
                                showStatusMessage('User information updated successfully.', 'success');
                                updateUserInTable();
                            } else {
                                showStatusMessage('Error updating user information.', 'danger');
                            }
                        },
                        error: function () {
                            showStatusMessage('Error updating user information.', 'danger');
                        }
                    });
                });

                function updateUserInTable() {
                    var userId = $('#editUserId').val();
                    var fullname = $('#editFullname').val();
                    var username = $('#editUsername').val();
                    var phone = $('#editPhone').val();
                    var role = $('#editRole option:selected').text();

                    var $row = $('tr[data-user-id="' + userId + '"]');
                    $row.find('td:eq(1)').text(fullname);
                    $row.find('td:eq(2)').text(username);
                    $row.find('td:eq(4)').text(phone);
                    $row.find('td:eq(5)').text(role);
                }

                // Hàm hiển thị thông báo
                function showStatusMessage(message, type) {
                    var statusMessage = $('#statusMessage');
                    statusMessage.removeClass('alert-success alert-danger').addClass('alert-' + type);
                    statusMessage.text(message);
                    statusMessage.show();
                }
            });
        </script>

        <style>
            .modal-xl {
                max-width: 90%;
            }
            #editUserAvatar {
                width: 200px;
                height: 200px;
                object-fit: cover;
                border-radius: 50%;
                margin: 0 auto;
                display: block;
            }
            #editUserEmail {
                font-size: 1.2rem;
                word-break: break-all;
            }
        </style>
    </body>
</html>