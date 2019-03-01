import {Component, ContentChild, EventEmitter, Input, OnInit, Output, TemplateRef} from '@angular/core';

@Component({
  selector: 'ngx-scrollable-list',
  templateUrl: './scrollable-list.component.html',
  styleUrls: ['./scrollable-list.component.scss']
})
export class ScrollableListComponent implements OnInit {

  constructor() { }

  @Output()
  itemClick = new EventEmitter<any>();

  @Input()
  heading: string;

  @Input()
  filter: boolean;

  @Input()
  filterPlaceholder: string;

  @Input()
  data: Array<any>;

  @Input()
  filterFields: string[];

  private _filterQuery: string;
  @Input()
  get filterQuery(): string {
    return this._filterQuery;
  }

  set filterQuery(value: string) {
    this._filterQuery = value;
    const filteredData = this.data.filter(c => this.itemSuitsFilter(c, this.filterQuery, this.filterFields));
    this.filteredData = [...filteredData];
  }

  @ContentChild(TemplateRef)
  @Input()
  layoutTemplate: TemplateRef<any>;

  filteredData: Array<any> = new Array<any>();

  ngOnInit() {
    this.filterData();
  }

  filterData() {
    if (this.filterQuery && this.filterQuery.length > 0) {
      const filteredData = this.data.filter(c => this.itemSuitsFilter(c, this.filterQuery, this.filterFields));
      this.filteredData = [...filteredData];
    } else {
      this.filteredData = [...this.data];
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

  onItemClick(item: any) {
    this.itemClick.emit(item);
  }

}
