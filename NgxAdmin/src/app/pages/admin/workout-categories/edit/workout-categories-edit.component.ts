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
import {NbToastrService} from '@nebular/theme';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'ngx-workout-categories-edit',
  templateUrl: './workout-categories-edit.component.html',
  styleUrls: ['./workout-categories-edit.component.scss']
})
export class WorkoutCategoriesEditComponent implements OnInit {

  workoutCategoryId: number;
  workoutCategory: IWorkoutCategory;
  workoutCategoryForm: FormGroup;

  submitted = false;

  constructor(private workoutCategoryService: WorkoutCategoryService,
              private activatedRoute: ActivatedRoute,
              private messageService: MessageService,
              private toasterService: NbToastrService,
              private translateService: TranslateService,
              private router: Router) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.workoutCategoryId = +params['id'];
      const getTestCategory$ = this.getTestCategory(this.workoutCategoryId);

      getTestCategory$.subscribe((testCategory: IWorkoutCategory) => {
        this.workoutCategory = testCategory;
        this.setCategoryForm(this.workoutCategory);
      });

    });
  }

  setCategoryForm(category: IWorkoutCategory) {

    this.workoutCategoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.workoutCategoryForm.valid) {

      const categoryToSave = <IWorkoutCategory>this.workoutCategoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.workoutCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.workoutCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe(
        (categoryResponse: HttpResponse<IWorkoutCategory>) => {
          this.workoutCategory = categoryResponse.body;
          this.toasterService.success(null, this.translateService.instant('Kategorie uložena'));
          this.router.navigate(['/pages/admin/workout-categories/list']);
        },
        (errorResponse: HttpErrorResponse) => {
          this.toasterService.danger(null, this.translateService.instant('Kategorie nebyla uložena'));
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
