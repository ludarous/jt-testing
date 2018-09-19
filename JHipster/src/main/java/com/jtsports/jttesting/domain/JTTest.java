package com.jtsports.jttesting.domain;


import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A JTTest.
 */
@Entity
@Table(name = "jt_test")
@Document(indexName = "jttest")
public class JTTest implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @ManyToMany
    @JoinTable(name = "jttest_activities",
               joinColumns = @JoinColumn(name = "jttests_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "activities_id", referencedColumnName = "id"))
    private Set<Activity> activities = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "jttest_categories",
               joinColumns = @JoinColumn(name = "jttests_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "categories_id", referencedColumnName = "id"))
    private Set<TestCategory> categories = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "jttest_sports",
               joinColumns = @JoinColumn(name = "jttests_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "sports_id", referencedColumnName = "id"))
    private Set<Sport> sports = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public JTTest name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public JTTest description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Set<Activity> getActivities() {
        return activities;
    }

    public JTTest activities(Set<Activity> activities) {
        this.activities = activities;
        return this;
    }

    public JTTest addActivities(Activity activity) {
        this.activities.add(activity);
        return this;
    }

    public JTTest removeActivities(Activity activity) {
        this.activities.remove(activity);
        return this;
    }

    public void setActivities(Set<Activity> activities) {
        this.activities = activities;
    }

    public Set<TestCategory> getCategories() {
        return categories;
    }

    public JTTest categories(Set<TestCategory> testCategories) {
        this.categories = testCategories;
        return this;
    }

    public JTTest addCategories(TestCategory testCategory) {
        this.categories.add(testCategory);
        return this;
    }

    public JTTest removeCategories(TestCategory testCategory) {
        this.categories.remove(testCategory);
        return this;
    }

    public void setCategories(Set<TestCategory> testCategories) {
        this.categories = testCategories;
    }

    public Set<Sport> getSports() {
        return sports;
    }

    public JTTest sports(Set<Sport> sports) {
        this.sports = sports;
        return this;
    }

    public JTTest addSports(Sport sport) {
        this.sports.add(sport);
        return this;
    }

    public JTTest removeSports(Sport sport) {
        this.sports.remove(sport);
        return this;
    }

    public void setSports(Set<Sport> sports) {
        this.sports = sports;
    }
    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here, do not remove

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        JTTest jTTest = (JTTest) o;
        if (jTTest.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), jTTest.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "JTTest{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            "}";
    }
}
