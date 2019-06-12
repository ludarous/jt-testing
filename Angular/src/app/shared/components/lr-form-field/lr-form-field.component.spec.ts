import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LrFormFieldComponent } from './lr-form-field.component';

describe('LrFormFieldComponent', () => {
  let component: LrFormFieldComponent;
  let fixture: ComponentFixture<LrFormFieldComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LrFormFieldComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LrFormFieldComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
