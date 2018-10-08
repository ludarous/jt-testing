package cz.jtposrts.jttesting.service.mapper;

import cz.jtposrts.jttesting.domain.*;
import cz.jtposrts.jttesting.service.dto.TestResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity TestResult and its DTO TestResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventResultMapper.class, JTTestMapper.class})
public interface TestResultMapper extends EntityMapper<TestResultDTO, TestResult> {

    @Mapping(source = "eventResult.id", target = "eventResultId")
    @Mapping(source = "test.id", target = "testId")
    TestResultDTO toDto(TestResult testResult);

    @Mapping(source = "eventResultId", target = "eventResult")
    @Mapping(target = "activitiesResults", ignore = true)
    @Mapping(source = "testId", target = "test")
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
