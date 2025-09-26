package edu.sm.example;

import java.util.*;

public class Eample {
    public static void main(String[] args) {


// compare(a, b)의 매개변수 a와 b를 람다식으로 표현
        List<String> names = Arrays.asList("Alice", "Bob", "Charlie");

        System.out.println(names);

        Collections.sort(names, (a, b) -> b.compareTo(a));

        names.sort(Comparator.reverseOrder());
        System.out.println(names);


        List<String> items = Arrays.asList("Pen", "Book", "Desk");

// forEach를 사용하여 각 요소 출력
        items.forEach(item -> System.out.print("Item: " + item + " "));

    }

}
