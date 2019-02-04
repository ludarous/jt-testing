import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkoutCategoriesListComponent } from './workout-categories-list.component';

describe('WorkoutCategoriesListComponent', () => {
  let component: WorkoutCategoriesListComponent;
  let fixture: ComponentFixture<WorkoutCategoriesListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WorkoutCategoriesListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkoutCategoriesListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
