import {Component, Input, OnInit} from '@angular/core';
import {ActivityStats, IActivity} from '../../../../entities/activity';
import {IActivityResult} from '../../../../entities/activity-result';
import {ActivityService} from '../../../../services/activity.service';
import {HttpResponse} from '@angular/common/http';
import {colorSets} from '@swimlane/ngx-charts/release/utils';
import {EnumTranslatorService} from '../../../../shared/pipes/enum-translator/enum-translator';

@Component({
  selector: 'app-user-activity-result',
  templateUrl: './user-activity-result.component.html',
  styleUrls: ['./user-activity-result.component.scss']
})
export class UserActivityResultComponent implements OnInit {

  constructor(private activityService: ActivityService,
              private enumTranslatorService: EnumTranslatorService) { }

  @Input()
  activity: IActivity;

  @Input()
  activityResult: IActivityResult;

  activityStats: ActivityStats;

  chartData: object[];

  myResultsCardData: object[];
  primaryCardsData: object[];
  secondaryCardsData: object[];
  refLines: object[];
  selectedColorScheme: string;
  colorScheme: any;
  xLabel: string;

  ngOnInit() {
    this.activityService.findStats(this.activityResult.activityId).subscribe((activityStatsResponse: HttpResponse<ActivityStats>) => {
      this.activityStats = activityStatsResponse.body;
      this.createChartData(this.activityStats, this.activityResult);
    });
  }

  createChartData(activityStats: ActivityStats, activityResult: IActivityResult) {

    this.myResultsCardData = [
      {
        name: 'Můj výsledek',
        value: activityResult.primaryResultValue
      },
    ]

    if (this.activityResult.secondaryResultValue) {
      this.myResultsCardData.push(
        {
          name: 'Můj vedlejší výsledek',
          value: activityResult.secondaryResultValue
        }
      );
    }

    this.primaryCardsData = [
      {
        name: 'Průměr v testu',
        value: activityStats.virtualStats.primaryAverage
      },
      {
        name: 'Nejlepší výsledek v testu',
        value: activityStats.virtualStats.primaryMax
      },
      {
        name: 'Nejhorší výsledek v testu',
        value: activityStats.virtualStats.primaryMin
      }
    ];

    this.secondaryCardsData = [
      {
        name: 'Průměr v testu',
        value: activityStats.virtualStats.secondaryAverage
      },
      {
        name: 'Nejlepší výsledek v testu',
        value: activityStats.virtualStats.secondaryMax
      },
      {
        name: 'Nejhorší výsledek v testu',
        value: activityStats.virtualStats.secondaryMin
      }
    ];

    this.chartData = [
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
            value: activityStats.virtualStats.primaryAverage
          },
          {
            name: 'Nejlepší výsledek v testu',
            value: activityStats.virtualStats.primaryMax
          },
          {
            name: 'Nejhorší výsledek v testu',
            value: activityStats.virtualStats.primaryMin
          }
        ]
      }
    ];

    if (this.activity.secondaryResultValueUnit && this.activityResult.secondaryResultValue) {
      this.chartData.push({
        name: activityResult.activityName + ' - Vedlejší výsledek',
        value: 0,
        series: [
          {
            name: 'Můj výsledek',
            value: activityResult.secondaryResultValue
          },
          {
            name: 'Průměr v testu',
            value: activityStats.virtualStats.secondaryAverage
          },
          {
            name: 'Nejlepší výsledek v testu',
            value: activityStats.virtualStats.secondaryMax
          },
          {
            name: 'Nejhorší výsledek v testu',
            value: activityStats.virtualStats.secondaryMin
          }
        ]
      });
    }

    this.refLines = [{ value: 60, name: 'Maximum' }, { value: 50, name: 'Average' }, { value: 20, name: 'Minimum' }];

    this.setColorScheme('cool');

    this.xLabel = this.enumTranslatorService.translate(this.activity.primaryResultValueUnit, 'plural');
  }

  onLegendLabelClick(event: any) {

  }

  onSelect(event: any) {

  }

  setColorScheme(name) {
    this.selectedColorScheme = name;
    this.colorScheme = colorSets.find(s => s.name === name);
  }
}
