import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserActivityGroupResultComponent } from './user-activity-group-result.component';

describe('UserActivityGroupResultComponent', () => {
  let component: UserActivityGroupResultComponent;
  let fixture: ComponentFixture<UserActivityGroupResultComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserActivityGroupResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserActivityGroupResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
