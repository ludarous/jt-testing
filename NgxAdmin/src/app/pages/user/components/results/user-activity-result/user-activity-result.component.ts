import {Component, Input, OnInit, ViewChild} from '@angular/core';
import {IActivity} from '../../../../../entities/activity';
import {IActivityResult} from '../../../../../entities/activity-result';
import {ActivityService} from '../../../../../services/activity.service';
import {IWorkout} from '../../../../../entities/workout';
import {IEvent} from '../../../../../entities/event';
import {StatsRequest} from '../../../../../entities/stats-request';
import {EventManager} from '../../../../../services/event.manager';
import {MatExpansionPanel} from '@angular/material';
import {ResultType} from '../../../../../entities/enums/result-type';
import {PersonalActivityStats} from '../../../../../entities/stats';
import {EnumTranslatorService} from '../../../../../@theme/modules/enum-translator/enum-translator';
import {ChartUtils} from '../../../../../@core/utils/chart-utils';

@Component({
  selector: 'ngx-user-activity-result',
  templateUrl: './user-activity-result.component.html',
  styleUrls: ['./user-activity-result.component.scss']
})
export class UserActivityResultComponent implements OnInit {

  constructor(private activityService: ActivityService,
              private enumTranslatorService: EnumTranslatorService,
              private eventManager: EventManager) {
  }

  @Input()
  test: IWorkout;

  @Input()
  event: IEvent;

  @Input()
  activityStats: PersonalActivityStats;

  @ViewChild('expansionPanel')
  expansionPanel: MatExpansionPanel;

  activity: IActivity;

  headerResultCardData: object[];

  primaryChartData: object[];
  secondaryChartData: object[];

  myPrimaryResultCardData: object[];
  mySecondaryResultCardData: object[];
  primaryCardsData: object[];
  secondaryCardsData: object[];
  refLines: object[];
  selectedColorScheme: string;
  xLabel: string;

  ngOnInit() {

    this.activity = this.activityStats.activity;
    this.createChartData(this.activityStats);

    this.headerResultCardData = [];

    if (this.activityStats.primaryPersonalActivityStats) {
      this.headerResultCardData.push({
        name: 'Výsledek',
        value: this.activityStats.primaryPersonalActivityStats.bestValue,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural'),
        }
      });
    }

