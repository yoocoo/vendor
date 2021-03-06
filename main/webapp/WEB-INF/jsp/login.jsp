<%--
  Created by IntelliJ IDEA.
  User:  WJ
  Date: 2017/4/14
  Time: 12:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script type="text/javascript">
    var path = "${path}";
</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script type="text/javascript" src="${path}/static/js/login/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${path}/static/js/common/jquery.tips.js"></script>
<script type="text/javascript" src="${path}/static/js/login/login.js"></script>

<%--<script type="text/javascript" src="<c:url value='/static/js/jquery-3.1.1.min.js'/>"></script>--%>
<%--<script type="text/javascript" src="<c:url value='/static/js/jquery.tips.js'/>"></script>--%>
<%--<script type="text/javascript" src="<c:url value='/static/js/login.js'/>"></script>--%>
<head>
    <meta charset="UTF-8">
    <title>售货机系统账户登录</title>

    <%--<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">--%>
    <link rel='stylesheet prefetch' href='https://fonts.googleapis.com/icon?family=Material+Icons'>
    <link rel="shortcut icon" href="${path}/static/img/favicon.ico"/>
    <link type="text/css" rel="stylesheet" href="${path}/static/css/login/login.css">
    <!-- Font Awesome -->
    <link type="text/css" rel="stylesheet"
          href="<c:url value='/static/vendors/font-awesome/css/font-awesome.min.css'/>">

    <%--<link rel="shortcut icon" href="<c:url value='/static/img/favicon.ico'/>"/>--%>
    <%--<link type="text/css" rel="stylesheet" href="<c:url value='/static/css/login.css'/>">--%>
    <%--<link rel="stylesheet" href="/css/login.css">--%>

    <script type="text/javascript">
        function checkLoginInfo() {
            if ("" == $("#u").val()) {  //u标签的值为空
                $("#u").tips({ // .tips 是js提示标签的调用方法，具体的轮廓如上面的登陆页面的提示标签
                    side: 2,
                    msg: '用户名不得为空',//提示信息
                    bg: '#B22222',//提示的背景颜色
                    time: 3//提示呈现的时间
                });
                $("#u").focus();  //让u标签获取输入焦点
                return false;  //返回false，打断js的执行
            }
            if ($("#p").val() == "") {

                $("#p").tips({
                    side: 2,
                    msg: '密码不得为空',
                    bg: '#B22222',
                    time: 3
                });
                $("#p").focus();
                return false;
            }
            return true;
        }

        function webLogin() {
            if (checkLoginInfo()) {
                var name = $("#u").val();
                //                var是申明一个变量的关键字，accountName为变量名，
                //                $("#u")是找到一个标签ID为"u"的标签，.val() 是获取对应ID标签的值
                var pwd = $("#p").val();
                $.ajax({   //使用jquery下面的ajax开启网络请求
                    type: "POST",  //http请求方式为POST
                    url: '<%=request.getContextPath()%>/userAction/login',   //请求接口的地址
                    data: {accountName: name, password: pwd},   //存放的数据，服务器接口字段为accountName和password，分别对应用户登录名和密码
                    dataType: 'json',   //当这里指定为json的时候，获取到了数据后会自己解析的，只需要 返回值.字段名称 就能使用了
                    cache: false,  //不用缓存
                    success: function (data) { //请求成功，http状态码为200。返回的数据已经打包在data中了
                        if (data.code == 1) {  //获判断json数据中的code是否为1，登录的用户名和密码匹配，通过效验，登陆成功
                            //window.location.href = data.data.nextUrl; //跳转到主页
                            window.location.href = "<%=request.getContextPath()%>/mvc/home";
                        } else {
                            alert(data.msg);
                            $("#u").focus();
                        }
                    }
                });
            }
        }

        function webReg() {
            if ($('#user').val() == "") {
                $('#user').focus();
                $('#user').tips({
                    side: 2,
                    msg: '用户名不能为空',
                    bg: '#B22222',
                    time: 3,
                });
                return false;
            }
            if ($('#user').val().length < 4 || $('#user').val().length > 10) {
                $('#user').focus();
                $('#user').tips({
                    side: 2,
                    msg: '用户名位数建议4-10位',
                    bg: '#B22222',
                    time: 3,
                });
                return false;
            }
            if ($('#passwd').val().length < 6) {
                $('#passwd').focus();
                $("#passwd").tips({
                    side: 2,
                    msg: '密码不能小于6位',
                    bg: '#B22222',
                    time: 3
                });
                return false;
            }
            if ($('#passwd2').val() != $('#passwd').val()) {
                $('#passwd2').focus();
                $("#passwd2").tips({
                    side: 2,
                    msg: '两次密码不一致',
                    bg: '#B22222',
                    time: 3
                });
                return false;
            }


            var sqq = /^1[34578]\d{9}$/;
            if (!sqq.test($('#cellnumber').val())
                || $('#cellnumber').val().length < 11
                || $('#cellnumber').val().length > 14
                || $('#cellnumber').val() == "") {

                $('#cellnumber').focus();
                $("#cellnumber").tips({
                    side: 2,
                    msg: '手机号不正确',
                    bg: '#B22222',
                    time: 3
                });
                return false;
            }
            var loginname = $("#user").val();
            var password = $("#passwd").val();
            var cellnumber = $("#cellnumber").val();
            $.ajax({
                type: "POST",
                url: '<%=request.getContextPath()%>/userAction/reg',
                data: {accountName: loginname, password: password, mobilePhone: cellnumber},
                dataType: 'json',   //当这里指定为json的时候，获取到了数据后会自己解析的，只需要 返回值.字段名称 就能使用了
                cache: false,
                success: function (data) {
                    if (data.code == 1) {
                        window.location.href = data.data.nextUrl;
                    } else {
                        alert(data.msg);
                        $("#user").focus();
                    }
                }
            });


        }
    </script>


