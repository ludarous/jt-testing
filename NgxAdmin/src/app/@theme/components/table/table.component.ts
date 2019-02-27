import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';

@Component({
  selector: 'ngx-table',
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.scss']
})
export class TableComponent implements OnInit {

  constructor() { }

  @Input()
  data: Array<any>;

  @Input()
  cols: Array<any>;

  @Input()
  tableType: string;

  @Output()
  delete: EventEmitter<any> = new EventEmitter<any>();

  @Output()
  edit: EventEmitter<any> = new EventEmitter<any>();

  @Output()
  rowClick: EventEmitter<any> = new EventEmitter<any>();

  @Input()
  showActions = true;

  ngOnInit() {
  }

  onRowSelect(event: any, item: any) {
    event.stopPropagation();
    this.rowClick.emit(item);
  }

  onDelete(item: any) {
    this.delete.emit(item);
  }

  onEdit(item: any) {
    this.edit.emit(item);
  }

}
