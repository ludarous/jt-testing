import { Component, OnInit } from '@angular/core';
import {StatsRequest} from '../../../entities/stats-request';
import {HttpResponse} from '@angular/common/http';
import {ActivityStats, PersonalActivityStats} from '../../../entities/activity';
import {ActivityService} from '../../../services/activity.service';
import {ChartUtils} from '../../../utils/chart-utils';


export class ActivityStatsData {
  refLines: Array<any>;
  chartData: Array<any>;
  highlights: Array<any>;
}

@Component({
  selector: 'app-user-stats',
  templateUrl: './user-stats.component.html',
  styleUrls: ['./user-stats.component.scss']
})
export class UserStatsComponent implements OnInit {

  constructor(private activityService: ActivityService) { }

  activitiesStats: Array<PersonalActivityStats>;

  ngOnInit() {
    this.loadStats();
  }

  loadStats() {
    const request = new StatsRequest();

    this.activityService.findMyActivitiesStats(request).subscribe((activityStatsResponse: HttpResponse<Array<PersonalActivityStats>>) => {
      this.activitiesStats = ActivityStats.resolveArrayResponse(activityStatsResponse);
    });
  }


}
