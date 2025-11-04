<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  #to {
    width: 400px;
    height: 200px;
    overflow: auto;
    border: 2px solid green;
  }
</style>
<script>
  // 'chat2'라는 이름으로 채팅 관련 모든 기능을 담고 있는 JavaScript 객체
  chat2 = {
    // 현재 사용자의 ID를 저장할 변수
    id:'',
    /**
     * 페이지가 로드될 때 채팅 기능을 초기화하는 함수
     */
    init:function(){
      // 1. JSP 세션에 저장된 사용자의 ID를 가져와서 id 변수에 저장
      this.id = '${sessionScope.cust.custId}';
      // 2. 웹소켓 서버에 연결을 시도
      this.connect();
      // 3. 'Send' 버튼(#sendto)을 클릭했을 때 실행될 이벤트를 설정
      $('#sendto').click(()=>{
        // 4. 보낼 메시지를 JSON 형태의 문자열로 만듦
        var msg = JSON.stringify({
          'sendid' : this.id,
          'receiveid' : $('#target').val(),
          'content1' : $('#totext').val()
        });
        // 5. STOMP 클라이언트를 사용해 '/adminreceiveto' 경로로 메시지를 전송
        //    서버의 @MessageMapping("/adminreceiveto")가 이 메시지를 받게 됨
        this.stompClient.send('/adminreceiveto', {}, msg);
      });
    },
    /**
     * SockJS와 STOMP를 사용해 웹소켓 서버에 연결하는 함수
     */
    connect:function(){
      let sid = this.id;
      // 1. SockJS를 사용해 웹소켓 서버의 접속 주소('/adminchat')로 연결을 시도
      let socket = new SockJS('${websocketurl}adminchat');
      // 2. STOMP 프로토콜을 사용하기 위해 SockJS 연결을 감쌈
      this.stompClient = Stomp.over(socket);
      // 3. 화면의 상태 표시를 'Connected'로 변경
      this.setConnected(true);
      // 4. STOMP 프로토콜을 사용해 서버에 최종 연결
      //    참고: 이 콜백 함수 안에서의 'this'는 chat2 객체가 아닐 수 있어, 외부 변수(sid)를 사용합니다.
      this.stompClient.connect({}, function(frame) {
        console.log('Connected: ' + frame);

        // 5. 서버로부터 오는 메시지를 받기 위해 개인화된 경로를 "구독(subscribe)"
        //    '/adminsend/to/사용자ID' 경로로 오는 메시지만 수신하게 됨
        chat2.stompClient.subscribe('/adminsend/to/'+sid, function(msg) {
          // 6. 메시지를 받으면, JSON 문자열을 객체로 변환하여 화면에 표시
          $("#to").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1
                  + "</h4>");
        });
      });
    },
    /**
     * 화면에 표시되는 연결 상태를 업데이트하는 함수
     * @param {boolean} connected - 연결 상태 (true 또는 false)
     */
    setConnected:function(connected){
      if (connected) {
        $("#status").text("Connected");
      } else {
        $("#status").text("Disconnected");
      }
    }
  }

  // HTML 문서가 모두 로드된 후, chat2 객체의 init 함수를 호출하여 채팅 기능을 시작
  $(()=>{
    chat2.init();
  });
</script>

<div class="col-sm-10">
  <h2>Chat1 Center</h2>
  <div class="card-body">
    <div class="table-responsive">
      <div class="col-sm-5">
        <!-- 현재 로그인한 사용자 ID 표시 -->
        <h1 id="user_id">User: ${sessionScope.cust.custId}</h1>
        <!-- 웹소켓 연결 상태 표시 -->
        <H1 id="status">Status</H1>

        <h3>To</h3>
        <!-- 메시지를 보낼 대상 입력 (기본값: admin) -->
        <input type="text" id="target" value="admin" class="form-control mb-2">
        <!-- 보낼 메시지 내용 입력 -->
        <input type="text" id="totext" class="form-control mb-2"><button id="sendto" class="btn btn-primary">Send</button>
        <!-- 받은 메시지가 표시될 영역 -->
        <div id="to"></div>

      </div>
    </div>

  </div>
</div>