package com.jtsports.jttesting.service.dto.Test;

import com.jtsports.jttesting.domain.JTTest;
import com.jtsports.jttesting.service.dto.Activity.ActivityStatsDTO;
import com.jtsports.jttesting.service.dto.JTTestDTO;

import java.util.List;

public class TestStatsDTO {
    private JTTestDTO test;

    private List<ActivityStatsDTO> activitiesStats;
}
