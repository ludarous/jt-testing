import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { EventResultCreateComponent } from './event-result-create.component';

describe('EventResultCreateComponent', () => {
  let component: EventResultCreateComponent;
  let fixture: ComponentFixture<EventResultCreateComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ EventResultCreateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EventResultCreateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
