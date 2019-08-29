import {Component, Input, OnInit} from '@angular/core';
import {FormGroup} from '@angular/forms';

@Component({
  selector: 'lr-select',
  templateUrl: './lr-select.component.html',
  styleUrls: ['./lr-select.component.scss']
})
export class LrSelectComponent implements OnInit {

  constructor() { }

  @Input()
  label: string;

  @Input()
  parentForm: FormGroup;

  @Input()
  controlName: string;

  @Input()
  errorsMap: Map<string, string>;

  @Input()
  options: Array<any>;

  @Input()
  valueField = 'value';

  @Input()
  labelField = 'label';

  ngOnInit() {
  }

}
