import { Component, OnInit } from '@angular/core';
import {HttpResponse} from '@angular/common/http';
import {IActivity} from '../../../../entities/activity';
import {Router} from '@angular/router';
import {TestService} from '../../../../services/test.service';
import {ITest} from '../../../../entities/test';

@Component({
  selector: 'app-tests-list',
  templateUrl: './tests-list.component.html',
  styleUrls: ['./tests-list.component.scss']
})
export class TestsListComponent implements OnInit {

  tableCols: Array<any>;
  tests: Array<ITest>;

  constructor(private testService: TestService,
              private router: Router) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];

    this.testService.query().subscribe((testsResponse: HttpResponse<Array<ITest>>) => {
      this.tests = testsResponse.body;
    });
  }

  rowSelect(test: ITest) {
    this.router.navigate(['/admin/tests/edit', test.id]);
  }
}
