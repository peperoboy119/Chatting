<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
	var lastID = 0;
	
	function submitFunction() {
		var chatName = $('#chatName').val();
		var chatContent = $('#chatContent').val();

		// ajax를 이용해서 서버와 통신
		$.ajax({
			type : "POST",
			url : "./chatSubmitServlet",
			data : {
				chatName : encodeURIComponent(chatName),
				chatContent : encodeURIComponent(chatContent)
			},
			success : function(result) {
				if (result == 1) {
					autoClosingAlert('#successMessage', 2000);

				} else if (result == 0) {
					autoClosinfgAlert('#dangerMessage', 2000);
				} else {
					
					autoClosingAlert('#warningMessage', 2000);
				}
			}
		});
		$('#chatContent').val('');
	}

	function autoClosingAlert(selector, delay) {
		var alert = $(selector).alert();
		alert.show();
		window.setTimeout(function() {
			alert.hide();
		}, delay);
	}

	function chatListFunction(type) {
		$.ajax({
			type : "POST",
			url : "./chatListServlet",
			data : {
				listType : type,
				//listType을 서버로 보내고 listType에 맞는 getToday()를 이용해서 json형태로 담고 클라이언트에게 돌려주면	
			},
			success : function(data) {	// 여기서 받아서 json형태로 파싱을하고 각각의 모든 배열의 담긴 값을 차례대로 출력한다
				if(data == "") return;
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value,result[i][2].value);
				}
				lastID = Number(parsed.last);
				
			}
		});
	}

	function addChat(chatName, chatContent, chatTime) {
		$('#chatList').append('<div class="row">'
								+ '<div class="col-lg-12">'
								+ '<div class="media">'
								+ '<a class="pull-left" href="#">'
								+ '<img class="media-object img-circle" src="images/icon.jpg" alt="">'
								+ '</a>' 
								+ '<div class="media-body">'
								+ '<h4 class="media-heading">'
								+ chatName
								+ '<span class="small pull-right">'
								+ chatTime
								+ '</span>' + '</h4>' + '<p>' 
								+ chatContent
								+ '</p>' + '</div>' + '</div>' + '</div>'
								+ '</div>' + 
								'<hr>');
		
		$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
	}
	
	function getInfiniteChat(){
		setInterval(function(){
			chatListFunction(lastID);
		}, 5000);
	}
</script>
</head>
<body>
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>MY-CAFE 채팅방
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget"
								style="overflow-y: auto; width: auto; height: 300px;"></div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName"
											class="form-control" placeholder="이름" maxlength="20">
									</div>
								</div>
							</div>
							<div class="row" style="height: 90px;">
								<div class="form-group col-xs-10">
									<textarea style="height: 80px;" id="chatContent"
										class="form-control" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
								</div>

								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right"
										onclick="submitFunction();">전송</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<div class="alert alert-success" id="successMessage"
			style="display: none;">
			<strong>메세지 전송 완료</strong>
		</div>

		<div class="alert alert-danger" id="dangerMessage"
			style="display: none;">
			<strong>이름하고 내용을 입력하세요</strong>
		</div>

		<div class="alert alert-warnin" id="warninMessage"
			style="display: none;">
			<strong>데이터베이스 오류</strong>

		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function(){
			//chatListFunction('ten');
			chatListFunction('today');
			getInfiniteChat();
		});
	</script>

</body>
</html>