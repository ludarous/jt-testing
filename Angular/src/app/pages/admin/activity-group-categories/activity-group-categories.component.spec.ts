import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityGroupCategoriesComponent } from './activity-group-categories.component';

describe('ActivityGroupCategoriesComponent', () => {
  let component: ActivityGroupCategoriesComponent;
  let fixture: ComponentFixture<ActivityGroupCategoriesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityGroupCategoriesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityGroupCategoriesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
