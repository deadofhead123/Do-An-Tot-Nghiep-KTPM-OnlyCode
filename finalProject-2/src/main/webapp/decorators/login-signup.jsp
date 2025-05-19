<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 3/5/2025
  Time: 10:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title><dec:title/></title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- jQuery -->
    <script src="<c:url value='//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'/>"></script>

    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="<c:url value='https://fonts.googleapis.com/css?family=Inter:300,400,500,600,700,900'/>"/>

    <!-- Nucleo Icons -->
    <link href="<c:url value='/admin/css/nucleo-icons.css'/>" rel="stylesheet"/>
    <link href="<c:url value='/admin/css/nucleo-svg.css'/>" rel="stylesheet"/>

    <!-- Font Awesome Icons -->
    <script src="<c:url value='https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous'/>"></script>

    <!-- Material Icons -->
    <link rel="stylesheet"
          href="<c:url value='https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@24,400,0,0'/>"/>

    <!-- CSS Files -->
    <link id="pagestyle" href="<c:url value='/admin/css/material-dashboard.css?v=3.2.0'/>" rel="stylesheet"/>

    <!-- For using jQuery, ajax -->
    <!--  jquery script  -->
    <script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>

    <!--  validation script  -->
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.19.0/jquery.validate.min.js"></script>

    <!--  jsrender script  -->
    <script src="http://cdn.syncfusion.com/js/assets/external/jsrender.min.js"></script>

    <!-- Essential JS UI widget -->
    <script src="http://cdn.syncfusion.com/16.4.0.52/js/web/ej.web.all.min.js"></script>
</head>
<body>
<dec:body/>

<footer class="footer position-absolute bottom-2 py-2 w-100">
    <div class="container">
        <div class="row align-items-center justify-content-lg-between">
            <div class="copyright text-center text-sm text-dark">
                Vegefood ©
                <script>
                    document.write(new Date().getFullYear())
                </script>
                ,
                modified by <b>Pham Minh Hoa</b>
            </div>

        </div>
    </div>
</footer>

<!--   Core JS Files   -->
<script src="<c:url value='/admin/js/core/popper.min.js'/>"></script>
<script src="<c:url value='/admin/js/core/bootstrap.min.js'/>"></script>
<script src="<c:url value='/admin/js/plugins/perfect-scrollbar.min.js'/>"></script>
<script src="<c:url value='/admin/js/plugins/smooth-scrollbar.min.js'/>"></script>
<script src="<c:url value='/admin/js/plugins/chartjs.min.js'/>"></script>
<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
</script>
<!-- Github buttons -->
<script async defer src="<c:url value='https://buttons.github.io/buttons.js'/>"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="<c:url value='/admin/js/material-dashboard.min.js?v=3.2.0'/>"></script>

</body>
</html>
