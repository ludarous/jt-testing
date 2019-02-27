import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkoutCategoriesComponent } from './workout-categories.component';

describe('WorkoutCategoriesComponent', () => {
  let component: WorkoutCategoriesComponent;
  let fixture: ComponentFixture<WorkoutCategoriesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WorkoutCategoriesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkoutCategoriesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
