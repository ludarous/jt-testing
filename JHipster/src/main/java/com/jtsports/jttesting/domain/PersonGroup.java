package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.Objects;

import com.jtsports.jttesting.domain.enumeration.GroupAuthority;

/**
 * A PersonGroup.
 */
@Entity
@Table(name = "person_group")
@Document(indexName = "persongroup")
public class PersonGroup implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "group_role", nullable = false)
    private GroupAuthority groupRole;

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Person person;

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Group group;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public GroupAuthority getGroupRole() {
        return groupRole;
    }

    public PersonGroup groupRole(GroupAuthority groupRole) {
        this.groupRole = groupRole;
        return this;
    }

    public void setGroupRole(GroupAuthority groupRole) {
        this.groupRole = groupRole;
    }

    public Person getPerson() {
        return person;
    }

    public PersonGroup person(Person person) {
        this.person = person;
        return this;
    }

    public void setPerson(Person person) {
        this.person = person;
    }

    public Group getGroup() {
        return group;
    }

    public PersonGroup group(Group group) {
        this.group = group;
        return this;
    }

    public void setGroup(Group group) {
        this.group = group;
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
        PersonGroup personGroup = (PersonGroup) o;
        if (personGroup.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), personGroup.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "PersonGroup{" +
            "id=" + getId() +
            ", groupRole='" + getGroupRole() + "'" +
            "}";
    }
}
