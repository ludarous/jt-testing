import { Component, OnInit } from '@angular/core';
import {IActivityCategory} from '../../../../entities/activity-category';
import {TreeNode} from 'primeng/api';
import {HttpResponse} from '@angular/common/http';
import {ActivityCategoryService} from '../../../../services/activity-category.service';

@Component({
  selector: 'app-activity-categories-list',
  templateUrl: './activity-categories-list.component.html',
  styleUrls: ['./activity-categories-list.component.scss']
})
export class ActivityCategoriesListComponent implements OnInit {

  tableCols: Array<any>;
  categories: Array<IActivityCategory>;
  mainCategories: Array<IActivityCategory>;

  categoriesNodes: Array<TreeNode>;

  constructor(private activityCategoryService: ActivityCategoryService) { }

  ngOnInit() {

    this.load();

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];

  }

  load() {
    const getCategories$ = this.activityCategoryService.query({
      page: 0,
      size: 1000,
    });

    getCategories$.subscribe((categories: HttpResponse<Array<IActivityCategory>>) => {
      this.categories = categories.body;
      this.mainCategories = this.categories.filter(c => c.parentId == null);

      this.categoriesNodes = new Array<TreeNode>();
      for (const category of this.mainCategories) {
        this.categoriesNodes.push(this.createCategoryNode(category));
      }
      console.log(this.categoriesNodes);
    });
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
      expanded: (children && children.length > 0)
    };

    return treeNode;
  }

}
