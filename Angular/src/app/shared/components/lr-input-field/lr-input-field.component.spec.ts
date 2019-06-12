import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { LrInputFieldComponent } from './lr-input-field.component';

describe('LrInputFieldComponent', () => {
  let component: LrInputFieldComponent;
  let fixture: ComponentFixture<LrInputFieldComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ LrInputFieldComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LrInputFieldComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
