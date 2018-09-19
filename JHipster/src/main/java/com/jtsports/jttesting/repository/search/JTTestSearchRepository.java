package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.JTTest;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the JTTest entity.
 */
public interface JTTestSearchRepository extends ElasticsearchRepository<JTTest, Long> {
}
