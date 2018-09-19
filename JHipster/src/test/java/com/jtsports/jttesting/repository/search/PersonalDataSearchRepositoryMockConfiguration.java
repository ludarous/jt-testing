package com.jtsports.jttesting.repository.search;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Configuration;

/**
 * Configure a Mock version of PersonalDataSearchRepository to test the
 * application without starting Elasticsearch.
 */
@Configuration
public class PersonalDataSearchRepositoryMockConfiguration {

    @MockBean
    private PersonalDataSearchRepository mockPersonalDataSearchRepository;

}
