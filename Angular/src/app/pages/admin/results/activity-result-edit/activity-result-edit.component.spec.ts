import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ActivityResultEditComponent } from './activity-result-edit.component';

describe('ActivityResultEditComponent', () => {
  let component: ActivityResultEditComponent;
  let fixture: ComponentFixture<ActivityResultEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ActivityResultEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ActivityResultEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
