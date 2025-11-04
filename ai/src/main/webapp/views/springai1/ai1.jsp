<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    // AI 채팅 관련 기능을 관리하는 JavaScript 객체
    let ai1 = {
        /**
         * 페이지 로딩 시 초기화를 담당하는 함수.
         * 'Send' 버튼에 클릭 이벤트를 연결하고, 로딩 스피너를 숨깁니다.
         */
        init:function(){
            $('#send').click(()=>{
                this.send();
            });
            // 페이지가 처음 로드될 때 로딩 스피너를 보이지 않게 처리
            $('#spinner').css('visibility','hidden');
        },
        /**
         * 사용자가 입력한 질문을 서버로 전송하는 함수.
         */
        send: function(){
            // 1. 서버에 요청을 보내는 동안 로딩 스피너를 화면에 표시
            $('#spinner').css('visibility','visible');

            // 2. 사용자가 입력한 질문 텍스트를 가져옴
            let question = $('#question').val();
            // 3. 사용자의 질문을 화면에 표시할 HTML 폼을 생성
            let qForm = `
            <div class="media border p-3">
              <img src="/image/user.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">
              <div class="media-body">
                <h6>John Doe</h6>
                <p>`+question+`</p>
              </div>
            </div>
    `;
            // 4. 생성된 질문 폼을 #result 영역의 맨 위에 추가
            $('#result').prepend(qForm);

            // 5. AJAX를 사용해 서버의 '/ai1/chat-model' API로 비동기 요청을 보냄
            $.ajax({
                url:'/ai1/chat-model',
                data:{'question':question},
                // 6. 요청이 성공하면, 서버로부터 받은 결과(result)를 display 함수로 전달
                success:(result)=>{
                    this.display(result)

                }
            });
        },
        /**
         * 서버로부터 받은 AI의 답변을 화면에 표시하는 함수.
         * @param {string} result - 서버에서 전달받은 AI의 응답 메시지
         */
        display:function(result){
            // 1. AI의 답변을 받았으므로 로딩 스피너를 다시 숨김
            $('#spinner').css('visibility','hidden');

            console.log(result);
            // 2. AI의 답변을 화면에 표시할 HTML 폼을 생성. <pre> 태그를 사용해 줄바꿈 등 서식을 유지.
            let aForm = `
          <div class="media border p-3">
            <div class="media-body">
              <h6>GPT4 </h6>
              <p><pre>`+result+`</pre></p>
            </div>a
            <img src="/image/assistant.png" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
          </div>
    `;
            // 3. 생성된 답변 폼을 #result 영역의 맨 위에 추가
            $('#result').prepend(aForm);
        }

    }

    // HTML 문서가 모두 로드된 후 ai1.init() 함수를 실행하여 스크립트를 초기화
    $(()=>{
        ai1.init();
    });

</script>


<!-- 메인 콘텐츠 영역 -->
<div class="col-sm-10">
    <h2>Spring AI 1 Chat Model</h2>
    <div class="row">
        <!-- 질문 입력 영역 -->
        <div class="col-sm-8">
            <textarea id="question" class="form-control">Spring AI에 대해 300자 이내로 설명해줘</textarea>
        </div>
        <!-- 전송 버튼 -->
        <div class="col-sm-2">
            <button type="button" class="btn btn-primary" id="send">Send</button>
        </div>
        <!-- 로딩 상태 표시 영역 -->
        <div class="col-sm-2">
            <button class="btn btn-primary" disabled >
                <span class="spinner-border spinner-border-sm" id="spinner"></span>
                Loading..
            </button>
        </div>
    </div>

    <!-- 질문과 답변이 표시될 결과 창 -->
    <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 300px;">

    </div>

</div>