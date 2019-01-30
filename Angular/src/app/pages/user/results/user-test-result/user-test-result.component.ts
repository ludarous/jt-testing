import {Component, Input, OnInit} from '@angular/core';
import {IActivityGroup} from '../../../../entities/activity-group';
import {IActivityGroupResult} from '../../../../entities/activity-group-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';
import {IEvent} from '../../../../entities/event';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {StatsRequest} from '../../../../entities/stats-request';
import {ActivityGroupService} from '../../../../services/activity-group.service';
import {EventManager} from '../../../../services/event.manager';
import {StatsUtils} from '../../../../utils/stats-utils';
import {StatsService} from '../../../../services/stats.service';
import {PersonalActivityStats, PersonalCategoryStats, PersonalStats, Stats} from '../../../../entities/stats';
import * as $ from 'jquery';

@Component({
  selector: 'app-user-test-result',
  templateUrl: './user-test-result.component.html',
  styleUrls: ['./user-test-result.component.scss']
})
export class UserTestResultComponent implements OnInit {

  constructor(private categoryService: ActivityCategoryService,
              private ActivityGroupService: ActivityGroupService,
              private statsService: StatsService,
              private eventManager: EventManager) { }

  @Input()
  test: IActivityGroup;

  @Input()
  testResult: IActivityGroupResult;

  @Input()
  event: IEvent;

  stats: PersonalStats;
  filteredActivitiesStats: Array<PersonalActivityStats>;
  primaryChartData: object[];
  secondaryChartData: object[];
  activitiesChartData: object[];


  ngOnInit() {
    const request = new StatsRequest();
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;

    this.statsService.findMyStats(request).subscribe((testStatsResponse: HttpResponse<PersonalStats>) => {
      console.log(testStatsResponse.body);
      this.stats = Stats.resolveResponse(testStatsResponse);
      this.createChartData();
      this.filteredActivitiesStats = this.stats.activitiesStats
        .filter(as => as.primaryPersonalActivityStats || as.secondaryPersonalActivityStats);
    });

  }

  getActivityForActivityResult(activityResult: IActivityResult): IActivity {
    return this.test.activities.find((a) => a.id === activityResult.activityId);
  }

  createChartData() {

    this.setCategoriesStats(this.stats.categoriesStats);

    this.activitiesChartData = [];

    for (const activityStats of this.stats.activitiesStats) {

      if (activityStats.primaryResultsStats) {

        this.activitiesChartData.push(
          {
            name: activityStats.activity.name,
            value: activityStats.primaryPersonalActivityStats.bestPlacementInPercents,
            extra: {
              activity: activityStats.activity
            }
          });
      }
    }


  }

  setCategoriesStats(categoriesStats: Array<PersonalCategoryStats>) {
    const primarySeries = [];
    const secondarySeries = [];

    for (const personalCategoryStats of categoriesStats) {

      if (personalCategoryStats.primaryCategoryResultsStats) {
        primarySeries.push({
          name: personalCategoryStats.category.name,
          value: personalCategoryStats.primaryCategoryResultsStats.averagePlacementInPercents,
          extra: {
            activity: personalCategoryStats.category
          }
        });
      }

      if (personalCategoryStats.secondaryCategoryResultsStats) {
        secondarySeries.push({
          name: personalCategoryStats.category.name,
          value: personalCategoryStats.secondaryCategoryResultsStats.averagePlacementInPercents,
          extra: {
            activity: personalCategoryStats.category
          }
        });
      }
    }

    if (primarySeries.length > 0) {
      this.primaryChartData = [
        {
          name: 'Hlavní výsledek',
          series: primarySeries
        }
      ];
    }

    if (secondarySeries.length > 0) {
      this.secondaryChartData = [
        {
          name: 'Vedlejší výsledek',
          series: secondarySeries
        }
      ];
    }

    this.registerPolarChartClickable();
  }

  selectActivity(event: any) {
    this.eventManager.broadcast({
      name: 'activityStatsSelected',
      content: event.extra.activity
    });
  }

  selectCategory(event: any) {
    console.log(event.extra.category.name);
  }

  getColorScheme(name): any {
    return colorSets.find(s => s.name === name);
  }

  private registerPolarChartClickable() {
    setTimeout(() => {
      $('.pie-label').css('cursor', 'pointer');
      $('.pie-label').on('click', (event) => {
        const categoryName = $(event.target).text().trim();
        const categoryStats = this.stats.categoriesStats.find((c) => c.category.name === categoryName);
        this.setCategoriesStats(categoryStats.childCategoryPersonalStats);
      });

      $('.polar-chart-background').css('cursor', 'pointer');
      $('.polar-chart-background').on('click', (event) => {
        this.setCategoriesStats(this.stats.categoriesStats);
      });
    }, 1000);

  }
}
