import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LrFormFieldMessageComponent } from './lr-form-field-message.component';

describe('LrFormFieldMessageComponent', () => {
  let component: LrFormFieldMessageComponent;
  let fixture: ComponentFixture<LrFormFieldMessageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LrFormFieldMessageComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LrFormFieldMessageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
