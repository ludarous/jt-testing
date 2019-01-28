package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;
import com.jtsports.jttesting.domain.enumeration.GroupAuthority;

/**
 * A DTO for the PersonGroup entity.
 */
public class PersonGroupDTO implements Serializable {

    private Long id;

    @NotNull
    private GroupAuthority groupRole;

    private Long personId;

    private String personEmail;

    private Long groupId;

    private String groupName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public GroupAuthority getGroupRole() {
        return groupRole;
    }

    public void setGroupRole(GroupAuthority groupRole) {
        this.groupRole = groupRole;
    }

    public Long getPersonId() {
        return personId;
    }

    public void setPersonId(Long personId) {
        this.personId = personId;
    }

    public String getPersonEmail() {
        return personEmail;
    }

    public void setPersonEmail(String personEmail) {
        this.personEmail = personEmail;
    }

    public Long getGroupId() {
        return groupId;
    }

    public void setGroupId(Long groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        PersonGroupDTO personGroupDTO = (PersonGroupDTO) o;
        if (personGroupDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), personGroupDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "PersonGroupDTO{" +
            "id=" + getId() +
            ", groupRole='" + getGroupRole() + "'" +
            ", person=" + getPersonId() +
            ", person='" + getPersonEmail() + "'" +
            ", group=" + getGroupId() +
            ", group='" + getGroupName() + "'" +
            "}";
    }
}