    if (this.activityStats.secondaryPersonalActivityStats) {
      this.headerResultCardData.push(
        {
          name: 'Vedlejší výsledek',
          value: this.activityStats.secondaryPersonalActivityStats.bestValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural'),
          }
        });
    }

    this.eventManager.subscribe('activityStatsSelected', message => {
      const activity = <IActivity>message.content;
      if (activity.id === this.activity.id) {
        this.expansionPanel.expanded = true;
        this.expansionPanel._body.nativeElement.scrollIntoView({block: 'start', behavior: 'smooth'});
      }
    });
  }

  createChartData(activityStats: PersonalActivityStats) {


    if (activityStats.primaryPersonalActivityStats) {

      const personalResultsStats = this.activityStats.primaryPersonalActivityStats;
      const primaryCount = activityStats.primaryResultsStats.resultsCount;

      this.myPrimaryResultCardData = [
        {
          name: 'Můj výsledek',
          value: personalResultsStats.bestValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural'),
          }
        },
        {
          name: 'Pořadí v testu',
          value: personalResultsStats.bestPlacementInPercents,
          extra: {
            unit: '%',
            subtitle: personalResultsStats.bestPlacement + ' z ' + primaryCount
          }
        }
      ];

      this.primaryChartData = [
        {
          name: activityStats.activity.name + ' - Hlavní výsledek',
          value: 0,
          series: [
            {
              name: 'Můj výsledek',
              value: personalResultsStats.bestValue
            },
            {
              name: 'Průměr v testu',
              value: activityStats.primaryResultsStats.resultsAverageValue
            },
            {
              name: 'Nejlepší výsledek v testu',
              value: ResultType.LESS_IS_BETTER.equals(this.activity.primaryResultType) ?
                activityStats.primaryResultsStats.resultsMinValue :
                activityStats.primaryResultsStats.resultsMaxValue
            },
            {
              name: 'Nejhorší výsledek v testu',
              value: ResultType.LESS_IS_BETTER.equals(this.activity.primaryResultType) ?
                activityStats.primaryResultsStats.resultsMaxValue :
                activityStats.primaryResultsStats.resultsMinValue
            }
          ]
        }
      ];
    }

    if (activityStats.secondaryPersonalActivityStats) {

      const personalResultsStats = this.activityStats.secondaryPersonalActivityStats;
      const secondaryCount = activityStats.secondaryResultsStats.resultsCount;

      this.mySecondaryResultCardData = [
        {
          name: 'Můj vedlejší výsledek',
          value: personalResultsStats.bestValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Pořadí v testu',
          value: personalResultsStats.bestPlacementInPercents,
          extra: {
            unit: '%',
            subtitle: personalResultsStats.bestPlacement + ' z ' + secondaryCount
          }
        }
      ];

      this.secondaryChartData = [
        {
          name: activityStats.activity.name + ' - Vedlejší výsledek',
          value: 0,
          series: [
            {
              name: 'Můj výsledek',
              value: personalResultsStats.bestValue
            },
            {
              name: 'Průměr v testu',
              value: activityStats.secondaryResultsStats.resultsAverageValue
            },
            {
              name: 'Nejlepší výsledek v testu',
              value: ResultType.LESS_IS_BETTER.equals(this.activity.secondaryResultType) ?
                activityStats.primaryResultsStats.resultsMinValue :
                activityStats.primaryResultsStats.resultsMaxValue
            },
            {
              name: 'Nejhorší výsledek v testu',
              value: ResultType.LESS_IS_BETTER.equals(this.activity.secondaryResultType) ?
                activityStats.primaryResultsStats.resultsMaxValue :
                activityStats.primaryResultsStats.resultsMinValue
            }
          ]
        }
      ];
    }

    if (activityStats.primaryResultsStats) {
      this.primaryCardsData = [
        {
          name: 'Průměr v testu',
          value: activityStats.primaryResultsStats.resultsAverageValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejlepší výsledek v testu',
          value: ResultType.LESS_IS_BETTER.equals(this.activity.primaryResultType) ?
            activityStats.primaryResultsStats.resultsMinValue :
            activityStats.primaryResultsStats.resultsMaxValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejhorší výsledek v testu',
          value: ResultType.LESS_IS_BETTER.equals(this.activity.primaryResultType) ?
            activityStats.primaryResultsStats.resultsMaxValue :
            activityStats.primaryResultsStats.resultsMinValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
          }
        }
      ];
    }

    if (activityStats.secondaryResultsStats) {
      this.secondaryCardsData = [
        {
          name: 'Průměr v testu',
          value: activityStats.secondaryResultsStats.resultsAverageValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejlepší výsledek v testu',
          value: ResultType.LESS_IS_BETTER.equals(this.activity.secondaryResultType) ?
            activityStats.secondaryResultsStats.resultsMinValue :
            activityStats.secondaryResultsStats.resultsMaxValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejhorší výsledek v testu',
          value: ResultType.LESS_IS_BETTER.equals(this.activity.secondaryResultType) ?
            activityStats.secondaryResultsStats.resultsMaxValue :
            activityStats.secondaryResultsStats.resultsMinValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        }
      ];
    }

    this.refLines = [{value: 60, name: 'Maximum'}, {value: 50, name: 'Average'}, {value: 20, name: 'Minimum'}];
    this.xLabel = this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural');
  }

  afterExpand(event: any) {
    this.loadStats();
  }

  loadStats() {
    const request = new StatsRequest();
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;
  }

  onLegendLabelClick(event: any) {

  }

  onSelect(event: any) {

  }

  getColorScheme(name): any {
    return ChartUtils.getColorScheme(name);
  }

  valueFormat(c): string {
    if (c.data && c.data.extra) {
      return c.value + ' ' + c.data.extra.unit;
    }
    return c.value;
  }


  statusLabelFormat(c): string {
    if (c.data && c.data.extra && c.data.extra.subtitle) {
      return `${c.label}<br/><small class="number-card-label">${c.data.extra.subtitle}</small>`;
    } else {
      return c.label;
    }
  }
}
