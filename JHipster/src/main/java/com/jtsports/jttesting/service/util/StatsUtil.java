package com.jtsports.jttesting.service.util;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class StatsUtil {
    public static Float median(List<Float> values) {
        Collections.sort(values);
        int length = values.size();


        Float median;
        if (values.size() % 2 == 0)
            median = (values.get(length/2) + values.get(length/2 - 1))/2;
        else
            median = values.get(length/2);
        return  median;
    }

    public static Float average (List<Float> values) {
        Float sum = 0F; //average will have decimal point

        for(int i=0; i < values.size(); i++){
            sum += values.get(i);
        }

        Float average = sum/values.size();
        return average;
    }
    
    public static Float min(List<Float> values) {
        return Collections.min(values);
    }

    public static Float max(List<Float> values) {
        return Collections.max(values);
    }

    public static Integer medianInt(List<Integer> values) {
        if(values != null) {

            List<Integer> notNullValues = values.stream().filter(v -> v != null).collect(Collectors.toList());

            Collections.sort(notNullValues);
            int length = notNullValues.size();


            Integer median;
            if (notNullValues.size() % 2 == 0)
                median = (notNullValues.get(length / 2) + notNullValues.get(length / 2 - 1)) / 2;
            else
                median = notNullValues.get(length / 2);
            return median;
        }
        return null;
    }

    public static Float averageInt (List<Integer> values) {
        Float sum = 0F; //average will have decimal point
        Float average = null;

        List<Integer> notNullValues = values.stream().filter(v -> v != null).collect(Collectors.toList());

        if(notNullValues != null) {
            for (int i = 0; i < notNullValues.size(); i++) {
                if (notNullValues.get(i) != null) {
                    sum += notNullValues.get(i);
                }
            }
            average = sum/notNullValues.size();
        }

        return average;
    }

    public static Integer minInt(List<Integer> values) {
        if(values != null) {

            return Collections.min(values.stream().filter(v -> v != null).collect(Collectors.toList()));
        }
        return null;
    }

    public static Integer maxInt(List<Integer> values) {
        if(values != null) {
            return Collections.max(values.stream().filter(v -> v != null).collect(Collectors.toList()));
        }
        return null;
    }
}
