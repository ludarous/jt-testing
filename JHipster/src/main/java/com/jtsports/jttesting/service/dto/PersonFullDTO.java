package com.jtsports.jttesting.service.dto;

import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the Person entity.
 */
public class PersonFullDTO implements Serializable {

    private Long id;

    private String email;

    private Boolean virtual;

    private PersonalDataDTO personalData;

    private AddressDTO address;

    private UserDTO user;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public PersonalDataDTO getPersonalData() {
        return personalData;
    }

    public void setPersonalData(PersonalDataDTO personalData) {
        this.personalData = personalData;
    }

    public AddressDTO getAddress() {
        return address;
    }

    public void setAddress(AddressDTO address) {
        this.address = address;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean isVirtual() {
        return virtual;
    }

    public void setVirtual(Boolean virtual) {
        this.virtual = virtual;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        PersonFullDTO personDTO = (PersonFullDTO) o;
        if (personDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), personDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "PersonDTO{" +
            "id=" + getId() +
            ", personalData=" + getPersonalData() != null ? getPersonalData().toString() : "" +
            ", address=" + getAddress() != null ? getAddress().toString() : "" +
            "}";
    }

}
