package edu.sm.app.springai.service5;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@Slf4j
public class HeatingSystemService {
  // ##### 필드 #####
  private ChatClient chatClient;

  @Autowired
  private HeatingSystemTools heatingSystemTools;

  // ##### 생성자 #####
  public HeatingSystemService(ChatModel chatModel) {
    this.chatClient = ChatClient.builder(chatModel).build();
  }

  // ##### LLM과 대화하는 메소드 #####
  public String chat(String question) {
    // 1. toolContext에 전달할 값을 변수로 추출합니다.
//    String controlKeyValue = "heatingSystemKey";
//
//    // 2. 변수 값을 로그로 출력하여 확인합니다.
//    log.info("toolContext에 전달되는 controlKey 값: {}", controlKeyValue);

    String answer = chatClient.prompt()
        .system("""
          현재 온도가 사용자가 원하는 온도 이상이라면 난방 시스템을 중지하세요.
          현재 온도가 사용자가 원하는 온도 이하라면 난방 시스템을 가동시켜주세요.
        """)
        .user(question)
        .tools(heatingSystemTools)
        // 3. 변수를 사용하여 toolContext를 설정합니다.
        .toolContext(Map.of("controlKey", "heatingSystemKey"))
        .call()
        .content();

    return answer;
  }
}
