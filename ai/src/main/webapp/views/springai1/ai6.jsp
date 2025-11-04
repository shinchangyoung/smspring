<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    // ai6 JavaScript 객체: AI 관련 기능을 캡슐화합니다.
    let ai6 = {
        // init 함수: 페이지 로딩 시 초기화 작업을 수행합니다.
        init:function(){
            // 'send' 버튼 클릭 시 send 함수를 호출하도록 이벤트 리스너를 등록합니다.
            $('#send').click(()=>{
                this.send();
            });
            // 페이지 로딩 시 스피너(로딩 아이콘)를 숨깁니다.
            $('#spinner').css('visibility','hidden');
        },
        // send 함수: 사용자 요구사항을 서버로 비동기 전송하고 스트리밍 응답을 처리합니다.
        send: async function(){
            // 스피너를 표시하여 사용자에게 로딩 중임을 알립니다.
            $('#spinner').css('visibility','visible');

            // 사용자가 입력한 요구사항 내용을 가져옵니다.
            let question = $('#question').val();
            // 사용자의 질문을 화면에 표시할 HTML 구조를 생성합니다.
            let qForm = `
            <div class="media border p-3">
              <img src="/image/user.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">
              <div class="media-body">
                <h6>John Doe</h6>
                <p>`+question+`</p>
              </div>
            </div>
    `;
            // 생성된 질문 HTML을 'result' div의 맨 앞에 추가합니다.
            $('#result').prepend(qForm);

            // fetch API를 사용하여 서버의 '/ai1/role-assignment'으로 POST 요청을 보냅니다.
            const response = await fetch('/ai1/role-assignment', {
                method: "post",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded', // 요청 본문이 URL 인코딩된 형식임을 나타냅니다.
                    'Accept': 'application/x-ndjson' // 서버로부터 라인으로 구분된 스트리밍 텍스트(NDJSON)를 받기를 기대합니다.
                },
                // 요청 본문에 'requirements' 파라미터를 담아 전송합니다.
                body: new URLSearchParams({ requirements: question })
            });

            // AI의 답변을 표시할 UI 영역을 만들고, 해당 영역의 고유 ID를 반환받습니다.
            let uuid = this.makeUi("result");

            // 서버 응답의 본문(body)을 읽기 위한 ReadableStreamDefaultReader를 가져옵니다.
            const reader = response.body.getReader();
            // 스트림 데이터를 UTF-8 문자열로 디코딩하기 위한 TextDecoder를 생성합니다.
            const decoder = new TextDecoder("utf-8");
            // 디코딩된 텍스트 조각(chunk)을 누적할 변수를 초기화합니다.
            let content = "";
            // 무한 루프를 통해 스트림이 끝날 때까지 데이터를 계속 읽습니다.
            while (true) {
                // 스트림에서 {value, done} 객체를 읽어옵니다. value는 데이터 청크, done은 스트림 종료 여부입니다.
                const {value, done} = await reader.read();
                // 스트림이 끝나면(done이 true이면) 루프를 종료합니다.
                if (done) break;
                // 읽어온 데이터 청크(Uint8Array)를 문자열로 디코딩합니다.
                let chunk = decoder.decode(value);
                // 디코딩된 문자열을 content 변수에 추가합니다.
                content += chunk;
                // (디버깅용) 현재까지 누적된 내용을 콘솔에 출력합니다.
                console.log(content);
                // 고유 ID를 가진 <pre> 태그의 내용을 실시간으로 업데이트하여 스트리밍 효과를 줍니다.
                $('#'+uuid).html(content)
            }
            // 모든 응답을 받고 처리가 완료되면 스피너를 다시 숨깁니다.
            $('#spinner').css('visibility','hidden');

        },
        // makeUi 함수: AI의 답변을 표시할 HTML 구조를 동적으로 생성합니다.
        makeUi:function(target){
            // 답변 영역을 식별하기 위한 고유 ID를 생성합니다. (예: "id-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")
            let uuid = "id-" + crypto.randomUUID();

            // AI 답변을 표시할 HTML 구조를 생성합니다.
            let aForm = `
          <div class="media border p-3">
            <div class="media-body">
              <h6>GPT4 </h6>
              <p><pre id="`+uuid+`"></pre></p>
            </div>
            <img src="/image/assistant.png" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
          </div>
    `;
            // 지정된 대상(target, 여기서는 'result' div)의 맨 앞에 생성된 HTML을 추가합니다.
            $('#'+target).prepend(aForm);
            // 생성된 고유 ID를 반환하여, send 함수에서 이 ID를 가진 요소에 내용을 채울 수 있도록 합니다.
            return uuid;
        }

    }

    // jQuery의 document.ready 함수: HTML 문서가 완전히 로드되고 파싱된 후 내부 코드를 실행합니다.
    $(()=>{
        // ai6 객체의 init 함수를 호출하여 페이지를 초기화합니다.
        ai6.init();
    });

</script>


<!-- 화면 UI 부분 -->
<div class="col-sm-10">
    <h2>Spring AI 6</h2>
    <div class="row">
        <div class="col-sm-8">
            <!-- 요구사항 입력 텍스트 영역 -->
            <textarea id="question" class="form-control">저는 암스테르담에 있으며, 오직 박물관만 방문하고 싶습니다.</textarea>
        </div>
        <div class="col-sm-2">
            <!-- 요구사항 전송 버튼 -->
            <button type="button" class="btn btn-primary" id="send">Send</button>
        </div>
        <div class="col-sm-2">
            <!-- 로딩 중 상태를 표시하는 스피너 버튼 (초기에는 비활성화) -->
            <button class="btn btn-primary" disabled >
                <span class="spinner-border spinner-border-sm" id="spinner"></span>
                Loading..
            </button>
        </div>
    </div>


    <!-- 질문과 AI의 답변이 표시될 결과 컨테이너 -->
    <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 300px;">

    </div>

</div>