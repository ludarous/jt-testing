package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.Stats.PersonalStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public interface StatsService {

    PersonalStatsDTO getPersonalStats(Long personId, StatsRequestDTO statsRequest);

}
