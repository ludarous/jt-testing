import { Component, OnInit } from '@angular/core';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {HttpResponse} from '@angular/common/http';
import {ActivityCategory, IActivityCategory} from '../../../../entities/activity-category';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {ITestCategory, TestCategory} from '../../../../entities/test-category';
import {TestCategoryService} from '../../../../services/test-category.service';

@Component({
  selector: 'app-tests-categories',
  templateUrl: './test-categories.component.html',
  styleUrls: ['./test-categories.component.scss']
})
export class TestCategoriesComponent implements OnInit {

  tableCols: Array<any>;
  categories: Array<ITestCategory>;
  selectedCategory: ITestCategory;

  categoryForm: FormGroup;

  constructor(private testCategoryService: TestCategoryService) { }

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
      this.categories = categories.body;
    });
  }

  rowSelect(category: ITestCategory) {
    this.selectedCategory = category;
    this.setCategoryForm(category);
  }

  setCategoryForm(category: ITestCategory) {

    this.categoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.categoryForm.valid) {

      const categoryToSave = <ITestCategory>this.categoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.testCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.testCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe((categoryResponse: HttpResponse<ITestCategory>) => {
        this.selectedCategory = categoryResponse.body;
        this.load();
      });
    }
  }

  addCategory() {
    this.setCategoryForm(new TestCategory());
  }

}
