package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.ActivityCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityCategory entity.
 */
public interface ActivityCategorySearchRepository extends ElasticsearchRepository<ActivityCategory, Long> {
}
