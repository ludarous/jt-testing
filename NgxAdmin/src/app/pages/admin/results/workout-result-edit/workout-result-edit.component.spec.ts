import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkoutResultEditComponent } from './workout-result-edit.component';

describe('WorkoutResultEditComponent', () => {
  let component: WorkoutResultEditComponent;
  let fixture: ComponentFixture<WorkoutResultEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WorkoutResultEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkoutResultEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
