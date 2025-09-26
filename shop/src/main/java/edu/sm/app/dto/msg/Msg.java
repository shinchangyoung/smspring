package edu.sm.app.dto.msg;

import lombok.*;

/**
 * 웹소켓 채팅 메시지를 주고받기 위한 데이터 전송 객체(DTO)입니다.
 * Lombok 라이브러리를 사용하여 getter, setter, 생성자 등을 자동으로 생성합니다.
 */
@AllArgsConstructor // 모든 필드를 인자로 받는 생성자를 자동으로 생성합니다. (e.g., new Msg("id1", "id2", "hello"))
@NoArgsConstructor  // 파라미터가 없는 기본 생성자를 자동으로 생성합니다. (e.g., new Msg())
@ToString         // 객체의 필드 값을 문자열로 표현해주는 toString() 메소드를 자동으로 생성합니다.
@Getter           // 각 필드의 값을 가져올 수 있는 getter 메소드(getSendid(), getReceiveid() 등)를 자동으로 생성합니다.
@Setter           // 각 필드의 값을 설정할 수 있는 setter 메소드(setSendid(), setReceiveid() 등)를 자동으로 생성합니다.
public class Msg {

    /**
     * 메시지를 보내는 사람의 아이디입니다.
     */
    private String sendid;

    private String sendname;

    /**
     * 메시지를 받는 사람의 아이디입니다. (귓속말 기능에 사용됩니다)
     */
    private String receiveid;

    /**
     * 전송될 메시지의 내용입니다.
     */
    private String content1;

}
