package edu.sm.app.dto;

import lombok.Data;

@Data
public class StudyPlan {
    private int id;
    private String title;
    private String start;
    private String end;
    private String type = "plan"; // 이벤트 타입을 구분하기 위한 필드
}
