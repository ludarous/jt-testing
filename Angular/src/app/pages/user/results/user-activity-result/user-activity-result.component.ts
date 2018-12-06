import {Component, Input, OnInit} from '@angular/core';
import {ActivityStats, ActivityStatsRequest, IActivity, PersonalActivityStats} from '../../../../entities/activity';
import {IActivityResult} from '../../../../entities/activity-result';
import {ActivityService} from '../../../../services/activity.service';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {EnumTranslatorService} from '../../../../shared/pipes/enum-translator/enum-translator';
import {ITest} from '../../../../entities/test';
import {IEvent} from '../../../../entities/event';
import {ActivityResultUnits} from '../../../../entities/enums/activity-result-units';

@Component({
  selector: 'app-user-activity-result',
  templateUrl: './user-activity-result.component.html',
  styleUrls: ['./user-activity-result.component.scss']
})
export class UserActivityResultComponent implements OnInit {

  constructor(private activityService: ActivityService,
              private enumTranslatorService: EnumTranslatorService) {
  }

  @Input()
  activity: IActivity;

  @Input()
  activityResult: IActivityResult;

  @Input()
  test: ITest;

  @Input()
  event: IEvent;

  activityStats: PersonalActivityStats;

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
    const request = new ActivityStatsRequest();
    request.activityId = this.activityResult.activityId;
    request.testId = this.test ? this.test.id : null;
    request.eventId = this.event ? this.event.id : null;

    this.activityService.findMyStats(request).subscribe((activityStatsResponse: HttpResponse<PersonalActivityStats>) => {
      this.activityStats = activityStatsResponse.body;
      this.createChartData(this.activityStats, this.activityResult);
    });
  }

  createChartData(activityStats: PersonalActivityStats, activityResult: IActivityResult) {



    this.myPrimaryResultCardData = [
      {
        name: 'Můj výsledek',
        value: activityResult.primaryResultValue,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
        }
      },
      {
        name: 'Pořadí v testu',
        value: Math.floor(activityStats.personalActivityResultsStats.primaryPlacement * 100 / activityStats.activityResultsStats.primaryResultsCount),
        extra: {
          unit: '%'
        }
      },
    ];

    if (this.activityResult.secondaryResultValue) {
      this.mySecondaryResultCardData = [
        {
          name: 'Můj vedlejší výsledek',
          value: activityResult.secondaryResultValue,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Pořadí v testu',
          value: Math.floor(activityStats.personalActivityResultsStats.secondaryPlacement * 100 / activityStats.activityResultsStats.secondaryResultsCount),
          extra: {
            unit: '%'
          }
        },
        ];
    }

    this.primaryCardsData = [
      {
        name: 'Průměr v testu',
        value: activityStats.activityResultsStats.primaryAverage,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
        }
      },
      {
        name: 'Nejlepší výsledek v testu',
        value: activityStats.activityResultsStats.primaryMax,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
        }
      },
      {
        name: 'Nejhorší výsledek v testu',
        value: activityStats.activityResultsStats.primaryMin,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural')
        }
      }
    ];

    if (activityStats.activityResultsStats.secondaryMin && activityStats.activityResultsStats.secondaryMax) {
      this.secondaryCardsData = [
        {
          name: 'Průměr v testu',
          value: activityStats.activityResultsStats.secondaryAverage,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejlepší výsledek v testu',
          value: activityStats.activityResultsStats.secondaryMax,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        },
        {
          name: 'Nejhorší výsledek v testu',
          value: activityStats.activityResultsStats.secondaryMin,
          extra: {
            unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural')
          }
        }
      ];
    }

    this.primaryChartData = [
      {
        name: activityResult.activityName + ' - Hlavní výsledek',
        value: 0,
        series: [
          {
            name: 'Můj výsledek',
            value: activityResult.primaryResultValue
          },
          {
            name: 'Průměr v testu',
            value: activityStats.activityResultsStats.primaryAverage
          },
          {
            name: 'Nejlepší výsledek v testu',
            value: activityStats.activityResultsStats.primaryMax
          },
          {
            name: 'Nejhorší výsledek v testu',
            value: activityStats.activityResultsStats.primaryMin
          }
        ]
      }
    ];

    if (this.activity.secondaryResultValueUnit && this.activityResult.secondaryResultValue) {
      this.secondaryChartData = [
        {
          name: activityResult.activityName + ' - Vedlejší výsledek',
          value: 0,
          series: [
            {
              name: 'Můj výsledek',
              value: activityResult.secondaryResultValue
            },
            {
              name: 'Průměr v testu',
              value: activityStats.activityResultsStats.secondaryAverage
            },
            {
              name: 'Nejlepší výsledek v testu',
              value: activityStats.activityResultsStats.secondaryMax
            },
            {
              name: 'Nejhorší výsledek v testu',
              value: activityStats.activityResultsStats.secondaryMin
            }
          ]
        }
      ];
    }

    this.refLines = [{value: 60, name: 'Maximum'}, {value: 50, name: 'Average'}, {value: 20, name: 'Minimum'}];

    this.xLabel = this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural');
  }

  onLegendLabelClick(event: any) {

  }

  onSelect(event: any) {

  }

  getColorScheme(name): any {
    return colorSets.find(s => s.name === name);
  }

  valueFormat(c): string {
    if (c.data && c.data.extra) {
      return c.value + ' ' + c.data.extra.unit;
    }
    return c.value;
  }


  statusLabelFormat(c): string {
    return `${c.label}<br/><small class="number-card-label">This week</small>`;
  }
}
