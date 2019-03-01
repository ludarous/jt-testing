import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserActivityStatsComponent } from './user-activity-stats.component';

describe('UserActivityStatsComponent', () => {
  let component: UserActivityStatsComponent;
  let fixture: ComponentFixture<UserActivityStatsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserActivityStatsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserActivityStatsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
