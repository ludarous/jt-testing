import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityGroupCategoriesEditComponent } from './activity-group-categories-edit.component';

describe('ActivityGroupCategoriesEditComponent', () => {
  let component: ActivityGroupCategoriesEditComponent;
  let fixture: ComponentFixture<ActivityGroupCategoriesEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityGroupCategoriesEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityGroupCategoriesEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
