<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tài khoản</title>
</head>

<body>
<h2>Đổi mật khẩu</h2>

<div class="myaccount__body">
    <form:form method="get" modelAttribute="userEdit" id="form-change-password" name="form-change-password" class="bg-white p-5 contact-form ftco-animate">
        <div class="form-group">
            <label for="oldPassword"><span class="text-dark">Mật khẩu cũ</span></label>
            <input type="password" class="form-control rounded" name="oldPassword" id="oldPassword"/>
        </div>

        <div class="form-group">
            <label for="newPassword"><span class="text-dark">Mật khẩu mới</span></label>
            <input type="password" class="form-control rounded" name="newPassword" id="newPassword"/>
        </div>

        <div class="form-group">
            <label for="confirmNewPassword"><span class="text-dark">Xác nhận mật khẩu mới</span></label>
            <input type="password" class="form-control rounded" name="confirmNewPassword" id="confirmNewPassword"/>
        </div>

        <div class="form-group">
            <button type="button" class="btn btn-primary py-3 px-5" id="btnChangePassword">Lưu</button>&nbsp;
            <button type="reset" class="btn btn-dark py-3 px-5" ><a href="/home" style="color: white">Hủy</a></button>
        </div>
    </form:form>
</div>

<script>
    $(document).ready(function (){
        $('#btnChangePassword').click(function(){
            $('#form-change-password').submit();
        });
    })

    $(function(){
        $("form[name='form-change-password']").validate({
            rules:{
                oldPassword: {
                    required: true
                },
                newPassword: {
                    required: true
                },
                confirmNewPassword: {
                    required: true
                }
            },
            messages:{
                oldPassword: {
                    required: "<span style='color: red'>Phải nhập mật khẩu cũ !</span>"
                },
                newPassword: {
                    required: "<span style='color: red'>Phải nhập mật khẩu mới !</span>"
                },
                confirmNewPassword: {
                    required: "<span style='color: red'>Phải nhập xác nhận mật khẩu mới !</span>"
                }
            },
            submitHandler: function(){
                let formData = $('#form-change-password').serializeArray();
                let json = {};

                $.each(formData, function(idx, it){
                    json["" + it.name + ""] = it.value.trim();
                });

                if(json['newPassword'] !== json['confirmNewPassword']){
                    alert('Mật khẩu mới và xác nhận mật khẩu mới chưa khớp!');
                }
                else if (confirm('Bạn chắc chắn muốn đổi mật khẩu?')) {
                    changePassword(json);
                }

                console.log(json);
            }
        });
    })

    function changePassword(json) {
        $.ajax({
            url: "/api/users/change-password",
            method: "PUT",
            data: JSON.stringify(json),
            contentType: "application/json; charset=UTF-8",
            dataType: "JSON",
            success: function (result) {
                console.log(result);
                alert(result.message);
                location.reload();
            },
            error: function (result) {
                console.log(result);

                let message = result.responseJSON.message;

                $.each(result.responseJSON.details, function (idx, it) {
                    message += it + '\n';
                });

                alert(message);
            }
        });
    }

</script>

</body>
</html>