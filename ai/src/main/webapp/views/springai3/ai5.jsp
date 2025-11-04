<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    let ai4 = {
        recordBtn: null,
        descriptionArea: null,
        recognition: null, // 추가

        init:function(){
            this.recordBtn = $('#recordBtn');
            this.descriptionArea = $('#question');

            // 음성 인식 초기화 호출 추가
            this.setupSpeechRecognition();

            $('#send').click(()=>{
                this.send();
            });

            $('#spinner').css('visibility','hidden');
        },

        // displayMessage 함수 추가
        displayMessage: function(message, type) {
            // 간단한 alert나 toast 메시지로 구현
            alert(message);
            // 또는 Bootstrap alert를 사용할 수도 있습니다
        },

        setupSpeechRecognition: function() {
            const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            if (!SpeechRecognition) {
                this.displayMessage("이 브라우저는 음성 인식을 지원하지 않습니다. Chrome 브라우저를 사용해주세요.", "warning");
                this.recordBtn.prop('disabled', true);
                return;
            }

            this.recognition = new SpeechRecognition();
            this.recognition.continuous = false;
            this.recognition.lang = 'ko-KR';

            this.recordBtn.click(() => this.recognition.start());

            this.recognition.onstart = () => {
                this.recordBtn.addClass('recording').text('🎙️');
                this.displayMessage("듣고 있어요...", "info");
            };

            this.recognition.onend = () => {
                this.recordBtn.removeClass('recording').text('🎤');
            };

            this.recognition.onresult = (event) => {
                const transcript = event.results[0][0].transcript;
                this.descriptionArea.val(transcript);
                this.send(); // generateImage() 대신 send() 호출
            };

            this.recognition.onerror = (event) => {
                this.displayMessage(`음성 인식 오류: ${event.error}`, "danger");
            };
        },

        send: async function(){
            $('#spinner').css('visibility','visible');
            let question = $('#question').val();

            const response = await fetch('/ai3/image-generate', {
                method: "post",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/x-ndjson'
                },
                body: new URLSearchParams({ question })
            });

            const b64Json = await response.text();

            if (!b64Json.includes("Error")) {
                const base64Src = "data:image/png;base64," + b64Json;
                const generatedImage = document.getElementById("generatedImage");
                generatedImage.src = base64Src;

                const alink = document.createElement('a');
                alink.innerHTML = "Download";
                alink.href = base64Src;
                alink.download = "output-"+new Date().getTime()+".png";
                $('#result').prepend(alink);
            } else {
                alert(b64Json);
            }

            $('#spinner').css('visibility','hidden');
        }
    }

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
            <button type="button" class="btn btn-danger mr-2" id="recordBtn">🎤</button>
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
