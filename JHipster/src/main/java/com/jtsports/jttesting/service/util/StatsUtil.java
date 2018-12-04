package com.jtsports.jttesting.service.util;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

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
}
