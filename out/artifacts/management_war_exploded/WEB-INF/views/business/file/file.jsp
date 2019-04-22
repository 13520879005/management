<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
String webapp = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<script type="text/javascript">
	if(/Android (\d+\.\d+)/.test(navigator.userAgent)){
		var version = parseFloat(RegExp.$1);
		if(version>2.3){
			var phoneScale = parseInt(window.screen.width)/640;
			document.write('<meta name="viewport" content="width=640, minimum-scale = '+ phoneScale +', maximum-scale = '+ phoneScale +', target-densitydpi=device-dpi">');
		}else{
			document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
		}
	}else{
		document.write('<meta name="viewport" content="width=640, user-scalable=no, target-densitydpi=device-dpi">');
	}
	</script>
	<title></title>
	<link rel="stylesheet" href="<%=basePath%>business/css/file/animate.css">
	<link rel="stylesheet" href="<%=basePath%>business/css/file/style.css">
</head>
<body>
  <form name="form" action="" method="POST" enctype="multipart/form-data">
	<div class="wrap">
		<div class="album-old">
			<div class="upload-btn btn-old"><input type="file" name="file" id="image_btn1"></div>
			<div class="upload-img "></div>	
		</div>
		<div class="album-new">
			<div class="upload-btn btn-new"><input type="file" name="file" id="image_btn2"></div>
			<div class="upload-img "></div>
		</div>
		<div class="wan"></div>
		<div class="textarea">
			<textarea placeholder="请填写您和您闺蜜的故事，字数不超过20字"></textarea>
		</div>
		<div class="submit"></div>
	</div>
	</form>
	<script type="text/javascript" src="<%=basePath%>business/js/zepto.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>business/js/iscroll-zoom.js"></script>
  <script type="text/javascript" src="<%=basePath%>business/js/jquery-1.11.3.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/js/ajaxfileupload.js"></script>
	<script type="text/javascript">

        $(function() {
            var _w = 456;
            var _h = 344;
            var _old = {};
            var _new = {};
            var _txt = $(".textarea textarea");

            $(".upload-btn input").on("change", function() {
                var _this = $(this);
                var fr = new FileReader();
                fr.readAsDataURL(this.files[0]);

                var img = new Image();
                var btn = _this.parent();
                btn.hide();
                var upImg = btn.siblings(".upload-img");
                upImg.addClass("loading");

                fr.onload = function() {
                    img.src = this.result;
                    img.onload = function() {
                        btn.siblings(".upload-img").html(img);
                        var ratio = 1;
                        if (img.width > img.height) {
                            upImg.find("img").addClass("mh");
                            ratio = _h / img.height;
                        } else {
                            upImg.find("img").addClass("mw");
                            ratio = _w / img.width;
                        }

                        var scroll = new IScroll(upImg[0], {
                            zoom : true,
                            scrollX : true,
                            scrollY : true,
                            mouseWheel : true,
                            bounce : false,
                            wheelAction : 'zoom'
                        });

                        if (btn.hasClass("btn-old")) {
                            ajaxFileUpload("image_btn1", "#image1");
                            _old.img = img;
                            _old.scroll = scroll;
                            _old.ratio = ratio;
                        }
                        if (btn.hasClass("btn-new")) {
                            ajaxFileUpload("image_btn2", "#image2");
                            _new.img = img;
                            _new.scroll = scroll;
                            _new.ratio = ratio;
                        }

                        setTimeout(function() {
                            upImg.removeClass("loading").find("img").css("opacity", 1);
                        }, 1000);
                    }
                }
            });

            $(".submit").on(
                "click",
                function() {
                    var jsonResult = {
                        "image1" : $("#image1").val(),
                        "image2" : $("#image2").val(),
                        "text3" : $("#text3").val(),
                        "template_id":$("#template_id").val(),
                        "emp_no":$("#emp_no").val()
                    };

                    $.ajax({
                        type: 'POST',
                        url: '/xdb/web/sharing!sharing.do',
                        data: {"jsonStr" : JSON.stringify(jsonResult)},
                        success: function(date){
                            alert(date.msg);
                            window.location.href="/xdb/web/sharing!sharingDetail.do?sharingId=".concat(date.msg);
                        },
                        dataType: "json"
                    });
                    return;
                    if (!_old.img) {
                        alert("请上传以前照片");
                        return false;
                    }
                    if (!_new.img) {
                        alert("请上传现在照片");
                        return false;
                    }
                    if ($.trim(_txt.val()) == "") {
                        alert("请输入描述");
                        return false;
                    }

                    var oldImg = imageData(_old);
                    var newImg = imageData(_new);

                    alert(oldImg.substring(0, 50));
                    alert(newImg.substring(0, 50));
                });

            function imageData(obj) {
                obj.scroll.enabled = false;
                var canvas = document.createElement('canvas');

                canvas.width = _w;
                canvas.height = _h;
                var ctx = canvas.getContext('2d');

                var w = _w / obj.scroll.scale / obj.ratio;
                var h = _h / obj.scroll.scale / obj.ratio;
                var x = Math.abs(obj.scroll.x) / obj.scroll.scale / obj.ratio;
                var y = Math.abs(obj.scroll.y) / obj.scroll.scale / obj.ratio;

                ctx.drawImage(obj.img, x, y, w, h, 0, 0, _w, _h);
                return canvas.toDataURL();
            }

            function ajaxFileUpload(image, image_) {
                $.ajaxFileUpload({
                    url : '<%=basePath%>file/uploadFiles.xhtml',// servlet请求路径
                    secureuri : false,
                    fileElementId : image,// 上传控件的id
                    dataType : 'text',
                    success : function(data, status) {
                        $(image_).val(data.msg);
                    },
                    error : function(data, status, e) {
                        alert('上传出错');
                    }
                });

                return false;

            }
        });
	</script>
</body>
</html>
