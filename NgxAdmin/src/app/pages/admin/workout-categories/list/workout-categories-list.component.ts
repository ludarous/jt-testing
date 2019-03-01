import { Component, OnInit } from '@angular/core';
import {IWorkoutCategory} from '../../../../entities/workout-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {WorkoutCategoryService} from '../../../../services/workout-category.service';
import {Router} from '@angular/router';
import {MessageService} from 'primeng/api';
import {IWorkout} from '../../../../entities/workout';

@Component({
  selector: 'ngx-test-categories-list',
  templateUrl: './workout-categories-list.component.html',
  styleUrls: ['./workout-categories-list.component.scss']
})
export class WorkoutCategoriesListComponent implements OnInit {

  tableCols: Array<any>;
  workoutCategories: Array<IWorkoutCategory>;

  constructor(private workoutCategoryService: WorkoutCategoryService,
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
    const getCategories$ = this.workoutCategoryService.query();
    getCategories$.subscribe((categories: HttpResponse<Array<IWorkoutCategory>>) => {
      this.workoutCategories = categories.body;
    });
  }

  rowSelect(category: IWorkoutCategory) {
    this.edit(category);
  }

  delete(workoutCategory: IWorkoutCategory) {

    if (confirm('Opravdu chceš smazat kategorii ' + workoutCategory.name)) {
      this.workoutCategoryService.delete(workoutCategory.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Kategorii se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }

  edit(category: IWorkoutCategory) {
    this.router.navigate(['/pages/admin/workout-categories/edit', category.id]);
  }

  create() {
    this.router.navigate(['/pages/admin/workout-categories/create']);
  }

}
