import { Component, OnInit } from '@angular/core';
import {IActivityGroupCategory} from '../../../../entities/activity-group-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityGroupCategoryService} from '../../../../services/activity-group-category.service';
import {Router} from '@angular/router';
import {IEvent} from '../../../../entities/event';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-list',
  templateUrl: './activity-group-categories-list.component.html',
  styleUrls: ['./activity-group-categories-list.component.scss']
})
export class ActivityGroupCategoriesListComponent implements OnInit {

  tableCols: Array<any>;
  testCategories: Array<IActivityGroupCategory>;

  constructor(private ActivityGroupCategoryService: ActivityGroupCategoryService,
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
    const getCategories$ = this.ActivityGroupCategoryService.query();
    getCategories$.subscribe((categories: HttpResponse<Array<IActivityGroupCategory>>) => {
      this.testCategories = categories.body;
    });
  }

  rowSelect(category: IActivityGroupCategory) {
    this.router.navigate(['/admin/activity-group-categories/edit', category.id]);
  }

  delete(event, testCategory: IActivityGroupCategory) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat kategorii ' + testCategory.name)) {
      this.ActivityGroupCategoryService.delete(testCategory.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Kategorii se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }

}
