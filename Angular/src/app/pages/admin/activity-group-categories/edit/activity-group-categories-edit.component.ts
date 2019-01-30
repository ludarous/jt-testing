import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {IActivityGroupCategory, ActivityGroupCategory} from '../../../../entities/activity-group-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityGroupCategoryService} from '../../../../services/activity-group-category.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {ActivatedRoute, Router} from '@angular/router';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-edit',
  templateUrl: './activity-group-categories-edit.component.html',
  styleUrls: ['./activity-group-categories-edit.component.scss']
})
export class ActivityGroupCategoriesEditComponent implements OnInit {

  testCategoryId: number;
  testCategory: IActivityGroupCategory;
  testCategoryForm: FormGroup;

  constructor(private activityGroupCategoryService: ActivityGroupCategoryService,
              private activatedRoute: ActivatedRoute,
              private messageService: MessageService,
              private router: Router) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.testCategoryId = +params['id'];
      const getTestCategory$ = this.getTestCategory(this.testCategoryId);

      getTestCategory$.subscribe((testCategory: IActivityGroupCategory) => {
        this.testCategory = testCategory;
        this.setCategoryForm(this.testCategory);
      });

    });
  }

  setCategoryForm(category: IActivityGroupCategory) {

    this.testCategoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.testCategoryForm.valid) {

      const categoryToSave = <IActivityGroupCategory>this.testCategoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.activityGroupCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.activityGroupCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe(
        (categoryResponse: HttpResponse<IActivityGroupCategory>) => {
          this.testCategory = categoryResponse.body;
          this.messageService.add({severity: 'success', summary: 'Kategorie uložena'});
          this.router.navigate(['/admin/activity-group-categories/list']);
        },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Kategorie nebyla uložena', detail: errorResponse.error.detail});
        });
    }
  }

  getTestCategory(testCategoryId: number): Observable<IActivityGroupCategory> {
    if (testCategoryId) {
      return this.activityGroupCategoryService.find(testCategoryId).pipe(map((testCategoryResponse: HttpResponse<IActivityGroupCategory>) => {
        return testCategoryResponse.body;
      }));

    } else {
      return RxjsUtils.create(new ActivityGroupCategory());
    }
  }
}
