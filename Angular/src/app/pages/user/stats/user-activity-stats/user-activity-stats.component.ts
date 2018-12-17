import {Component, Input, OnInit} from '@angular/core';
import {PersonalActivityStats} from '../../../../entities/activity';
import {ActivityStatsData} from '../user-stats.component';
import {ChartUtils} from '../../../../utils/chart-utils';

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

  ngOnInit() {
    this.createChartData(this.activityStats);
  }

  createChartData(activityStats: PersonalActivityStats) {

    const activityStatsData = new ActivityStatsData();
    activityStatsData.refLines = [
      {
        value: activityStats.activityResultsStats.primaryMax,
        name: 'Maximum'
      },
      {
        value: activityStats.activityResultsStats.primaryMin,
        name: 'Minimum'
      },
      {
        value: activityStats.activityResultsStats.primaryAverage,
        name: 'Průměr'
      }
    ];

    const series = [];
    for (const activityResult of activityStats.personalActivityResults) {
      series.push({name: new Date(activityResult.eventDate), value: activityResult.primaryResultValue});
    }

    activityStatsData.chartData = [
      {
        name: activityStats.activity.name,
        series: series
      }
    ];

    activityStatsData.highlights = [
      {
        name: activityStats.activity.name,
        series: series
      }
    ];

    this.activityStatsChartData = activityStatsData;

  }

  getColorScheme(name): any {
    return ChartUtils.getColorScheme(name);
  }

  getCurve(name: string): any {
    return ChartUtils.getCurve(name);
  }

  afterExpand(event: any) {

  }

}
