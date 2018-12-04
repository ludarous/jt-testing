import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { UserEventResultComponent } from './user-event-result.component';

describe('UserEventResultComponent', () => {
  let component: UserEventResultComponent;
  let fixture: ComponentFixture<UserEventResultComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ UserEventResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserEventResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
