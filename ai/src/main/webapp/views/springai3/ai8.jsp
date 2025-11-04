<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    let ai7 = {
        init: function () {
            this.startQuestion();
            this.previewCamera('video');
            $('#spinner').css('visibility', 'hidden');
        },
        startQuestion: function () {
            // 마이크 초기화
            springai.voice.initMic(this);
            let qForm = `
            <div class="media border p-3">
<!--              <img src="/image/user.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">-->
               <div  class="speakerPulse"
              style="width: 30px; height: 30px;
              background: url('/image/speaker-yellow.png') no-repeat center center / contain;"></div>음성으로 질문하세요
            </div>
    `;
            // 사용자가 음성을 입력할 차례임을 알려주는 UI 추가
            $('#result').prepend(qForm);
        },
        handleVoice: async function (mp3Blob) {
            try {
                //스피너 보여주기
                $('#spinner').css('visibility', 'visible');

                // 1. (추가) 음성을 텍스트로 변환하기 위해 서버에 요청합니다.
                const sttFormData = new FormData();
                sttFormData.append("speech", mp3Blob, 'speech.mp3');
                const sttResponse = await fetch("/ai3/stt", {
                    method: "post",
                    body: sttFormData
                });
                if (!sttResponse.ok) {
                    throw new Error(`STT Error: ${sttResponse.statusText}`);
                }
                const questionText = await sttResponse.text();

                // 2. (추가) 인식된 음성 텍스트를 화면에 표시합니다.
                let qForm = `
                  <div class="media border p-3">
                    <img src="/image/user.png" alt="User" class="mr-3 mt-3 rounded-circle" style="width:60px;">
                    <div class="media-body">
                      <h6>User</h6>
                      <p>${questionText}</p>
                    </div>
                  </div>
                `;
                $('#result').prepend(qForm);

                // 3. 현재 비디오 프레임을 캡처합니다.
                const video = document.getElementById('video');
                const canvas = document.createElement('canvas');
                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                const context = canvas.getContext('2d');
                context.drawImage(video, 0, 0, canvas.width, canvas.height);

                // 4. 캡처된 이미지를 Blob 데이터로 변환합니다.
                const pngBlob = await new Promise(resolve => canvas.toBlob(resolve, 'image/png'));

                // 5. 변환된 텍스트와 이미지 파일을 함께 담을 FormData를 생성합니다.
                const formData = new FormData();
                formData.append('question', questionText); // 음성 대신 텍스트를 보냅니다.
                formData.append('attach', pngBlob, 'frame.png');

                // 6. 기존 이미지 분석 엔드포인트로 텍스트와 이미지를 전송합니다.
                const response = await fetch('/ai3/image-analysis', {
                    method: "post",
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`분석 실패: ${response.statusText}`);
                }

                // 7. AI 답변을 표시할 UI를 만들고, 캡처된 이미지를 보여줍니다.
                let uuid = this.makeUi("result");
                const capturedImageUrl = URL.createObjectURL(pngBlob);
                $('#img-' + uuid).attr('src', capturedImageUrl);

                // 8. AI의 텍스트 답변을 스트림으로 받아 실시간으로 표시합니다.
                const reader = response.body.getReader();
                const decoder = new TextDecoder("utf-8");
                let content = "";
                while (true) {
                    const {value, done} = await reader.read();
                    if (done) break;
                    let chunk = decoder.decode(value);
                    content += chunk;
                    $('#' + uuid).html(content);
                }

            } catch (error) {
                console.error("음성 기반 이미지 분석 중 오류 발생:", error);
                alert("이미지 분석에 실패했습니다. 다시 시도해 주세요.");
            } finally {
                $('#spinner').css('visibility','hidden');
                this.startQuestion(); // 다음 질문 받기 시작
            }
        },
        previewCamera: function (videoId) {
            const video = document.getElementById(videoId);
            //카메라를 활성화하고 <video>에서 보여주기
            navigator.mediaDevices.getUserMedia({video: true})
                .then((stream) => {
                    video.srcObject = stream;
                })
                .catch((error) => {
                    console.error('카메라 접근 에러:', error);
                });
        },
        makeUi: function (target) {
            let uuid = "id-" + crypto.randomUUID();

            let aForm = `
          <div class="media border p-3">
            <div class="media-body">
              <h6>GPT-4 Vision 답변</h6>
              <img id="img-`+uuid+`" src="" class="img-fluid mb-2" alt="캡처된 이미지" style="max-height: 200px;"/>
              <p><pre id="`+uuid+`"></pre></p>
            </div>
            <img src="/image/assistant.png" alt="Assistant" class="ml-3 mt-3 rounded-circle" style="width:60px;">
          </div>
    `;
            $('#' + target).prepend(aForm);
            return uuid;
        }

    }

    $(() => {
        ai7.init();
    });

</script>


<div class="col-sm-10">
    <h2>Spring AI 7</h2>

    <div class="row">
        <div class="col-sm-9">
            <div class="row">
                <div class="col-sm-10">
                    <h4>음성으로 이미지에 대해 질문하세요</h4>
                </div>

                <div class="col-sm-2">
                    <button class="btn btn-primary" disabled>
                        <span class="spinner-border spinner-border-sm" id="spinner"></span>
                        Loading..
                    </button>
                </div>

            </div>
            <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 500px;">

            </div>
        </div>

        <div class="col-sm-3">
            <video id="video" width="320" height="240" autoplay></video>
        </div>

    </div>


</div>