import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {ActivityCategory, IActivityCategory} from '../../../../entities/activity-category';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {ActivatedRoute, Router} from '@angular/router';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../../../../NgxAdmin/src/app/@core/utils/rxjs.utils';
import {MessageService, TreeNode} from 'primeng/api';
import {NbToastrService} from '@nebular/theme';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'ngx-activity-categories-edit',
  templateUrl: './activity-categories-edit.component.html',
  styleUrls: ['./activity-categories-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class ActivityCategoriesEditComponent implements OnInit {


  categoryId: number;
  category: IActivityCategory;
  categoryForm: FormGroup;

  categories: Array<IActivityCategory>;
  mainCategories: Array<IActivityCategory>;

  categoriesNodes: Array<TreeNode>;
  filteredCategoriesNodes: Array<TreeNode>;
  parentCategoryNode: TreeNode;

  private _categoriesFilter: string;
  get categoriesFilter(): string {
    return this._categoriesFilter;
  }

  set categoriesFilter(value: string) {
    this._categoriesFilter = value;
    this.filteredCategoriesNodes = this.categoriesNodes.filter(n => this.filterNode(n, value));
  }

  submitted = false;
  selectedStepperIndex = 0;

  constructor(private activityCategoryService: ActivityCategoryService,
              private activatedRoute: ActivatedRoute,
              private messageService: MessageService,
              private router: Router,
              private toasterService: NbToastrService,
              private translateService: TranslateService) {
  }

  ngOnInit() {
    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.categoryId = +params['id'];
      const getActivityCategory$ = this.getActivityCategory(this.categoryId);
      const getCategories$ = this.activityCategoryService.query({
        page: 0,
        size: 1000,
      });

      zip(getCategories$, getActivityCategory$).subscribe(([categories, category]) => {
        this.category = category;
        this.setCategoryForm(this.category);

        this.categories = categories.body;
        this.mainCategories = this.categories.filter(c => c.parentId == null);

        this.categoriesNodes = new Array<TreeNode>();
        for (const c of this.mainCategories) {
          this.categoriesNodes.push(this.createCategoryNode(c));
        }
        this.filteredCategoriesNodes = this.categoriesNodes;
      });

    });
  }

  setCategoryForm(category: IActivityCategory) {

    this.categoryForm = new FormGroup({
      id: new FormControl(category.id),
      name: new FormControl(category.name, [Validators.required]),
      description: new FormControl(category.description),
      key: new FormControl(category.key),
      parentId: new FormControl(category.parentId)
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


      saveCategory$.subscribe(
        (categoryResponse: HttpResponse<IActivityCategory>) => {
          this.category = categoryResponse.body;
          this.setCategoryForm(this.category);
          this.toasterService.success(null, this.translateService.instant('Kategorie uložena'));
          this.router.navigate(['/pages/admin/activity-categories/list']);
        },
        (errorResponse: HttpErrorResponse) => {
          this.toasterService.danger(null, this.translateService.instant('Kategorie nebyla uložena'));
        });
    }
  }

  nodeSelect(event: any) {
    if (event.node && event.node.data) {
      this.categoryForm.controls['parentId'].setValue(event.node.data.id);
    }
  }

  getActivityCategory(activityCategoryId: number): Observable<IActivityCategory> {
    if (activityCategoryId) {
      return this.activityCategoryService.find(activityCategoryId).pipe(map((activityCategoryResponse: HttpResponse<IActivityCategory>) => {
        return activityCategoryResponse.body;
      }));

    } else {
      return RxjsUtils.create(new ActivityCategory());
    }
  }

  createCategoryNode(category: IActivityCategory): TreeNode {
    const children = Array<TreeNode>();
    if (category.children && category.children.length > 0) {
      for (const child of category.children) {
        children.push(this.createCategoryNode(child));
      }
    }

    const treeNode = {
      data: category,
      children: children,
      leaf: !(children && children.length > 0),
      expanded: false // (children && children.length > 0)
    };

    return treeNode;
  }

  filterNode(node: TreeNode, query: string): boolean {

    if (query === '') node.expanded = false;
    if (node.data) {
      const category = <IActivityCategory>node.data;

      if (category.name.includes(query)) {
        return true;
      }

      for (const ch of node.children) {
        const containsChild = this.filterNode(ch, query);
        if (containsChild) node.expanded = true;
        return containsChild;
      }
    }
  }

}