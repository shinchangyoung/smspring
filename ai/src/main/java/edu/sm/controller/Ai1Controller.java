package edu.sm.controller;

import edu.sm.app.springai.service1.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/ai1")
@Slf4j
@RequiredArgsConstructor
public class Ai1Controller {
    final AiServiceByChatClient aiServiceByChatClient;
    final AiServiceChainOfThoughtPrompt aiServiceChainOfThoughtPrompt;
    final AiServiceFewShotPrompt aiServiceFewShotPrompt;
    final AiServiceFewShotPrompt2 aiServiceFewShotPrompt2;
    final AiServicePromptTemplate aiServicept;
    final AiServiceStepBackPrompt aiServiceStepBackPrompt;

    @RequestMapping("/chat-model")
    public String chatModel(@RequestParam("question") String question){
        return aiServiceByChatClient.generateText(question);
    }

    @RequestMapping("/few-shot-prompt")
    public String fewShpowPropt(@RequestParam("question") String question){
        return aiServiceFewShotPrompt.fewShotPrompt(question);
    }

    @RequestMapping("/few-shot-prompt2")
    public String fewShpowPropt2(@RequestParam("question") String question){
        return aiServiceFewShotPrompt2.fewShotPrompt(question);
    }

    @RequestMapping("/chat-model-stream")
    public Flux<String> chatModelStream(@RequestParam("question") String question){
        return aiServiceByChatClient.generateStreamText(question);
    } //사비스에서는 단어가 오는대로 하나하나 출력을 함 ->빠른거는 Flux가 더 빠르다

    @RequestMapping("/chat-of-thought")
    public Flux<String> chatOfTho(@RequestParam("question") String question){
        return aiServiceChainOfThoughtPrompt.chainOfThought(question);
    } //사비스에서는 단어가 오는대로 하나하나 출력을 함 ->빠른거는 Flux가 더 빠르다


    @RequestMapping("/prompt-template")
    public Flux<String> promptTemplate(      @RequestParam("question") String question,
                                             @RequestParam("language") String language){
        Flux<String> response = aiServicept.promptTemplate3(question , language);
        return response;
    }


    @RequestMapping("/role-assignment")
    public Flux<String> roleAssignment(@RequestParam("requirements") String requirements){
        Flux<String> response = aiServicept.roleAssignment(requirements);
        return response;
    }

    @RequestMapping("/step-back-prompt")
    public String stepBackPrompt(@RequestParam("question") String question) throws Exception {
        return aiServiceStepBackPrompt.stepBackPrompt(question);
    }

}
