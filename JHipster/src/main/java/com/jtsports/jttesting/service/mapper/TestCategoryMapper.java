package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.TestCategoryDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity TestCategory and its DTO TestCategoryDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface TestCategoryMapper extends EntityMapper<TestCategoryDTO, TestCategory> {



    default TestCategory fromId(Long id) {
        if (id == null) {
            return null;
        }
        TestCategory testCategory = new TestCategory();
        testCategory.setId(id);
        return testCategory;
    }
}
