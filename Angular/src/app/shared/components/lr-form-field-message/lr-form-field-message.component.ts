import {Component, Input, OnInit} from '@angular/core';
import {AbstractControl} from '@angular/forms';

@Component({
  selector: 'lr-form-field-message',
  templateUrl: './lr-form-field-message.component.html',
  styleUrls: ['./lr-form-field-message.component.scss']
})
export class LrFormFieldMessageComponent implements OnInit {

  constructor() { }

  @Input()
  type: string;

  @Input()
  message: string;

  @Input()
  inputControl: AbstractControl;

  @Input()
  error: string;

  ngOnInit() {
  }

  show(): boolean {
    return this.inputControl.touched && this.inputControl.hasError(this.error);
  }

}