</head>
<html>
<body>

<div class="cotn_principal">
    <div class="cont_centrar">
        <div class="cont_login">
            <div class="cont_info_log_sign_up">
                <div class="col_md_login">
                    <div class="cont_ba_opcitiy">
                        <h2>用户登录</h2>
                        <br/>
                        <br/>


                        <%--<p>遵守用户登录规则，保管好个人信息！</p>--%>
                        <button class="btn_login" onclick="cambiar_login()">登 录</button>
                    </div>
                </div>
                <div class="col_md_sign_up">
                    <div class="cont_ba_opcitiy">
                        <h2>加盟</h2>
                        <br/>
                        <br/>


                        <%--<p> *推荐使用ie8或以上版本ie浏览器或<br/>--%>
                        <%--Chrome内核浏览器访问本站</p>--%>
                        <button class="btn_sign_up" onclick="cambiar_sign_up()">详情</button>
                    </div>
                </div>
            </div>
            <div class="cont_back_info">
                <div class="cont_img_back_grey"><img src="<c:url value='/static/images/denglu.jpg'/>" alt=""/></div>
            </div>
            <div class="cont_forms">
                <div class="cont_img_back_"><img src="<c:url value='/static/images/denglu.jpg'/>" alt=""/></div>
                <div id="web_login">

                    <form name="loginform" id="login_form" class="cont_form_login"
                          action=""
                    <%--accept-charset="utf-8"--%>
                          method="POST">
                        <a href="#" onclick="ocultar_login_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
                        <h2>用户登录</h2>
                        <input type="text" id="u" name="accountName" placeholder="账号"/>
                        <input type="password" id="p" name="password" placeholder="密码"/>

                        <input type="button" value="                                  登    录" id="btn_login"
                               onclick="webLogin();" class="btn_login"/>

                    </form>
                </div>
                <%--登录 end--%>


                <div class="cont_form_sign_up"><a href="#" onclick="ocultar_login_sign_up()"><i class="material-icons">
                    &#xE5C4;</i>
                </a>
                    <%--5.30 日更改由此声明： 由于该系统暂时不需要 用户自主注册功能,暂时换成，用户登录准则--%>
                    <h2>加盟详情</h2>

                    <p>1.</p>
                    <p>2.</p>
                    <p>3.</p>
                    <p>
                        <%--<marquee direction="up" height="400px" width="200px"--%>
                        <%--scrollamount="2" onmouseover="stop();" onmouseout="start();">--%>
                        <%--<p>阅读《售货机协议》及《售货机服务条款》</p>--%>
                        <%--<p>（一）</p>--%>
                        <%--<p>用户必须同意，其提供的真实的、准确的、合法的帐号</p>--%>
                        <%--<p>，这是作为认定用户与售货机的关联性以及确认用户身</p>--%>
                        <%--<p>份的唯一证据。 用户在享用售货机提供的各项服务的</p>--%>
                        <%--<p>同时，   同意接受售货机后台管理系统提供的各类</p>--%>
                        <%--<p> 信息服务。</p>--%>
                        <%--<p>（二）</p>--%>
                        <%--<p>售货机公司始终在不断变更和改进服务。售货机公司</p>--%>
                        <%--<p>可能会增加或删除功能，也可能暂停或彻底停止某项</p>--%>
                        <%--<p>服务。用户同 意售货机公司有权行使上述权利且不需</p>--%>
                        <%--<p>对用户或第三方承担任何责任。</p>--%>
                        <%--</marquee>--%>
                    </p>
                    <%--<div id="web_reg">--%>
                    <%--5月出 注册版本， 注册开始--%>
                    <%--<form name="regform" id="regUser" class="cont_form_sign_up"--%>
                    <%--action=""--%>
                    <%--accept-charset="utf-8"--%>
                    <%--method="post">--%>
                    <%--<a href="#" onclick="ocultar_login_sign_up()"><i class="material-icons">--%>
                    <%--&#xE5C4;</i></a>--%>

                    <%--<h2>注 册</h2>--%>
                    <%--<input type="text" id="user" name="accountName" placeholder="账号"/>--%>
                    <%--<input type="password" id="passwd" placeholder="密码" name="password"/>--%>
                    <%--<input type="password" id="passwd2" placeholder="确认密码" name="password"/>--%>
                    <%--<input type="text" id="cellnumber" placeholder="联系电话" name="mobilePhone"/>--%>
                    <%--<input class="btn_sign_up" type="button" id="reg" onclick="webReg();"--%>
                    <%--value="                         同意协议并注册"/>--%>
                    <%--&lt;%&ndash;<a href="#" target="_blank"> 注册协议</a>&ndash;%&gt;--%>
                    <%--</form>--%>
                    <%--</div>--%>
                    <%--注册结束--%>
                    <%--</div>--%>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>

