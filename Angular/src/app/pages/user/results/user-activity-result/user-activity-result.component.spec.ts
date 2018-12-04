import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserActivityResultComponent } from './user-activity-result.component';

describe('UserActivityResultComponent', () => {
  let component: UserActivityResultComponent;
  let fixture: ComponentFixture<UserActivityResultComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserActivityResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserActivityResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
