import {Component, Input, OnInit} from '@angular/core';
import {ActivityStats, IActivity} from '../../../../entities/activity';
import {IActivityResult} from '../../../../entities/activity-result';
import {ActivityService} from '../../../../services/activity.service';
import {HttpResponse} from '@angular/common/http';

@Component({
  selector: 'app-user-activity-result',
  templateUrl: './user-activity-result.component.html',
  styleUrls: ['./user-activity-result.component.scss']
})
export class UserActivityResultComponent implements OnInit {

  constructor(private activityService: ActivityService) { }

  @Input()
  activity: IActivity;

  @Input()
  activityResult: IActivityResult;

  activityStats: ActivityStats;

  ngOnInit() {
    this.activityService.findStats(this.activityResult.activityId).subscribe((activityStatsResponse: HttpResponse<ActivityStats>) => {
      this.activityStats = activityStatsResponse.body;
    });
  }

}
