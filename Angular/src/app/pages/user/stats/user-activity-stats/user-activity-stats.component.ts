import {Component, Input, OnInit} from '@angular/core';
import {ActivityStatsData} from '../user-stats.component';
import {ChartUtils} from '../../../../utils/chart-utils';
import {PersonalActivityStats, PersonalStats} from '../../../../entities/stats';
import * as $ from 'jquery';

@Component({
  selector: 'app-user-activity-stats',
  templateUrl: './user-activity-stats.component.html',
  styleUrls: ['./user-activity-stats.component.scss']
})
export class UserActivityStatsComponent implements OnInit {

  constructor() { }

  @Input()
  activityStats: PersonalActivityStats;

  activityStatsChartData: ActivityStatsData;
  yScaleMax: number;

  activeEntries: Array<any> = [{name: 'Active Entry', value: 10}];

  ngOnInit() {
    this.createChartData(this.activityStats);
  }

  createChartData(personalActivityStats: PersonalActivityStats) {

    if (personalActivityStats.primaryResultsStats) {
      const activityStatsData = new ActivityStatsData();
      activityStatsData.refLines = [
        {
          value: personalActivityStats.primaryResultsStats.resultsMaxValue,
          name: 'Maximum'
        },
        {
          value: personalActivityStats.primaryResultsStats.resultsMinValue,
          name: 'Minimum'
        },
        {
          value: personalActivityStats.primaryResultsStats.resultsAverageValue,
          name: 'Průměr'
        }
      ];

      this.yScaleMax = personalActivityStats.primaryResultsStats.resultsMaxValue * 1.2;


      const series = [];
      for (const activityResult of personalActivityStats.personalActivityResults) {
        series.push({name: new Date(activityResult.eventDate), value: activityResult.primaryResultValue});
      }

      activityStatsData.chartData = [
        {
          name: personalActivityStats.activity.name,
          series: series
        }
      ];

      activityStatsData.highlights = [
        {
          name: personalActivityStats.activity.name,
          series: series
        }
      ];

      this.activityStatsChartData = activityStatsData;
    }

    //this.setGradient();
  }

  getColorScheme(name): any {
    return ChartUtils.getColorScheme(name);
  }

  getCurve(name: string): any {
    return ChartUtils.getCurve(name);
  }

  afterExpand(event: any) {

  }

  private setGradient() {
    setTimeout(() => {
      $('.tooltip-anchor').trigger('mouseenter').trigger('mouseover');
    }, 1000);

  }
}
