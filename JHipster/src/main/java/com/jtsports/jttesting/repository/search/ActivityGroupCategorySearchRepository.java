package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.ActivityGroupCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityGroupCategory entity.
 */
public interface ActivityGroupCategorySearchRepository extends ElasticsearchRepository<ActivityGroupCategory, Long> {
}
