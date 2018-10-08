package cz.jtposrts.jttesting.config;

import java.time.Duration;

import org.ehcache.config.builders.*;
import org.ehcache.jsr107.Eh107Configuration;

import io.github.jhipster.config.jcache.BeanClassLoaderAwareJCacheRegionFactory;
import io.github.jhipster.config.JHipsterProperties;

import org.springframework.boot.autoconfigure.cache.JCacheManagerCustomizer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.*;

@Configuration
@EnableCaching
public class CacheConfiguration {

    private final javax.cache.configuration.Configuration<Object, Object> jcacheConfiguration;

    public CacheConfiguration(JHipsterProperties jHipsterProperties) {
        BeanClassLoaderAwareJCacheRegionFactory.setBeanClassLoader(this.getClass().getClassLoader());
        JHipsterProperties.Cache.Ehcache ehcache =
            jHipsterProperties.getCache().getEhcache();

        jcacheConfiguration = Eh107Configuration.fromEhcacheCacheConfiguration(
            CacheConfigurationBuilder.newCacheConfigurationBuilder(Object.class, Object.class,
                ResourcePoolsBuilder.heap(ehcache.getMaxEntries()))
                .withExpiry(ExpiryPolicyBuilder.timeToLiveExpiration(Duration.ofSeconds(ehcache.getTimeToLiveSeconds())))
                .build());
    }

    @Bean
    public JCacheManagerCustomizer cacheManagerCustomizer() {
        return cm -> {
            cm.createCache(cz.jtposrts.jttesting.repository.UserRepository.USERS_BY_LOGIN_CACHE, jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.repository.UserRepository.USERS_BY_EMAIL_CACHE, jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.User.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Authority.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.User.class.getName() + ".authorities", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Event.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Event.class.getName() + ".eventResults", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Event.class.getName() + ".tests", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.JTTest.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.JTTest.class.getName() + ".activities", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.JTTest.class.getName() + ".categories", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.JTTest.class.getName() + ".sports", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Activity.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Activity.class.getName() + ".categories", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.TestCategory.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.ActivityCategory.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.EventResult.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.EventResult.class.getName() + ".testResults", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.TestResult.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.TestResult.class.getName() + ".activitiesResults", jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.ActivityResult.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Person.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.PersonalData.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Address.class.getName(), jcacheConfiguration);
            cm.createCache(cz.jtposrts.jttesting.domain.Sport.class.getName(), jcacheConfiguration);
            // jhipster-needle-ehcache-add-entry
        };
    }
}
