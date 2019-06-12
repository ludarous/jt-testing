import {Component, Input, OnInit} from '@angular/core';
import {FormGroup} from '@angular/forms';

@Component({
  selector: 'lr-input-field',
  templateUrl: './lr-input-field.component.html',
  styleUrls: ['./lr-input-field.component.scss']
})
export class LrInputFieldComponent implements OnInit {

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
  type: string = 'input'

  ngOnInit() {
  }

}
