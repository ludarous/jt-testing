import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TestCategoriesEditComponent } from './test-categories-edit.component';

describe('TestCategoriesEditComponent', () => {
  let component: TestCategoriesEditComponent;
  let fixture: ComponentFixture<TestCategoriesEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TestCategoriesEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TestCategoriesEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
