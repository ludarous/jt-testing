package cz.jtposrts.jttesting.repository.search;

import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Configuration;

/**
 * Configure a Mock version of TestCategorySearchRepository to test the
 * application without starting Elasticsearch.
 */
@Configuration
public class TestCategorySearchRepositoryMockConfiguration {

    @MockBean
    private TestCategorySearchRepository mockTestCategorySearchRepository;

}
