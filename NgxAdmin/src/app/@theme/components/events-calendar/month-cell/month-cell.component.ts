import { Component, EventEmitter } from '@angular/core';
import {
  NbCalendarCell,
  NbCalendarDayPickerComponent,
  NbCalendarMonthModelService,
  NbDateService,
} from '@nebular/theme';
import { TranslationWidth } from '@angular/common';
import {EventsCalendarDayCellComponent} from '../day-cell/day-cell.component';

@Component({
  selector: 'ngx-month-cell',
  styleUrls: ['month-cell.component.scss'],
  templateUrl: 'month-cell.component.html',
  entryComponents: [EventsCalendarDayCellComponent]
})
export class EventsCalendarMonthCellComponent extends NbCalendarDayPickerComponent<Date, Date>
  implements NbCalendarCell<Date, Date> {
  select: EventEmitter<Date> = new EventEmitter();
  selectedValue: Date;

  dayCellComponent = EventsCalendarDayCellComponent;

  constructor(private dateService: NbDateService<Date>, monthModel: NbCalendarMonthModelService<Date>) {
    super(monthModel);
  }

  get title() {
    return this.dateService.getMonthName(this.date, TranslationWidth.Wide);
  }
}
