import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {IWorkoutCategory, WorkoutCategory} from '../../../../entities/workout-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {WorkoutCategoryService} from '../../../../services/workout-category.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../../../../NgxAdmin/src/app/@core/utils/rxjs.utils';
import {ActivatedRoute, Router} from '@angular/router';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-edit',
  templateUrl: './workout-categories-edit.component.html',
  styleUrls: ['./workout-categories-edit.component.scss']
})
export class WorkoutCategoriesEditComponent implements OnInit {

  testCategoryId: number;
  testCategory: IWorkoutCategory;
  testCategoryForm: FormGroup;

  constructor(private workoutCategoryService: WorkoutCategoryService,
              private activatedRoute: ActivatedRoute,
              private messageService: MessageService,
              private router: Router) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.testCategoryId = +params['id'];
      const getTestCategory$ = this.getTestCategory(this.testCategoryId);

      getTestCategory$.subscribe((testCategory: IWorkoutCategory) => {
        this.testCategory = testCategory;
        this.setCategoryForm(this.testCategory);
      });

    });
  }

  setCategoryForm(category: IWorkoutCategory) {

    this.testCategoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.testCategoryForm.valid) {

      const categoryToSave = <IWorkoutCategory>this.testCategoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.workoutCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.workoutCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe(
        (categoryResponse: HttpResponse<IWorkoutCategory>) => {
          this.testCategory = categoryResponse.body;
          this.messageService.add({severity: 'success', summary: 'Kategorie uložena'});
          this.router.navigate(['/admin/workout-categories/list']);
        },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Kategorie nebyla uložena', detail: errorResponse.error.detail});
        });
    }
  }

  getTestCategory(testCategoryId: number): Observable<IWorkoutCategory> {
    if (testCategoryId) {
      return this.workoutCategoryService.find(testCategoryId).pipe(map((testCategoryResponse: HttpResponse<IWorkoutCategory>) => {
        return testCategoryResponse.body;
      }));

    } else {
      return RxjsUtils.create(new WorkoutCategory());
    }
  }
}
