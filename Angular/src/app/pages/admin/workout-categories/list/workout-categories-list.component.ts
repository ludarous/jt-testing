import { Component, OnInit } from '@angular/core';
import {IWorkoutCategory} from '../../../../entities/workout-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {WorkoutCategoryService} from '../../../../services/workout-category.service';
import {Router} from '@angular/router';
import {IEvent} from '../../../../entities/event';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-list',
  templateUrl: './workout-categories-list.component.html',
  styleUrls: ['./workout-categories-list.component.scss']
})
export class WorkoutCategoriesListComponent implements OnInit {

  tableCols: Array<any>;
  testCategories: Array<IWorkoutCategory>;

  constructor(private WorkoutCategoryService: WorkoutCategoryService,
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
    const getCategories$ = this.WorkoutCategoryService.query();
    getCategories$.subscribe((categories: HttpResponse<Array<IWorkoutCategory>>) => {
      this.testCategories = categories.body;
    });
  }

  rowSelect(category: IWorkoutCategory) {
    this.router.navigate(['/admin/workout-categories/edit', category.id]);
  }

  delete(event, testCategory: IWorkoutCategory) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat kategorii ' + testCategory.name)) {
      this.WorkoutCategoryService.delete(testCategory.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Kategorii se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }

}
