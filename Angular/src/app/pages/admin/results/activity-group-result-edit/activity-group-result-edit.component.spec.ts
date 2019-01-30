import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityGroupResultEditComponent } from './activity-group-result-edit.component';

describe('ActivityGroupResultEditComponent', () => {
  let component: ActivityGroupResultEditComponent;
  let fixture: ComponentFixture<ActivityGroupResultEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityGroupResultEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityGroupResultEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
