package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.ActivityCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityCategory entity.
 */
public interface ActivityCategorySearchRepository extends ElasticsearchRepository<ActivityCategory, Long> {
}
