package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.JTTestDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity JTTest and its DTO JTTestDTO.
 */
@Mapper(componentModel = "spring", uses = {ActivityMapper.class, TestCategoryMapper.class, SportMapper.class})
public interface JTTestMapper extends EntityMapper<JTTestDTO, JTTest> {



    default JTTest fromId(Long id) {
        if (id == null) {
            return null;
        }
        JTTest jTTest = new JTTest();
        jTTest.setId(id);
        return jTTest;
    }
}
