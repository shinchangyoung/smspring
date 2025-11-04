<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    // ai4 페이지의 스크립트 로직을 담고 있는 객체
    let ai4 = {
        // 페이지 초기화 함수
        init:function(){
            // id가 'send'인 버튼을 클릭했을 때 send 함수를 호출하도록 이벤트 리스너를 등록
            $('#send').click(()=>{
                this.send();
            });
            // id가 'spinner'인 로딩 아이콘을 처음에는 보이지 않도록 설정
            $('#spinner').css('visibility','hidden');
        },
        // 사용자 질문을 서버로 보내고 응답을 받아 처리하는 비동기 함수
        send: async function(){
            // 로딩 스피너를 화면에 표시
            $('#spinner').css('visibility','visible');

            // id가 'question'인 textarea에서 사용자가 입력한 질문 내용을 가져옴
            let question = $('#question').val();
            // 사용자의 질문을 화면에 표시할 HTML 형식을 생성
            let qForm = `
            <div class="media border p-3">
              <img src="/image/user.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">
              <div class="media-body">
                <h6>John Doe</h6>
                <p>`+question+`</p>
              </div>
            </div>
    `;
            // 결과(result) 영역의 맨 위에 사용자의 질문 UI를 추가
            $('#result').prepend(qForm);

            // '/ai1/few-shot-prompt' 주소로 fetch API를 사용하여 서버에 요청을 보냄
            const response = await fetch('/ai1/few-shot-prompt', {
                method: "post", // HTTP 요청 방식은 POST
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded', // 요청 본문의 타입
                    'Accept': 'application/x-ndjson' // 서버로부터 라인으로 구분된 JSON 형태의 응답을 기대함
                },
                body: new URLSearchParams({ question }) // 요청 본문에 질문 내용을 담아 보냄
            });

            // AI의 응답을 표시할 UI 영역을 만들고, 해당 영역의 고유 ID를 받아옴
            let uuid = this.makeUi("result");

            // 서버로부터 받은 응답을 텍스트 형태로 읽어옴
            const jsonString = await response.text();
            // 받은 텍스트(JSON 문자열)를 실제 자바스크립트 객체로 변환
            const jsonObject = JSON.parse(jsonString);
            // 자바스크립트 객체를 사람이 보기 좋은 형태의 JSON 문자열로 변환 (들여쓰기 2칸 적용)
            const prettyJson = JSON.stringify(jsonObject, null, 2);
            // AI 응답 영역에 보기 좋게 변환된 JSON 문자열을 HTML로 삽입
            $('#'+uuid).html(prettyJson)

            // 로딩 스피너를 다시 숨김
            $('#spinner').css('visibility','hidden');

        },
        // AI의 응답을 표시할 HTML 구조를 생성하는 함수
        makeUi:function(target){
            // ID로 사용할 수 있는 고유한 문자열(UUID)을 생성
            let uuid = "id-" + crypto.randomUUID();

            // AI 응답을 표시할 HTML 형식을 생성. 응답 내용은 id가 uuid인 <pre> 태그 안에 표시될 예정
            let aForm = `
          <div class="media border p-3">
            <div class="media-body">
              <h6>GPT4 </h6>
              <p><pre id="`+uuid+`"></pre></p>
            </div>
            <img src="/image/assistant.png" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
          </div>
    `;
            // target으로 지정된 요소(예: 'result' div)의 맨 위에 생성된 HTML을 추가
            $('#'+target).prepend(aForm);
            // 생성된 <pre> 태그의 고유 ID를 반환하여, send 함수에서 이 ID를 통해 내용을 채울 수 있도록 함
            return uuid;
        }

    }

    // 웹 페이지의 모든 요소가 로드된 후(document ready)에 ai4.init 함수를 실행
    $(()=>{
        ai4.init();
    });

</script>


<div class="col-sm-10">
    <h2>Spring AI 4 Few shot Prompt</h2>
    <div class="row">
        <div class="col-sm-8">
            <textarea id="question" class="form-control">큰 피자 하나, 절반은 치즈랑 모짜렐라로, 나머지 절반은 토마토 소스랑 햄, 파인애플로 주세요.</textarea>
        </div>
        <div class="col-sm-2">
            <button type="button" class="btn btn-primary" id="send">Send</button>
        </div>
        <div class="col-sm-2">
            <button class="btn btn-primary" disabled >
                <span class="spinner-border spinner-border-sm" id="spinner"></span>
                Loading..
            </button>
        </div>
    </div>


    <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 500px;">

    </div>

</div>