<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    let ai4 = {
        runningTotal: 0,
        init:function(){
            $('#send').click(()=>{
                this.send();
            });
            $('#spinner').css('visibility','hidden');
        },
        send: async function(){
            $('#spinner').css('visibility','visible');

            let question = $('#question').val();
            let qForm = `
            <div class="media border p-3">
              <img src="/image/user.png" alt="John Doe" class="mr-3 mt-3 rounded-circle" style="width:60px;">
              <div class="media-body">
                <h6>John Doe</h6>
                <p>`+question+`</p>
              </div>
            </div>
    `;
            $('#result').prepend(qForm);

            // 모든 입력을 AI에게 전송
            const response = await fetch('/ai2/few-shop-prompt', {
                method: "post",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/x-ndjson' // 라인으로 구분된 청크 텍스트
                },
                body: new URLSearchParams({ question })
            });

            let uuid = this.makeUi("result");
            const rawJsonString = await response.text();
            const cleanedJsonString = rawJsonString.replace(/^```json\n|\n```$/g, '');
            const orders = JSON.parse(cleanedJsonString);

            // AI 응답 분석
            if (orders && orders.length > 0 && orders[0].action === 'show_menu') {
                // 메뉴판 조회 요청일 경우
                const menuResponse = await fetch('/ai2/menu', {
                    method: "post", // 컨트롤러 메소드가 GET/POST 모두 허용하므로 그대로 둠
                    headers: {
                        'Accept': 'text/html'
                    }
                });
                const menuHtml = await menuResponse.text();
                $('#'+uuid).html(menuHtml);
                $('#spinner').css('visibility','hidden');
                return; // 작업 종료
            }

            // --- 기존 주문 처리 로직 ---
            let totalHtml = '';
            let totalPrice = 0;

            orders.forEach(order => {
                if (order.error && order.error === "NOT_ON_MENU") {
                    totalHtml += `<p><strong>없는 메뉴입니다.</strong></p>`;
                } else if (order.menuName) {
                    const itemPrice = order.price * order.quantity;
                    totalPrice += itemPrice;

                    let toppings = (order.toppings || []).join(', ');
                    if (toppings === '') toppings = '없음';

                    let sideDishes = (order.sideDishes || []).join(', ');
                    if (sideDishes === '') sideDishes = '없음';

                    totalHtml += `
            <div class="media border p-3">
              <img src="/image/`+order.imageName+`" alt="Menu" class="mr-3 mt-3" style="width:100px;">
              <div class="media-body">
                <h5>`+order.menuName+`</h5>
                <p><strong>수량:</strong> `+order.quantity+`</p>
                <p><strong>가격:</strong> `+itemPrice.toLocaleString()+`원</p>
                <p><strong>맛 강도:</strong> `+order.tasteStrength+`</p>
                <p><strong>토핑:</strong> `+toppings+`</p>
                <p><strong>사이드 메뉴:</strong> `+sideDishes+`</p>
              </div>
            </div>
          `;
                }
            });

            if(totalPrice > 0) {
                const cumulative = this.runningTotal + totalPrice;
                totalHtml += `
          <div class="text-right p-3">
            <h4><span class="text-muted">총 합계: </span><strong id="cumulative-total">`+cumulative.toLocaleString()+`원</strong></h4>
          </div>
        `;
            }

            $('#'+uuid).html(totalHtml);
            this.runningTotal += totalPrice;
            $('#spinner').css('visibility','hidden');
        },
        makeUi:function(target){
            let uuid = "id-" + crypto.randomUUID();
            let aForm = `
          <div class="media border p-3">
            <div class="media-body">
              <h6>GPT4 </h6>
              <p><div id="`+uuid+`"></div></p>
            </div>
            <img src="/image/assistant.png" alt="John Doe" class="ml-3 mt-3 rounded-circle" style="width:60px;">
          </div>
    `;
            $('#'+target).prepend(aForm);
            return uuid;
        }
    }

    $(()=>{
        ai4.init();
    });
</script>

<div class="col-sm-10">
    <h2>DB 식당</h2>
    <div class="row">
        <div class="col-sm-8">
            <textarea id="question" class="form-control">메뉴판 보여줘</textarea>
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

    <div id="result" class="container p-3 my-3 border" style="overflow: auto;width:auto;height: 600px;">
    </div>
</div>