import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityGroupCategoriesListComponent } from './activity-group-categories-list.component';

describe('ActivityGroupCategoriesListComponent', () => {
  let component: ActivityGroupCategoriesListComponent;
  let fixture: ComponentFixture<ActivityGroupCategoriesListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityGroupCategoriesListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityGroupCategoriesListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
