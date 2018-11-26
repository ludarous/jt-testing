import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {ActivityService} from '../../../../services/activity.service';
import {Router} from '@angular/router';

@Component({
  selector: 'app-activities-list',
  templateUrl: './activities-list.component.html',
  styleUrls: ['./activities-list.component.scss']
})
export class ActivitiesListComponent implements OnInit {

  tableCols: Array<any>;
  activities: Array<IActivity>;

  constructor(private activityService: ActivityService,
              private router: Router) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
      { field: 'help', header: 'Nápověda' },
    ];

    this.activityService.query({
      page: 0,
      size: 1000,
    }).subscribe((activities: HttpResponse<Array<IActivity>>) => {
      this.activities = activities.body;
    });
  }

  rowSelect(activity: IActivity) {
    this.router.navigate(['/admin/activities/edit', activity.id]);
  }
}
