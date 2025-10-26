<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

    let ai2center = {
        init:function(){
            this.display();
        },
        display:function(){
            let calendarEl = document.getElementById('calendar');
            let calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'UTC',
                initialView: 'dayGridMonth',
                editable: true,
                selectable: true,

                // 1. 여러 이벤트 소스 통합
                eventSources: [
                    {
                        url: '/api/events', // 직접 추가한 일반 일정
                        color: '#3788d8',   // 파란색 계열
                        textColor: 'white'
                    },
                    {
                        url: '/api/study-plans', // AI가 생성한 스터디 플랜
                        color: '#28a745',   // 녹색 계열
                        textColor: 'white'
                    }
                ],

                // 2. 일정 생성 (기존과 동일)
                select: function(info) {
                    let title = prompt('일정 제목을 입력하세요:');
                    if (title) {
                        $.ajax({
                            url: '/api/events',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                title: title,
                                start: info.startStr,
                                end: info.endStr
                            }),
                            success: function() {
                                calendar.refetchEvents();
                            }
                        });
                    }
                },

                // 3. 이벤트 클릭 핸들러 수정
                eventClick: function(info) {
                    // 이벤트 타입을 확인 (DTO에 추가한 type 필드 사용)
                    if (info.event.extendedProps.type === 'plan') {
                        // AI 스터디 플랜일 경우, 수정/삭제를 막고 알림만 표시
                        alert("AI가 생성한 스터디 플랜입니다.\n제목: " + info.event.title);
                        return; // 여기서 함수 종료
                    }

                    // 일반 일정일 경우, 기존의 수정/삭제 로직 수행
                    if (confirm("'" + info.event.title + "' 일정을 삭제하시겠습니까?")) {
                        $.ajax({
                            url: '/api/events/' + info.event.id,
                            type: 'DELETE',
                            success: function() {
                                alert('일정이 삭제되었습니다.');
                                calendar.refetchEvents();
                            }
                        });
                    } else {
                        let newTitle = prompt("새로운 일정 제목을 입력하세요:", info.event.title);
                        if (newTitle && newTitle !== info.event.title) {
                            $.ajax({
                                url: '/api/events/' + info.event.id,
                                type: 'PUT',
                                contentType: 'application/json',
                                data: JSON.stringify({
                                    title: newTitle,
                                    start: info.event.startStr,
                                    end: info.event.endStr
                                }),
                                success: function() {
                                    alert('일정이 수정되었습니다.');
                                    calendar.refetchEvents();
                                }
                            });
                        }
                    }
                }
            });
            calendar.render();
        }
    }
    $(()=> {
        ai2center.init();
    });

</script>
<div class="col-sm-10">
    <h2>AI2 Structured Chat System</h2>
    <div id='calendar'></div>

</div>