import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EventResultEditComponent } from './event-result-create.component';

describe('EventResultEditComponent', () => {
  let component: EventResultEditComponent;
  let fixture: ComponentFixture<EventResultEditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EventResultEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EventResultEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
