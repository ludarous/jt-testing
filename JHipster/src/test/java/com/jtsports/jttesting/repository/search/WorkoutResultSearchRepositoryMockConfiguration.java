package com.jtsports.jttesting.repository.search;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Configuration;

/**
 * Configure a Mock version of WorkoutResultSearchRepository to test the
 * application without starting Elasticsearch.
 */
@Configuration
public class WorkoutResultSearchRepositoryMockConfiguration {

    @MockBean
    private WorkoutResultSearchRepository mockWorkoutResultSearchRepository;

}