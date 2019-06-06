import {Component, Input, OnInit} from '@angular/core';
import {IWorkout} from '../../../../entities/workout';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {IActivityResult} from '../../../../entities/activity-result';
import {IActivity} from '../../../../entities/activity';
import {IEvent} from '../../../../entities/event';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {StatsRequest} from '../../../../entities/stats-request';
import {WorkoutService} from '../../../../services/workout.service';
import {EventManager} from '../../../../services/event.manager';
import {StatsService} from '../../../../services/stats.service';
import {PersonalActivityStats, PersonalCategoryStats, PersonalStats, Stats} from '../../../../entities/stats';
import * as $ from 'jquery';
import {ArrayUtils} from '../../../../utils/array.utils';

@Component({
  selector: 'app-user-test-result',
  templateUrl: './user-workout-result.component.html',
  styleUrls: ['./user-workout-result.component.scss']
})
export class UserWorkoutResultComponent implements OnInit {

  constructor(private categoryService: ActivityCategoryService,
              private workoutService: WorkoutService,
              private statsService: StatsService,
              private eventManager: EventManager) { }

  @Input()
  test: IWorkout;

  @Input()
  workoutResult: IWorkoutResult;

  @Input()
  event: IEvent;

  stats: PersonalStats;
  filteredActivitiesStats: Array<PersonalActivityStats>;
  primaryChartData: object[];
  secondaryChartData: object[];
  activitiesChartData: object[];

  flattenedCategoriesStats: Array<PersonalCategoryStats>;

  ngOnInit() {
    const request = new StatsRequest();
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;

    this.statsService.findMyStats(request).subscribe((testStatsResponse: HttpResponse<PersonalStats>) => {
      console.log(testStatsResponse.body);
      this.stats = Stats.resolveResponse(testStatsResponse);
      this.flattenedCategoriesStats = ArrayUtils.flatten(this.stats.categoriesStats, 'childCategoryPersonalStats');

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
        const categoryStats = this.flattenedCategoriesStats.find((c) => c.category.name === categoryName);
        this.setCategoriesStats(categoryStats.childCategoryPersonalStats);
      });

      $('.polar-chart-background').css('cursor', 'pointer');
      $('.polar-chart-background').on('click', (event) => {
        this.setCategoriesStats(this.stats.categoriesStats);
      });
    }, 1000);

  }
}
