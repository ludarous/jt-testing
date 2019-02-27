import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';

@Component({
  selector: 'ngx-table-row-actions',
  templateUrl: './table-row-actions.component.html',
  styleUrls: ['./table-row-actions.component.scss']
})
export class TableRowActionsComponent implements OnInit {

  constructor() { }

  @Input()
  item: any;

  @Output()
  delete: EventEmitter<any> = new EventEmitter<any>();

  @Output()
  edit: EventEmitter<any> = new EventEmitter<any>();

  ngOnInit() {
  }

  onDelete(event: any, item: any) {
    event.stopPropagation();
    this.delete.emit(item);
  }

  onEdit(event: any, item: any) {
    event.stopPropagation();
    this.edit.emit(item);
  }

}
