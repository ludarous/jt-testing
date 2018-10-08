package cz.jtposrts.jttesting.service.mapper;

import cz.jtposrts.jttesting.domain.*;
import cz.jtposrts.jttesting.service.dto.TestCategoryDTO;

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
