<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="pageURL" value="/contact"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Liên hệ</title>
</head>
<body class="goto-here">

<div class="hero-wrap hero-bread" style="background-image: url('web-user/images/bg_1.jpg');">
    <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
            <div class="col-md-9 ftco-animate text-center">
                <p class="breadcrumbs" style="font-size: 14px"><span class="mr-2"><a href="/home">Trang chủ</a></span></p>
                <h1 class="mb-0 bread">Liên hệ</h1>
            </div>
        </div>
    </div>
</div>

<section class="ftco-section contact-section bg-light">
    <div class="container">
        <h3 class="heading-section text-center bold ftco-animate">Gửi thông tin cho chúng tôi</h3>

        <div class="row d-flex mb-5 contact-info">
            <div class="w-200"></div>
            <div class="col-md-4 d-flex ftco-animate">
                <div class="info bg-white p-4">
                    <p><span class="text-dark"><strong>Địa chỉ:&nbsp;</strong>Số 298 đường Cầu Diễn, Phường Minh Khai, Quận Bắc Từ Liêm, Thành phố Hà Nội.</span></p>
                </div>
            </div>
            <div class="col-md-4 d-flex ftco-animate">
                <div class="info bg-white p-4">
                    <p><span class="text-dark"><strong>Số điện thoại:</strong></span> <a href="tel://1234567920">+84 984 243 005</a></p>
                </div>
            </div>
            <div class="col-md-4 d-flex ftco-animate">
                <div class="info bg-white p-4">
                    <p><span class="text-dark"><strong>Email:</strong></span> </p><a href="mailto:info@yoursite.com" class="text-dark">phamminhhoa3005.shopapp@gmail.com</a>
                </div>
            </div>
        </div>

        <!-- Map and information to contact-->
        <div class="row block-9">
            <!-- Information -->
            <div class="col-md-6 order-md-last d-flex ftco-animate">
                <form method="get" id="form-contact" name="form-contact" class="bg-white p-5 contact-form">
                    <div class="form-group">
                        <input type="text" class="form-control rounded" placeholder="Họ tên" id="fullName" name="fullName"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control rounded" placeholder="Email" id="email" name="email"/>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control rounded" placeholder="Số điện thoại" id="phoneNumber" name="phoneNumber"/>
                    </div>
                    <div class="form-group">
                        <textarea cols="30" rows="7" class="form-control" placeholder="Nội dung" id="description" name="description"></textarea>
                    </div>
                    <div class="form-group">
                        <button type="button" class="btn btn-primary py-3 px-5" id="btnAddContact">Gửi liên hệ</button>
                    </div>
                </form>
            </div>

            <!-- Map  -->
            <div class="col-md-6 d-flex ftco-animate">
                <div id="map" class="bg-white">
                    <div class="google-map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1106.994165823025!2d105.73479361614764!3d21.05389429347762!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31345457e292d5bf%3A0x20ac91c94d74439a!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBDw7RuZyBuZ2hp4buHcCBIw6AgTuG7mWk!5e0!3m2!1svi!2s!4v1740557384638!5m2!1svi!2s"
                                width="800" height="600"
                                style="width: 100%; border:0;"
                                allowfullscreen=""
                                loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function (){
        $('#btnAddContact').click(function(){
            $('#form-contact').submit();
        });
    });

    $(function(){
        $("form[name='form-contact']").validate({
            rules:{
                fullName:{
                    required: true
                },
                phoneNumber: {
                    required: true
                },
                email: {
                    required: true
                },
                description: {
                    required: true
                }
            } ,
            messages:{
                fullName:{
                    required: "<span style='color: red'>Phải điền họ tên !</span>"
                },
                phoneNumber: {
                    required: "<span style='color: red'>Phải điền số điện thoại !</span>"
                },
                email: {
                    required: "<span style='color: red'>Phải điền email !</span>"
                },
                description: {
                    required: "<span style='color: red'>Phải điền mô tả !</span>"
                }
            },
            submitHandler: function(form){
                let formData = $('#form-contact').serializeArray();
                let json = {};

                $.each(formData, function(idx, it){
                    json["" + it.name + ""] = it.value.trim();
                });

                console.log(json);

                if(confirm('Bạn chắc chắn muốn gửi liên hệ?')){
                    addContact(json);
                }
            }
        });
    });

    function addContact(json){
        $.ajax({
            url: "/api/contacts",
            method: "POST",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify(json),
            dataType: "JSON",
            success: function(result){
                console.log(result);
                alert(result.message);
                window.location.href = "${pageURL}";
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