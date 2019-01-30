import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {ActivityGroupService} from '../../../../services/activity-group.service';
import {IActivityGroup} from '../../../../entities/activity-group';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-list',
  templateUrl: './activity-groups-list.component.html',
  styleUrls: ['./activity-groups-list.component.scss']
})
export class ActivityGroupsListComponent implements OnInit {

  tableCols: Array<any>;
  tests: Array<IActivityGroup>;

  constructor(private ActivityGroupService: ActivityGroupService,
              private router: Router,
              private messageService: MessageService) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];
    this.load();
  }

  load() {
    this.ActivityGroupService.query().subscribe((testsResponse: HttpResponse<Array<IActivityGroup>>) => {
      this.tests = testsResponse.body;
    });
  }

  rowSelect(test: IActivityGroup) {
    this.router.navigate(['/admin/tests/edit', test.id]);
  }

  delete(event, test: IActivityGroup) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat test ' + test.name)) {
      this.ActivityGroupService.delete(test.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Test se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }
}
