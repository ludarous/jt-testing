package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.TestResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the TestResult entity.
 */
public interface TestResultSearchRepository extends ElasticsearchRepository<TestResult, Long> {
}
