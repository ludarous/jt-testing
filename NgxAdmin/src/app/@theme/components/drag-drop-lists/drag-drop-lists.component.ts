import {Component, ContentChild, Input, OnInit, TemplateRef} from '@angular/core';
import {IActivity} from '../../../entities/activity';
import {ArrayUtils} from '../../../@core/utils/array.utils';

@Component({
  selector: 'ngx-drag-drop-lists',
  templateUrl: './drag-drop-lists.component.html',
  styleUrls: ['./drag-drop-lists.component.scss']
})
export class DragDropListsComponent implements OnInit {

  constructor() {
  }

  @Input()
  sourceHeading: string;

  @Input()
  sourceFilter: boolean;

  @Input()
  sourceFilterPlaceholder: string;

  @Input()
  sourceData: Array<any>;

  @Input()
  sourceFilterCallback: (item: any, filter: string) => boolean;

  private _sourceFilterQuery: string;
  @Input()
  get sourceFilterQuery(): string {
    return this._sourceFilterQuery;
  }

  set sourceFilterQuery(value: string) {
    this._sourceFilterQuery = value;
    this.filterSourceData();
  }

  @Input()
  targetHeading: string;

  @Input()
  targetFilter: boolean;

  @Input()
  filterFields: string[];

  @Input()
  targetFilterPlaceholder: string;

  @Input()
  targetData: Array<any>;

  @Input()
  targetFilterCallback: (item: any, filter: string) => boolean;

  @ContentChild(TemplateRef)
  @Input()
  layoutTemplate: TemplateRef<any>;

  private _targetFilterQuery: string;
  @Input()
  get targetFilterQuery(): string {
    return this._targetFilterQuery;
  }

  set targetFilterQuery(value: string) {
    this._targetFilterQuery = value;
    this.filterTargetData();
  }

  private draggedItem: any;

  suggestedSourceData: Array<any> = new Array<any>();
  suggestedTargetData: Array<any> = new Array<any>();


  ngOnInit() {
    this.sourceData = this.sourceData.filter((a) => !this.targetData.some((sa) => sa.id === a.id));
    this.filterSourceData();
    this.filterTargetData();
  }

  /* DRAG n DROP */

  sourceDragStart($event, item: any) {
    this.draggedItem = item;
  }

  sourceDragEnd($event) {
    this.draggedItem = null;
  }

  sourceDrop($event) {
    ArrayUtils.addNewItem(this.sourceData, this.draggedItem);
    ArrayUtils.removeItem(this.targetData, this.draggedItem);

    this.filterSourceData();
    this.filterTargetData();
  }

  targetDragStart($event, item: any) {
    this.draggedItem = item;
  }

  targetDragEnd($event) {
    this.draggedItem = null;
  }

  targetDrop($event) {
    ArrayUtils.addNewItem(this.targetData, this.draggedItem);
    ArrayUtils.removeItem(this.sourceData, this.draggedItem);

    this.filterSourceData();
    this.filterTargetData();
  }

  filterSourceData() {
    if (this.sourceFilterQuery && this.sourceFilterQuery.length > 0) {
      const filteredData = this.targetData.filter(c => this.itemSuitsFilter(c, this.sourceFilterQuery, this.filterFields));
      this.suggestedSourceData = [...filteredData];
    } else {
      this.suggestedSourceData = [...this.sourceData];
    }
  }

  filterTargetData() {
    if (this.targetFilterQuery && this.targetFilterQuery.length > 0) {
      const filteredData = this.targetData.filter(c => this.itemSuitsFilter(c, this.targetFilterQuery, this.filterFields));
      this.suggestedTargetData = [...filteredData];
    } else {
      this.suggestedTargetData = [...this.targetData];
    }
  }


  itemSuitsFilter(item: any, filter: string, fields: string[]): boolean {
    for (const field of fields) {
      if (item[field]) {
        const fieldAsString = <string>item[field];
        if (fieldAsString) {
          if (fieldAsString.includes(filter)) return true;
        }
      }
    }
    return false;
  }

}
