import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivitiesEditComponent } from './edit.component';

describe('EventEditComponent', () => {
  let component: ActivitiesEditComponent;
  let fixture: ComponentFixture<ActivitiesEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivitiesEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivitiesEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});