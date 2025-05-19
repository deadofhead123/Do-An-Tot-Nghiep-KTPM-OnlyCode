<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Tài khoản</title>

</head>

<body>
<h2>Thông tin tài khoản</h2>

<div class="myaccount__body">
<%--    <div class="row block-27">--%>
<%--        		<!-- Information -->--%>
<%--        <div class="col-md-12 order-md-last d-flex ftco-animate">--%>
            <form:form method="get" modelAttribute="userEdit" id="form-edit" name="form-edit" class="bg-white p-5 contact-form ftco-animate">
                <div class="form-group">
                    <label for="email"><span class="text-dark">Email</span></label>
                    <form:input type="text" path="email" class="form-control rounded" name="email" id="email" readonly="true"/>
                </div>

                <div class="form-group">
                    <label for="fullName"><span class="text-dark">Họ tên</span></label>
                    <form:input type="text" path="fullName" class="form-control rounded" name="fullName" id="fullName"/>
                </div>

                <div class="form-group">
                    <label for="phoneNumber"><span class="text-dark">Số điện thoại</span></label>
                    <form:input type="text" path="phoneNumber" class="form-control rounded"
                                placeholder="Nhập số điện thoại" name="phoneNumber" id="phoneNumber"/>
                </div>

                <div class="form-group">
                    <label for="phoneNumber"><span class="text-dark">Địa chỉ</span></label>
                    <form:input type="text" path="address" class="form-control rounded"
                                placeholder="Nhập địa chỉ" name="address" id="address"/>
                </div>

                <div class="form-group">
                    <button type="button" class="btn btn-primary py-3 px-5" id="btnUpdate">Lưu</button>&nbsp;
                    <button type="reset" class="btn btn-dark py-3 px-5"><a href="home">Hủy</a></button>
                </div>
            </form:form>

<%--        </div>--%>
<%--    </div>--%>
</div>

<script>
	$(document).ready(function (){
        $('#btnUpdate').click(function(){
            $('#form-edit').submit();
        });
    })

    $(function(){
        $("form[name='form-edit']").validate({
            rules:{
                fullName: {
                    required: true
                },
                phoneNumber: {
                    required: true,
                    minlength: 10,
                    maxlength: 10
                },
                address: {
                    required: true
                }
            },
            messages:{
                fullName: {
                    required: "<span style='color: red'>Phải nhập họ tên !</span>"
                },
                phoneNumber: {
                    required: "<span style='color: red'>Phải nhập số điện thoại !</span>",
                    minlength: "<span style='color: red'>Số điện thoại phải đủ 10 ký tự !</span>",
                    maxlength: "<span style='color: red'>Số điện thoại phải đủ 10 ký tự !</span>"
                },
                address: {
                    required: "<span style='color: red'>Phải nhập địa chỉ !</span>"
                }
            },
            submitHandler: function(){
                let formData = $('#form-edit').serializeArray();
                let json = {};

                $.each(formData, function(idx, it){
                    json["" + it.name + ""] = it.value.trim();
                });

                console.log(json);

                if(confirm('Bạn chắc chắn muốn cập nhật thông tin?')){
                    update(json);
                }
            }
        });
    })

	function update(json){
		$.ajax({
			url: "/api/users",
			method: "PUT",
			data: JSON.stringify(json),
			contentType: "application/json; charset=UTF-8",
			dataType: "JSON",
			success: function(result){
				console.log(result);
				alert(result.message);
				location.reload();
			},
			error: function(result){
				console.log(result);

                let message = result.responseJSON.message + '\n';

                $.each(result.responseJSON.details, function(idx, it){
                    message += it + '\n';
                });

				alert(message);
			}
		});
	}

</script>

</body>
</html>