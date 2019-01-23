import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TestCategoriesListComponent } from './test-categories-list.component';

describe('TestCategoriesListComponent', () => {
  let component: TestCategoriesListComponent;
  let fixture: ComponentFixture<TestCategoriesListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TestCategoriesListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TestCategoriesListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
