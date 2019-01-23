import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {ITestCategory, TestCategory} from '../../../../entities/test-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {TestCategoryService} from '../../../../services/test-category.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {ActivatedRoute, Router} from '@angular/router';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-test-categories-edit',
  templateUrl: './test-categories-edit.component.html',
  styleUrls: ['./test-categories-edit.component.scss']
})
export class TestCategoriesEditComponent implements OnInit {

  testCategoryId: number;
  testCategory: ITestCategory;
  testCategoryForm: FormGroup;

  constructor(private testCategoryService: TestCategoryService,
              private activatedRoute: ActivatedRoute,
              private messageService: MessageService,
              private router: Router) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.testCategoryId = +params['id'];
      const getTestCategory$ = this.getTestCategory(this.testCategoryId);

      getTestCategory$.subscribe((testCategory: ITestCategory) => {
        this.testCategory = testCategory;
        this.setCategoryForm(this.testCategory);
      });

    });
  }

  setCategoryForm(category: ITestCategory) {

    this.testCategoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.testCategoryForm.valid) {

      const categoryToSave = <ITestCategory>this.testCategoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.testCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.testCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe(
        (categoryResponse: HttpResponse<ITestCategory>) => {
          this.testCategory = categoryResponse.body;
          this.messageService.add({severity: 'success', summary: 'Kategorie uložena'});
          this.router.navigate(['/admin/test-categories/list']);
        },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Kategorie nebyla uložena', detail: errorResponse.error.detail});
        });
    }
  }

  getTestCategory(testCategoryId: number): Observable<ITestCategory> {
    if (testCategoryId) {
      return this.testCategoryService.find(testCategoryId).pipe(map((testCategoryResponse: HttpResponse<ITestCategory>) => {
        return testCategoryResponse.body;
      }));

    } else {
      return RxjsUtils.create(new TestCategory());
    }
  }
}
