package com.jtsports.jttesting.service.dto.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;
import com.jtsports.jttesting.service.util.StatsUtil;

import java.util.List;
import java.util.stream.Collectors;

public class PersonalActivityStatsDTO extends ActivityStatsDTO {

    private List<PersonalActivityResultsStatsDTO> personalActivityResultsStats;

    private List<ActivityResultDTO> personalActivityResults;

    public List<PersonalActivityResultsStatsDTO> getPersonalActivityResultsStats() {
        return personalActivityResultsStats;
    }

    public void setPersonalActivityResultsStats(List<PersonalActivityResultsStatsDTO> personalActivityResultsStats) {
        this.personalActivityResultsStats = personalActivityResultsStats;
    }

    public Float returnBestPrimaryPlacementInPercents() {

        List<Integer> primaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getPrimaryPlacement()).collect(Collectors.toList());
        Integer bestPlacement = StatsUtil.maxInt(primaryPlacements);

        if(bestPlacement != null && this.getActivityResultsStats().getPrimaryResultsCount() != null) {
            return (float) bestPlacement / (float) this.getActivityResultsStats().getPrimaryResultsCount();
        }
        return null;
    }

    public Float returnBestSecondaryPlacementInPercents() {

        List<Integer> secondaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getSecondaryPlacement()).collect(Collectors.toList());
        Integer bestPlacement = StatsUtil.maxInt(secondaryPlacements);

        if(bestPlacement != null && this.getActivityResultsStats().getSecondaryResultsCount() != null) {
            return (float) bestPlacement / (float) this.getActivityResultsStats().getSecondaryResultsCount();
        }
        return null;
    }

    public Float returnWorstPrimaryPlacementInPercents() {

        List<Integer> primaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getPrimaryPlacement()).collect(Collectors.toList());
        Integer worstPlacement = StatsUtil.minInt(primaryPlacements);

        if(worstPlacement != null && this.getActivityResultsStats().getPrimaryResultsCount() != null) {
            return (float) worstPlacement / (float) this.getActivityResultsStats().getPrimaryResultsCount();
        }
        return null;
    }

    public Float returnWorstSecondaryPlacementInPercents() {

        List<Integer> secondaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getSecondaryPlacement()).collect(Collectors.toList());
        Integer worstPlacement = StatsUtil.minInt(secondaryPlacements);

        if(worstPlacement != null && this.getActivityResultsStats().getSecondaryResultsCount() != null) {
            return (float) worstPlacement / (float) this.getActivityResultsStats().getSecondaryResultsCount();
        }
        return null;
    }

    public Float returnAveragePrimaryPlacementInPercents() {

        List<Integer> primaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getPrimaryPlacement()).collect(Collectors.toList());
        Float averagePlacement = StatsUtil.averageInt(primaryPlacements);

        if(averagePlacement != null && this.getActivityResultsStats().getPrimaryResultsCount() != null) {
            return (float) averagePlacement / (float) this.getActivityResultsStats().getPrimaryResultsCount();
        }
        return null;
    }

    public Float returnAverageSecondaryPlacementInPercents() {

        List<Integer> secondaryPlacements = this.getPersonalActivityResultsStats().stream().map(pp -> pp.getSecondaryPlacement()).collect(Collectors.toList());
        Float averagePlacement = StatsUtil.averageInt(secondaryPlacements);

        if(averagePlacement != null && this.getActivityResultsStats().getSecondaryResultsCount() != null) {
            return (float) averagePlacement / (float) this.getActivityResultsStats().getSecondaryResultsCount();
        }
        return null;
    }

    public List<ActivityResultDTO> getPersonalActivityResults() {
        return personalActivityResults;
    }

    public void setPersonalActivityResults(List<ActivityResultDTO> personalActivityResults) {
        this.personalActivityResults = personalActivityResults;
    }
}
