import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {Router} from '@angular/router';
import {TestService} from '../../../../services/test.service';
import {ITest} from '../../../../entities/test';
import {ITestCategory} from '../../../../entities/test-category';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-list',
  templateUrl: './tests-list.component.html',
  styleUrls: ['./tests-list.component.scss']
})
export class TestsListComponent implements OnInit {

  tableCols: Array<any>;
  tests: Array<ITest>;

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
    this.testService.query().subscribe((testsResponse: HttpResponse<Array<ITest>>) => {
      this.tests = testsResponse.body;
    });
  }

  rowSelect(test: ITest) {
    this.router.navigate(['/admin/tests/edit', test.id]);
  }

  delete(event, test: ITest) {
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
