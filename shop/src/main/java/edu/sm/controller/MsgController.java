package edu.sm.controller;


import edu.sm.app.msg.Msg;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

/**
 * WebSocket 메시지 처리를 담당하는 컨트롤러입니다.
 * 클라이언트로부터 오는 메시지를 받아 적절한 채널(Topic)로 다시 전송하는 역할을 합니다.
 */
@Slf4j // Lombok 어노테이션으로, 로그를 쉽게 사용할 수 있게 해줍니다. (e.g., log.info())
@Controller
public class MsgController {

    // SimpMessagingTemplate는 특정 브로커(topic)로 메시지를 보낼 때 사용합니다.
    @Autowired
    SimpMessagingTemplate template;

    /**
     * 전체 채팅 메시지를 처리합니다.
     * 클라이언트가 "/receiveall" 경로로 메시지를 보내면 이 메소드가 실행됩니다.
     * @param msg 클라이언트로부터 받은 메시지 객체 (JSON 형태가 Msg 객체로 자동 변환됩니다)
     * @param headerAccessor 메시지에 대한 추가 정보(세션 등)를 담고 있는 객체
     */
    @MessageMapping("/receiveall") // 클라이언트에서 "/receiveall"으로 메시지를 보내면 이 메소드가 받습니다.
    public void receiveall(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        // 받은 메시지를 콘솔에 출력합니다.
        System.out.println(msg);
        // "/send" 토픽을 구독하고 있는 모든 클라이언트에게 메시지를 전송합니다.
        template.convertAndSend("/send", msg);
    }

    /**
     * '나에게만' 보내는 메시지를 처리합니다. (주로 챗봇이나 시스템 알림에 사용될 수 있습니다)
     * 클라이언트가 "/receiveme" 경로로 메시지를 보내면 이 메소드가 실행됩니다.
     * @param msg 클라이언트로부터 받은 메시지 객체
     * @param headerAccessor 메시지에 대한 추가 정보
     */
    @MessageMapping("/receiveme") // 클라이언트에서 "/receiveme"으로 메시지를 보내면 이 메소드가 받습니다.
    public void receiveme(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        // 받은 메시지를 콘솔에 출력합니다.
        System.out.println(msg);

        // 메시지를 보낸 사람의 아이디를 가져옵니다.
        String id = msg.getSendid();
        // "/send/보낸사람ID" 형태의 개인 토픽으로 메시지를 전송합니다.
        // 이렇게 하면 메시지를 보낸 사람만 이 메시지를 받을 수 있습니다.
        template.convertAndSend("/send/" + id, msg);
    }

    /**
     * 특정 사용자에게 귓속말(DM)을 보내는 메시지를 처리합니다.
     * 클라이언트가 "/receiveto" 경로로 메시지를 보내면 이 메소드가 실행됩니다.
     * @param msg 클라이언트로부터 받은 메시지 객체 (sendid, receiveid, content1 포함)
     * @param headerAccessor 메시지에 대한 추가 정보
     */
    @MessageMapping("/receiveto") // 클라이언트에서 "/receiveto"로 메시지를 보내면 이 메소드가 받습니다.
    public void receiveto(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        // 메시지를 보낸 사람의 아이디를 가져옵니다.
        String id = msg.getSendid();
        // 메시지를 받을 사람의 아이디를 가져옵니다.
        String target = msg.getReceiveid();

        log.info("-------------------------");
        log.info("Target ID: " + target);

        // "/send/to/받는사람ID" 형태의 개인 토픽으로 메시지를 전송합니다.
        // 해당 아이디의 사용자만 이 메시지를 수신하게 됩니다.
        template.convertAndSend("/send/to/" + target, msg);
    }
}
