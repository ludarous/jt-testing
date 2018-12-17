import {Component, Input, OnInit, ViewChild} from '@angular/core';
import {ActivityStats, IActivity, PersonalActivityStats} from '../../../../entities/activity';
import {IActivityResult} from '../../../../entities/activity-result';
import {ActivityService} from '../../../../services/activity.service';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {EnumTranslatorService} from '../../../../shared/pipes/enum-translator/enum-translator';
import {ITest} from '../../../../entities/test';
import {IEvent} from '../../../../entities/event';
import {ActivityResultUnits} from '../../../../entities/enums/activity-result-units';
import {StatsRequest} from '../../../../entities/stats-request';
import {EventManager} from '../../../../services/event.manager';
import {MatExpansionModule, MatExpansionPanel} from '@angular/material';
import {StatsUtils} from '../../../../utils/stats-utils';
import {ChartUtils} from '../../../../utils/chart-utils';

@Component({
  selector: 'app-user-activity-result',
  templateUrl: './user-activity-result.component.html',
  styleUrls: ['./user-activity-result.component.scss']
})
export class UserActivityResultComponent implements OnInit {

  constructor(private activityService: ActivityService,
              private enumTranslatorService: EnumTranslatorService,
              private eventManager: EventManager) {
  }

  @Input()
  test: ITest;

  @Input()
  event: IEvent;

  @Input()
  activityStats: PersonalActivityStats;

  @ViewChild('expansionPanel')
  expansionPanel: MatExpansionPanel;

  activity: IActivity;
  activityResult: IActivityResult;

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

    if (this.activityStats.personalActivityResults && this.activityStats.personalActivityResults.length > 0) {
      this.activityResult = this.activityStats.personalActivityResults[0];
      this.activity = this.activityStats.activity;
      this.createChartData(this.activityStats, this.activityResult);
    }

    this.headerResultCardData = [
      {
        name: 'Výsledek',
        value: this.activityResult.primaryResultValue,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural'),
        }
      },
      {
        name: 'Vedlejší výsledek',
        value: this.activityResult.secondaryResultValue,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.secondaryResultValueUnit, 'plural'),
        }
      }

    ];

    this.eventManager.subscribe('activityStatsSelected', message => {
      const activity = <IActivity>message.content;
      if (activity.id === this.activity.id) {
        this.expansionPanel.expanded = true;
        this.expansionPanel._body.nativeElement.scrollIntoView({ block: 'start',  behavior: 'smooth' });
      }
    });
  }

  createChartData(activityStats: PersonalActivityStats, activityResult: IActivityResult) {

    const primaryPlacements = activityStats.personalActivityResultsStats.map(par => par.primaryPlacement);
    const primaryPlacementAverage = StatsUtils.average(primaryPlacements);
    const primaryCount = activityStats.activityResultsStats.primaryResultsCount;

    this.myPrimaryResultCardData = [
      {
        name: 'Můj výsledek',
        value: activityResult.primaryResultValue,
        extra: {
          unit: this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural'),
        }
      },
      {
        name: 'Pořadí v testu',
        value: Math.floor(primaryPlacementAverage * 100 / primaryCount),
        extra: {
          unit: '%',
          subtitle: primaryPlacementAverage + ' z ' + primaryCount
        }
      }
    ];

    if (this.activityResult.secondaryResultValue) {

      const secondaryPlacements = activityStats.personalActivityResultsStats.map(par => par.secondaryPlacement);
      const secondaryPlacementAverage = StatsUtils.average(secondaryPlacements);
      const secondaryCount = activityStats.activityResultsStats.secondaryResultsCount;

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
          value: Math.floor(secondaryPlacementAverage * 100 / secondaryCount),
          extra: {
            unit: '%',
            subtitle: secondaryPlacementAverage + ' z ' + secondaryCount
          }
        }
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
