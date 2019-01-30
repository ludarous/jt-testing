package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A Person.
 */
@Entity
@Table(name = "person")
@Document(indexName = "person")
public class Person implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "email", nullable = false)
    private String email;

    @NotNull
    @Column(name = "virtual", nullable = false)
    private Boolean virtual;

    @OneToOne
    @JoinColumn(unique = true)
    private PersonalData personalData;

    @OneToOne
    @JoinColumn(unique = true)
    private Address address;

    @OneToOne
    @JoinColumn(unique = true)
    private User user;


    @ManyToMany(mappedBy = "attachedPersons")
    @JsonIgnore
    private Set<Event> events = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public Person email(String email) {
        this.email = email;
        return this;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean isVirtual() {
        return virtual;
    }

    public Person virtual(Boolean virtual) {
        this.virtual = virtual;
        return this;
    }

    public void setVirtual(Boolean virtual) {
        this.virtual = virtual;
    }

    public PersonalData getPersonalData() {
        return personalData;
    }

    public Person personalData(PersonalData personalData) {
        this.personalData = personalData;
        return this;
    }

    public void setPersonalData(PersonalData personalData) {
        this.personalData = personalData;
    }

    public Address getAddress() {
        return address;
    }

    public Person address(Address address) {
        this.address = address;
        return this;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public User getUser() {
        return user;
    }

    public Set<Event> getEvents() {
        return events;
    }

    public Person events(Set<Event> events) {
        this.events = events;
        return this;
    }

    public Person user(User user) {
        this.user = user;
        return this;
    }

    public Person addEvents(Event event) {
        this.events.add(event);
        event.getAttachedPersons().add(this);
        return this;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Person removeEvents(Event event) {
        this.events.remove(event);
        event.getAttachedPersons().remove(this);
        return this;
    }

    public void setEvents(Set<Event> events) {
        this.events = events;
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
        Person person = (Person) o;
        if (person.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), person.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Person{" +
            "id=" + getId() +
            ", email='" + getEmail() + "'" +
            ", virtual='" + isVirtual() + "'" +
            "}";
    }
}
