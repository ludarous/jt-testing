package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A ActivityCategory.
 */
@Entity
@Table(name = "activity_category")
@Document(indexName = "activitycategory")
public class ActivityCategory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "jhi_key")
    private String key;

    @Column(name = "description")
    private String description;

    @ManyToOne
    @JsonIgnoreProperties("")
    private ActivityCategory parent;

    @OneToMany(mappedBy = "parent")
    private Set<ActivityCategory> children = new HashSet<>();

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

    public ActivityCategory name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public ActivityCategory key(String key) {
        this.key = key;
        return this;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getDescription() {
        return description;
    }

    public ActivityCategory description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ActivityCategory getParent() {
        return parent;
    }

    public ActivityCategory parent(ActivityCategory activityCategory) {
        this.parent = activityCategory;
        return this;
    }

    public void setParent(ActivityCategory activityCategory) {
        this.parent = activityCategory;
    }

    public Set<ActivityCategory> getChildren() {
        return children;
    }

    public ActivityCategory children(Set<ActivityCategory> activityCategories) {
        this.children = activityCategories;
        return this;
    }

    public ActivityCategory addChildren(ActivityCategory activityCategory) {
        this.children.add(activityCategory);
        activityCategory.setParent(this);
        return this;
    }

    public ActivityCategory removeChildren(ActivityCategory activityCategory) {
        this.children.remove(activityCategory);
        activityCategory.setParent(null);
        return this;
    }

    public void setChildren(Set<ActivityCategory> activityCategories) {
        this.children = activityCategories;
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
        ActivityCategory activityCategory = (ActivityCategory) o;
        if (activityCategory.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityCategory.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityCategory{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", key='" + getKey() + "'" +
            ", description='" + getDescription() + "'" +
            "}";
    }
}
