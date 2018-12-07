import {Component, Input, OnInit} from '@angular/core';
import {ITest} from '../../../../entities/test';
import {ITestResult} from '../../../../entities/test-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {ActivityStatsRequest, IActivity} from '../../../../entities/activity';
import {IEvent} from '../../../../entities/event';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {CategoriesComponent} from '../../../admin/activities/categories/categories.component';
import {ActivityCategoryStatsRequest, PersonalCategoryStats} from '../../../../entities/activity-category';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';

@Component({
  selector: 'app-user-test-result',
  templateUrl: './user-test-result.component.html',
  styleUrls: ['./user-test-result.component.scss']
})
export class UserTestResultComponent implements OnInit {

  constructor(private categoryService: ActivityCategoryService) { }

  @Input()
  test: ITest;

  @Input()
  testResult: ITestResult;

  @Input()
  event: IEvent;

  categoryStats: PersonalCategoryStats;
  primaryChartData: object[];
  secondaryChartData: object[];


  ngOnInit() {
    const request = new ActivityCategoryStatsRequest();
    request.parentCategoryId = null;
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;
    this.categoryService.findMyStats(request).subscribe((categoryStatsResponse: HttpResponse<PersonalCategoryStats>) => {
      this.categoryStats = categoryStatsResponse.body;
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
  }

  getColorScheme(name): any {
    return colorSets.find(s => s.name === name);
  }
}
