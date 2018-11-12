import { Component, OnInit } from '@angular/core';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {HttpResponse} from '@angular/common/http';
import {ActivityCategory, IActivityCategory} from '../../../../entities/activity-category';
import {Activity, IActivity} from '../../../../entities/activity';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {CustomValidators} from '../../../../shared/validators/custom-validators';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {

  tableCols: Array<any>;
  categories: Array<IActivityCategory>;
  selectedCategory: IActivityCategory;

  categoryForm: FormGroup;

  constructor(private activityCategoryService: ActivityCategoryService) { }

  ngOnInit() {
   this.load();

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];
  }

  load() {
    const getCategories$ = this.activityCategoryService.query();
    getCategories$.subscribe((categories: HttpResponse<Array<IActivityCategory>>) => {
      this.categories = categories.body;
    });
  }

  rowSelect(category: IActivityCategory) {
    this.selectedCategory = category;
    this.setCategoryForm(category);
  }

  setCategoryForm(category: IActivityCategory) {

    this.categoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
    });
  }

  saveCategory() {
    if (this.categoryForm.valid) {

      const categoryToSave = <IActivityCategory>this.categoryForm.value;
      let saveCategory$;
      if (categoryToSave.id) {
        saveCategory$ = this.activityCategoryService.update(categoryToSave);
      } else {
        saveCategory$ = this.activityCategoryService.create(categoryToSave);
      }


      saveCategory$.subscribe((categoryResponse: HttpResponse<IActivityCategory>) => {
        this.selectedCategory = categoryResponse.body;
        this.load();
      });
    }
  }

  addCategory() {
    this.setCategoryForm(new ActivityCategory());
  }

}
