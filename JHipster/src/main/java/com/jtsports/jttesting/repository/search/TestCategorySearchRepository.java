package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.TestCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the TestCategory entity.
 */
public interface TestCategorySearchRepository extends ElasticsearchRepository<TestCategory, Long> {
}
