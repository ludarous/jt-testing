import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TestResultEditComponent } from './test-result-edit.component';

describe('TestResultEditComponent', () => {
  let component: TestResultEditComponent;
  let fixture: ComponentFixture<TestResultEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TestResultEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TestResultEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
