import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {ActivityService} from '../../../../services/activity.service';

@Component({
  selector: 'app-activities',
  templateUrl: './activities-list.component.html',
  styleUrls: ['./activities-list.component.scss']
})
export class ActivitiesListComponent implements OnInit {

  tableCols: Array<any>;
  activities: Array<IActivity>;

  constructor(private activityService: ActivityService) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
      { field: 'help', header: 'Nápověda' },
    ];

    this.activityService.query().subscribe((activities: HttpResponse<Array<IActivity>>) => {
      this.activities = activities.body;
    });
  }

}
