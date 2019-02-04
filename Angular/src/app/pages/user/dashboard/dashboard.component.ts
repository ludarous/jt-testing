import {AfterContentInit, AfterViewInit, Component, OnInit} from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IWorkout} from '../../../entities/workout';
import {EventService} from '../../../services/event.service';
import {IEvent} from '../../../entities/event';
import {StatsRequest} from '../../../entities/stats-request';
import {PersonalCategoryStats, PersonalStats, Stats} from '../../../entities/stats';
import {StatsService} from '../../../services/stats.service';
import * as $ from 'jquery';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {zip} from 'rxjs';
import {ArrayUtils} from '../../../utils/array.utils';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {

  constructor(private eventService: EventService,
              private statsService: StatsService) { }

  events: Array<IEvent>;
  calendarEventsSources: Array<any>;

  calendarOptions: any;
  stats: PersonalStats;
  chartData: Array<any>;

  flattenedCategoriesStats: Array<PersonalCategoryStats>;

  ngOnInit() {
    this.load();
  }

  load() {
    const request = new StatsRequest();

    const getStats$ = this.statsService.findMyStats(request);
    const getEvents$ = this.eventService.query();

    zip(getStats$, getEvents$).subscribe(([statsResponse, eventsResponse]) => {
      this.stats = Stats.resolveResponse(statsResponse);

      this.flattenedCategoriesStats = ArrayUtils.flatten(this.stats.categoriesStats, 'childCategoryPersonalStats');
      this.setCategoriesStats(this.stats.categoriesStats);

      this.events = eventsResponse.body;
      this.calendarEventsSources = this.getCalendarEvents(this.events);

      this.calendarOptions = {
        eventSources: this.calendarEventsSources,
        header: {
          left: 'prev,next',
          center: 'title',
          right: ''
        },
        locale: 'cs',
        dateClick: (e) => {
          // handle date click
        },
        eventClick: (e) => {
          console.log(e);
        }
      };
    });

  }

  getCalendarEvents(events: Array<IEvent>): Array<any> {
    const missedEvents = events.filter((e) => new Date(e.date) <= new Date());
    const nextEvents = events.filter((e) => new Date(e.date) >= new Date());

    const eventSources = [];

    const missedEventsSource = {
      events: [],
      color: 'red',
      textColor: 'white'
    };

    for (const event of missedEvents) {
      missedEventsSource.events.push({
        title: event.name,
        start: event.date,
      });
    }
    eventSources.push(missedEventsSource);

    const nextEventsSource = {
      events: [],
      color: 'black',
      textColor: 'white'
    };

    for (const event of nextEvents) {
      nextEventsSource.events.push({
        title: event.name,
        start: event.date,
      });
    }
    eventSources.push(nextEventsSource);

    return eventSources;
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
    }

    if (primarySeries.length > 0) {
      const chartData = [
        {
          name: 'Hlavní výsledek',
          series: primarySeries
        }
      ];

      this.chartData = chartData;
    }


    this.registerPolarChartClickable();
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
