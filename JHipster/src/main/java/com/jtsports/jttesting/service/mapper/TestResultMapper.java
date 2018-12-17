package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.TestResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity TestResult and its DTO TestResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventResultMapper.class, JTTestMapper.class, ActivityResultMapper.class})
public interface TestResultMapper extends EntityMapper<TestResultDTO, TestResult> {

    @Mapping(source = "eventResult.id", target = "eventResultId")
    @Mapping(source = "test.id", target = "testId")
    @Mapping(source = "test.name", target = "testName")
    @Mapping(target = "activitiesResults", ignore = true)
    TestResultDTO toDto(TestResult testResult);

    @Mapping(source = "eventResultId", target = "eventResult")
    @Mapping(source = "testId", target = "test")
    @Mapping(source = "activitiesResults", target = "activitiesResults")
    TestResult toEntity(TestResultDTO testResultDTO);

    default TestResult fromId(Long id) {
        if (id == null) {
            return null;
        }
        TestResult testResult = new TestResult();
        testResult.setId(id);
        return testResult;
    }
}
