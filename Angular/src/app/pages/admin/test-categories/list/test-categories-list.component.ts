import { Component, OnInit } from '@angular/core';
import {ITestCategory} from '../../../../entities/test-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {TestCategoryService} from '../../../../services/test-category.service';
import {Router} from '@angular/router';
import {IEvent} from '../../../../entities/event';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-list',
  templateUrl: './test-categories-list.component.html',
  styleUrls: ['./test-categories-list.component.scss']
})
export class TestCategoriesListComponent implements OnInit {

  tableCols: Array<any>;
  testCategories: Array<ITestCategory>;

  constructor(private testCategoryService: TestCategoryService,
              private router: Router,
              private messageService: MessageService) { }

  ngOnInit() {
    this.load();

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];
  }

  load() {
    const getCategories$ = this.testCategoryService.query();
    getCategories$.subscribe((categories: HttpResponse<Array<ITestCategory>>) => {
      this.testCategories = categories.body;
    });
  }

  rowSelect(category: ITestCategory) {
    this.router.navigate(['/admin/test-categories/edit', category.id]);
  }

  delete(event, testCategory: ITestCategory) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat kategorii ' + testCategory.name)) {
      this.testCategoryService.delete(testCategory.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Kategorii se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }

}
