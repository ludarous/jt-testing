import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WorkoutCategoriesEditComponent } from './workout-categories-edit.component';

describe('WorkoutCategoriesEditComponent', () => {
  let component: WorkoutCategoriesEditComponent;
  let fixture: ComponentFixture<WorkoutCategoriesEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WorkoutCategoriesEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WorkoutCategoriesEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
