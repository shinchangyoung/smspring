package edu.sm.example;

import java.util.ArrayList;
import java.util.List;

public class Eample {
    public static void main(String[] args) {

        List<String> list = new ArrayList<>();

        list.add("신창영");
        list.add("신우정");
        list.add("신양호");
        list.add("신창영"); // 중복을 허용한다.

        System.out.println("전체요소 : " +list); //[신창영, 신우정, 신양호, 신창영]

        System.out.println("첫 번째 요소: " + list.get(0)); //첫번쨰 요소 : 신창영

        list.remove("신창영"); // 첫 번째 "신창영" 삭제
        System.out.println("삭제 후: " + list);

        System.out.println("리스트 크기: " + list.size()); // 3


    }

}
