<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    // 캘린더 및 플래너 로직 통합 관리
    let ai2center = {
        calendar: null, // 캘린더 인스턴스를 저장할 변수
        init: function() {
            this.display();
        },
        display: function() {
            let calendarEl = document.getElementById('calendar');
            this.calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'UTC',
                initialView: 'dayGridMonth',
                editable: true,
                selectable: true,
                eventSources: [
                    { url: '/api/events', color: '#3788d8', textColor: 'white' },
                    { url: '/api/study-plans', color: '#28a745', textColor: 'white' }
                ],
                select: function(info) {
                    let title = prompt('일정 제목을 입력하세요:');
                    if (title) {
                        $.ajax({
                            url: '/api/events',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({ title: title, start: info.startStr, end: info.endStr }),
                            success: () => this.calendar.refetchEvents()
                        });
                    }
                }.bind(this),
                eventClick: function(info) {
                    // 1. 이벤트 타입에 따라 올바른 API 경로를 동적으로 설정
                    const eventType = info.event.extendedProps.type;
                    const baseUrl = (eventType === 'plan') ? '/api/study-plans/' : '/api/events/';
                    const apiUrl = baseUrl + info.event.id;

                    // 2. 삭제 로직 (공통)
                    if (confirm("'" + info.event.title + "' 일정을 삭제하시겠습니까?")) {
                        $.ajax({
                            url: apiUrl,
                            type: 'DELETE',
                            success: () => {
                                alert('일정이 삭제되었습니다.');
                                this.calendar.refetchEvents();
                            },
                            error: () => alert('삭제 중 오류가 발생했습니다.')
                        });
                    } else {
                        // 3. 수정 로직 (공통)
                        let newTitle = prompt("새로운 일정 제목을 입력하세요:", info.event.title);
                        if (newTitle && newTitle !== info.event.title) {
                            $.ajax({
                                url: apiUrl,
                                type: 'PUT',
                                contentType: 'application/json',
                                data: JSON.stringify({ title: newTitle, start: info.event.startStr, end: info.event.endStr }),
                                success: () => {
                                    alert('일정이 수정되었습니다.');
                                    this.calendar.refetchEvents();
                                },
                                error: () => alert('수정 중 오류가 발생했습니다.')
                            });
                        }
                    }
                }.bind(this)
            });
            this.calendar.render();
        }
    };

    // 페이지 로드 시 실행
    $(() => {
        ai2center.init();
        $('#generate-plan-btn').click(() => {
            const prompt = $('#study-prompt').val();
            if (!prompt) {
                alert('공부할 내용을 입력해주세요.');
                return;
            }
            $('#generate-plan-btn').text('생성 중...').prop('disabled', true);
            $.ajax({
                url: '/api/study-planner',
                type: 'POST',
                contentType: 'text/plain; charset=utf-8',
                data: prompt,
                success: (response) => {
                    alert(response);
                    if (ai2center.calendar) {
                        ai2center.calendar.refetchEvents();
                    }
                },
                error: () => alert('계획 생성 중 오류가 발생했습니다. AI 서비스 상태 또는 서버 로그를 확인해주세요.'),
                complete: () => $('#generate-plan-btn').text('계획 생성').prop('disabled', false)
            });
        });
    });
</script>
<div class="col-10">
<div class="container mt-4">
    <!-- AI 스터디 플래너 UI -->
    <div class="row mb-4">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <h3>AI 스터디 플래너</h3>
                </div>
                <div class="card-body">
                    <p>AI에게 공부할 주제를 알려주면, 학습 계획을 세워 달력에 추가해줍니다.</p>
                    <div class="input-group">
                        <input type="text" id="study-prompt" class="form-control" placeholder="예: 3일 안에 스프링 부트 마스터하기">
                        <div class="input-group-append">
                            <button id="generate-plan-btn" class="btn btn-success">계획 생성</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 캘린더 UI -->
    <div class="row">
        <div class="col-md-10">
            <div class="card">
                <div class="card-header">
                    <h3>캘린더</h3>
                </div>
                <div class="card-body">
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>




