package edu.sm.app.springai.service2;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.prompt.ChatOptions;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class AiServiceFewShot {

  private final ChatClient chatClient;

  public AiServiceFewShot(ChatClient.Builder chatClientBuilder) {
    this.chatClient = chatClientBuilder.build();
  }

  public String fewShotPrompt(String order) {

    String strPrompt = """
        당신은 라멘 가게의 주문 접수 시스템입니다.
        아래 메뉴판과 규칙을 보고 고객의 주문을 분석하여 항상 JSON 배열(array) 형식으로 반환해주세요.

        # 메뉴판
        - 돈코츠라멘: 9000원, 이미지: donkotsu.jpg
        - 미소라멘: 9500원, 이미지: miso.jpg
        - 소유라멘: 8500원, 이미지: shoyu.jpg
        - 시오라멘: 8500원, 이미지: shio.jpg

        # 토핑
        - 차슈: 1000원
        - 계란: 500원

        # 사이드 메뉴
        - 교자: 3000원

        # 규칙
        1. 주문이 하나여도 반드시 배열 안에 JSON 객체를 넣어주세요. 예: `[{"menuName":...}]`
        2. 추가 설명이나 주석 없이 순수한 JSON 배열 문자열만 반환해야 합니다.
        3. 각 주문 항목의 최종 가격(price)은 "메뉴 기본 가격 + 모든 토핑 가격 + 모든 사이드 메뉴 가격" 으로 계산해서 넣어주세요. 수량(quantity)은 가격 계산에 곱하지 않습니다.
        4. 메뉴판에 없는 메뉴는 주문받지 마세요.

        # 예시 1 (단일 주문 + 토핑)
        고객 주문: 돈코츠라멘에 면 추가하고 차슈도 넣어주세요.
        JSON 응답:
        [
          {
            "menuName": "돈코츠라멘",
            "quantity": 1,
            "price": 10000,
            "imageName": "donkotsu.jpg",
            "extraNoodles": true,
            "tasteStrength": "보통",
            "toppings": ["차슈"],
            "sideDishes": []
          }
        ]

        # 예시 2 (복수 주문 + 사이드 메뉴)
        고객 주문: 소유라멘 하나랑, 미소라멘 하나에 교자 추가해주세요.
        JSON 응답:
        [
          {
            "menuName": "소유라멘",
            "quantity": 1,
            "price": 8500,
            "imageName": "shoyu.jpg",
            "extraNoodles": false,
            "tasteStrength": "보통",
            "toppings": [],
            "sideDishes": []
          },
          {
            "menuName": "미소라멘",
            "quantity": 1,
            "price": 12500,
            "imageName": "miso.jpg",
            "extraNoodles": false,
            "tasteStrength": "보통",
            "toppings": [],
            "sideDishes": ["교자"]
          }
        ]

        # 고객 주문
        %s
        """.formatted(order);

    Prompt prompt = Prompt.builder()
            .content(strPrompt)
            .build();

    String ramenOrderJson = chatClient.prompt(prompt)
            .options(ChatOptions.builder()
                    .build())
            .call()
            .content();

    return ramenOrderJson;
  }
}