import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserWorkoutResultComponent } from './user-workout-result.component';

describe('UserWorkoutResultComponent', () => {
  let component: UserWorkoutResultComponent;
  let fixture: ComponentFixture<UserWorkoutResultComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserWorkoutResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserWorkoutResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
