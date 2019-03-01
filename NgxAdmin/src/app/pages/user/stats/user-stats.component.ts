import { Component, OnInit } from '@angular/core';
import {StatsRequest} from '../../../entities/stats-request';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityService} from '../../../services/activity.service';
import {StatsService} from '../../../services/stats.service';
import {PersonalActivityStats, PersonalStats, Stats} from '../../../entities/stats';


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

  constructor(private activityService: ActivityService,
              private statsService: StatsService) { }

  personalStats: PersonalStats;
  filteredPersonalActivitiesStats: Array<PersonalActivityStats>;


  ngOnInit() {
    this.loadStats();
  }

  loadStats() {
    const request = new StatsRequest();

    this.statsService.findMyStats(request).subscribe((statsResponse: HttpResponse<PersonalStats>) => {
      this.personalStats = Stats.resolveResponse(statsResponse);
      this.filteredPersonalActivitiesStats = this.personalStats.activitiesStats
        .filter(as => as.secondaryPersonalActivityStats || as.primaryPersonalActivityStats);
    });
  }


}
