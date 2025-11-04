<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    // ai4 페이지의 전체 스크립트 로직을 담고 있는 객체
    let ai4 = {
        /**
         * 페이지가 처음 로드될 때 실행되는 초기화 함수입니다.
         * 'Send' 버튼에 클릭 이벤트를 연결하고, 로딩 스피너를 숨깁니다.
         */
        init:function(){
            // id가 'send'인 버튼을 클릭하면 send 함수를 호출하도록 설정
            $('#send').click(()=>{
                this.send();
            });
            // 페이지 로딩 시 스피너(로딩 아이콘)를 보이지 않게 함
            $('#spinner').css('visibility','hidden');
        },

        /**
         * 'Send' 버튼을 클릭했을 때 실행되는 핵심 함수입니다.
         * 사용자가 입력한 텍스트를 서버로 보내 이미지를 생성하고, 결과를 화면에 표시합니다.
         */
        send: async function(){
            // 스피너를 보여주어 사용자에게 작업이 진행 중임을 알림
            $('#spinner').css('visibility','visible');

            // id가 'question'인 textarea에서 사용자가 입력한 텍스트를 가져옴
            let question = $('#question').val();

            // fetch API를 사용하여 서버의 '/ai3/image-generate' 주소로 비동기 요청을 보냄
            const response = await fetch('/ai3/image-generate', {
                method: "post", // HTTP 요청 방식은 POST
                headers: {
                    // 서버에 보내는 데이터의 형식을 명시
                    'Content-Type': 'application/x-www-form-urlencoded',
                    // 서버로부터 받고자 하는 데이터의 형식을 명시 (현재 코드에서는 실제 사용되지 않음)
                    'Accept': 'application/x-ndjson'
                },
                // 'question'이라는 이름으로 사용자의 텍스트를 본문에 담아 전송
                body: new URLSearchParams({ question })
            });

            // 서버로부터 받은 응답을 텍스트 형태로 읽어옴 (Base64 인코딩된 이미지 데이터)
            const b64Json = await response.text();

            // 서버 응답에 "Error"라는 문자열이 포함되어 있는지 확인하여 성공/실패를 구분
            if (!b64Json.includes("Error")) {
                // --- 이미지 생성 성공 시 ---

                // Base64 데이터 앞에 'data:image/png;base64,'를 붙여 완전한 이미지 데이터 URL을 만듦
                const base64Src = "data:image/png;base64," + b64Json;
                console.log("---------------------------");
                console.log(base64Src);

                // id가 'generatedImage'인 <img> 태그를 찾아 src 속성을 방금 만든 데이터 URL로 설정
                const generatedImage = document.getElementById("generatedImage");
                generatedImage.src = base64Src;

                // --- 생성된 이미지 다운로드 링크 만들기 ---
                const alink = document.createElement('a'); // <a> 태그 동적 생성
                alink.innerHTML = "Download"; // 링크 텍스트 설정
                alink.href = base64Src; // 다운로드할 데이터는 이미지 데이터 URL
                alink.download = "output-"+new Date().getTime()+".png"; // 다운로드될 파일 이름 설정

                // id가 'result'인 div의 맨 앞에 다운로드 링크를 추가
                $('#result').prepend(alink);

            } else {
                // --- 이미지 생성 실패 시 ---
                // 서버로부터 받은 에러 메시지를 경고창으로 사용자에게 보여줌
                alert(b64Json);
            }

            // 이미지 표시 작업이 끝나면 스피너를 다시 숨김
            $('#spinner').css('visibility','hidden');
        }
    }

    // jQuery의 document.ready 단축 표현
    // HTML 문서가 모두 로드된 후, ai4.init() 함수를 실행하여 스크립트를 초기화함
    $(()=>{
        ai4.init();
    });

</script>


<div class="col-sm-10">
    <h2>Spring AI 4</h2>
    <div class="row">
        <div class="col-sm-8">
            <textarea id="question" class="form-control" placeholder="만들고자 하는 사진을 설명 하세요"></textarea>
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


    <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 1000px;">
        <img id="generatedImage" src="/image/assistant.png" class="img-fluid" alt="Generated Image" />
    </div>

</div>
