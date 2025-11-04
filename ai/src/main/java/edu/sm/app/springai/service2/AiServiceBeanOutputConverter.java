package edu.sm.app.springai.service2;

import edu.sm.app.dto.Hotel;
import edu.sm.app.dto.StudyPlan;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.ai.converter.BeanOutputConverter;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class AiServiceBeanOutputConverter {
  // ##### 필드 #####
  private final ChatClient chatClient;

  // ##### 생성자 #####
  public AiServiceBeanOutputConverter(ChatClient.Builder chatClientBuilder) {
    chatClient = chatClientBuilder.build();
  }

  // ##### 신규 추가된 스터디 플랜 생성 메소드 #####
  public List<StudyPlan> getStudyPlan(String userPrompt) {
    String systemMessage = """
        당신은 전문 스터디 플래너입니다.
        사용자의 요청에 따라 일일 학습 계획을 생성하세요.
        출력은 반드시 객체의 JSON 배열이어야 합니다. 각 객체는 "title", "start", "end" 필드를 가져야 합니다.
        "start"와 "end" 날짜 형식은 'YYYY-MM-DD'여야 합니다.
        오늘부터 시작하는 계획을 생성하세요. 오늘은 %s 입니다.
        JSON이 유효하고 형식이 올바른지 확인하세요.
        예를 들어, 사용자가 3일 계획을 원하면 배열에 3개의 JSON 객체를 제공해야 합니다.
        하루짜리 작업의 경우 'end' 날짜는 'start' 날짜와 동일해야 합니다.
        """;

    List<StudyPlan> studyPlanList = chatClient.prompt()
        .system(systemMessage.formatted(LocalDate.now()))
        .user(userPrompt)
        .call()
        .entity(new ParameterizedTypeReference<List<StudyPlan>>() {});

    log.info("AI가 생성한 스터디 계획: {}", studyPlanList);
    return studyPlanList;
  }


  // ##### 기존 메소드 #####
  public Hotel beanOutputConverterLowLevel(String city) {
    // 구조화된 출력 변환기 생성
    BeanOutputConverter<Hotel> beanOutputConverter = new BeanOutputConverter<>(Hotel.class);
    // 프롬프트 템플릿 생성
    PromptTemplate promptTemplate = PromptTemplate.builder()
        .template("{city}에서 유명한 호텔 목록 5개를 출력하세요. {format}")
        .build();
    // 프롬프트 생성
    Prompt prompt = promptTemplate.create(Map.of(
        "city", city,
        "format", beanOutputConverter.getFormat()));
    // LLM의 JSON 출력 얻기
    String json = chatClient.prompt(prompt)
        .call()
        .content();
    // JSON을 Hotel로 매핑해서 변환
    Hotel hotel = beanOutputConverter.convert(json);
    return hotel;
  }
  
  public Hotel beanOutputConverterHighLevel(String city) {
    Hotel hotel = chatClient.prompt()
        .user("%s에서 유명한 호텔 목록 5개를 출력하세요.".formatted(city))
        .call()
        .entity(Hotel.class);
    return hotel;
  }  
}
