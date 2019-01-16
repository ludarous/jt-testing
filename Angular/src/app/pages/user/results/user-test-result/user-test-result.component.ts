import {Component, Input, OnInit} from '@angular/core';
import {ITest, PersonalTestStats} from '../../../../entities/test';
import {ITestResult} from '../../../../entities/test-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';
import {IEvent} from '../../../../entities/event';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {ActivityCategoriesComponent} from '../../../admin/activity-categories/activity-categories.component';
import {PersonalCategoryStats} from '../../../../entities/activity-category';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {StatsRequest} from '../../../../entities/stats-request';
import {TestService} from '../../../../services/test.service';
import {EventManager} from '../../../../services/event.manager';
import {StatsUtils} from '../../../../utils/stats-utils';

@Component({
  selector: 'app-user-test-result',
  templateUrl: './user-test-result.component.html',
  styleUrls: ['./user-test-result.component.scss']
})
export class UserTestResultComponent implements OnInit {

  constructor(private categoryService: ActivityCategoryService,
              private testService: TestService,
              private eventManager: EventManager) { }

  @Input()
  test: ITest;

  @Input()
  testResult: ITestResult;

  @Input()
  event: IEvent;

  categoryStats: PersonalCategoryStats;
  testStats: PersonalTestStats;

  primaryChartData: object[];
  secondaryChartData: object[];
  activitiesChartData: object[];


  ngOnInit() {
    const request = new StatsRequest();
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;
    // this.categoryService.findMyStats(null, request).subscribe((categoryStatsResponse: HttpResponse<PersonalCategoryStats>) => {
    //   this.categoryStats = categoryStatsResponse.body;
    //   this.createChartData();
    // });

    this.testService.findMyStats(request).subscribe((testStatsResponse: HttpResponse<PersonalTestStats>) => {
      console.log(testStatsResponse.body);
      this.testStats = PersonalTestStats.resolveResponse(testStatsResponse);
      this.categoryStats = this.testStats.personalCategoryStats;
      this.createChartData();
    });
  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    return this.test.activities.find((a) => a.id === activityResult.activityId);
  }

  createChartData() {

    const primarySeries = [];
    const secondarySeries = [];

    for (const categoryResultStats of this.categoryStats.personalCategoriesResultsStats) {
      primarySeries.push({
        name: categoryResultStats.category.name,
        value: categoryResultStats.primaryPlacement * 100
      });

      secondarySeries.push({
        name: categoryResultStats.category.name,
        value: categoryResultStats.secondaryPlacement * 100
      });
    }

    this.primaryChartData = [
      {
        name: 'Hlavní výsledek',
        series: primarySeries
      }
    ];

    this.secondaryChartData = [
      {
        name: 'Vedlejší výsledek',
        series: secondarySeries
      }
    ];

    this.activitiesChartData = [];

    for (const activityStats of this.testStats.personalActivitiesStats) {

      const totalPrimaryCounts = activityStats.personalActivityResultsStats.map(par => par.totalPrimaryResults);
      const totalPrimaryCountsAverage = StatsUtils.average(totalPrimaryCounts);

      const primaryPlacements = activityStats.personalActivityResultsStats.map(par => totalPrimaryCountsAverage - par.primaryPlacement);
      const primaryPlacementsAverage = StatsUtils.average(primaryPlacements);

      this.activitiesChartData.push(
        {
          name: activityStats.activity.name,
          value: primaryPlacementsAverage * 100 / totalPrimaryCountsAverage,
          extra: {
            activity: activityStats.activity
          }
        });
    }


  }

  selectActivity(event: any) {
    this.eventManager.broadcast({
      name: 'activityStatsSelected',
      content: event.extra.activity
    });
  }

  getColorScheme(name): any {
    return colorSets.find(s => s.name === name);
  }
}
