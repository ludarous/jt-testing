import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';

@Component({
  selector: 'ngx-table-search',
  templateUrl: './table-search.component.html',
  styleUrls: ['./table-search.component.scss']
})
export class TableSearchComponent implements OnInit {

  constructor() {
  }

  @Input()
  createItemTitle: string;

  @Output()
  create: EventEmitter<any> = new EventEmitter<string>();

  ngOnInit() {
  }

  onCreate() {
    this.create.emit();
  }

}
