import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {TestService} from '../../../../services/test.service';
import {IActivityGroup} from '../../../../entities/activity-group';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-list',
  templateUrl: './tests-list.component.html',
  styleUrls: ['./tests-list.component.scss']
})
export class TestsListComponent implements OnInit {

  tableCols: Array<any>;
  tests: Array<IActivityGroup>;

  constructor(private testService: TestService,
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
    this.testService.query().subscribe((testsResponse: HttpResponse<Array<IActivityGroup>>) => {
      this.tests = testsResponse.body;
    });
  }

  rowSelect(test: IActivityGroup) {
    this.router.navigate(['/admin/tests/edit', test.id]);
  }

  delete(event, test: IActivityGroup) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat test ' + test.name)) {
      this.testService.delete(test.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Test se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }
}
