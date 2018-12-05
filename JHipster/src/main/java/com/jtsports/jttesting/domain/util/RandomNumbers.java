package com.jtsports.jttesting.domain.util;

import java.util.Random;

public class RandomNumbers {

    public static Float getHeight() {
      return new Float(RandomNumbers.getRandomNumberInRange(160, 190));
    }

    public static Float getWeight() {
        return new Float(RandomNumbers.getRandomNumberInRange(75, 90));
    }

    public static int getRandomNumberInRange(int min, int max) {

        if (min >= max) {
            throw new IllegalArgumentException("max must be greater than min");
        }

        Random r = new Random();
        return r.nextInt((max - min) + 1) + min;
    }
}
