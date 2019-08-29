import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {FormGroup} from '@angular/forms';

@Component({
  selector: 'lr-autocomplete',
  templateUrl: './lr-autocomplete.component.html',
  styleUrls: ['./lr-autocomplete.component.scss']
})
export class LrAutocompleteComponent implements OnInit {

  constructor() { }

  @Input()
  label: string;

  @Input()
  placeholder: string;

  @Input()
  errorsMap: Map<string, string>;

  @Input()
  searchField: string;

  @Input()
  items: Array<any>;

  suggestedItems: Array<any>;

  @Output()
  selectedItemsChanged: EventEmitter<Array<any>> = new EventEmitter();

  private _selectedItems: Array<any>;
  get selectedItems(): Array<any> {
    return this._selectedItems;
  }

  set selectedItems(value: Array<any>) {
    this.selectedItemsChanged.emit();
    this._selectedItems = value;
  }

  ngOnInit() {

  }

  search(event) {
    const filteredItems = this.items.filter(i => i[this.searchField].toLowerCase().includes(event.query.toLowerCase()));
    this.suggestedItems = filteredItems;
  }

}
