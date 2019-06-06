import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {EventService} from '../../../services/event.service';
import {Event, IEvent} from '../../../entities/event';
import {EventManager} from '../../../services/event.manager';
import {SelectItem} from 'primeng/api';
import {EventResult, IEventResult} from '../../../entities/event-result';
import {HttpResponse} from '@angular/common/http';
import {EventResultService} from '../../../services/event-result.service';
import {IPersonFull} from '../../../entities/person-full';
import {ArrayUtils} from '../../../utils/array.utils';

@Component({
  selector: 'app-results',
  templateUrl: './results.component.html',
  styleUrls: ['./results.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class ResultsComponent implements OnInit {


  events: Array<IEvent>;
  eventSelectItems: Array<SelectItem>;


  private _selectedEvent: IEvent;
  get selectedEvent(): IEvent {
    return this._selectedEvent;
  }

  set selectedEvent(value: IEvent) {
    if (value) {
      this._selectedEvent = value;
      this.personSelectItems = this._selectedEvent.attachedPersons
        .map(p => ({label: p.personalData.firstName + ' ' + p.personalData.lastName, value: p}));
      ArrayUtils.insertItem(this.personSelectItems, {label: '--- VYBER UŽIVATELE ---', value: null}, 0);
    }
  }

  personSelectItems: Array<SelectItem>;

  private _selectedPerson: IPersonFull;
  get selectedPerson(): IPersonFull {
    return this._selectedPerson;
  }

  set selectedPerson(value: IPersonFull) {
    if (value) {
      this._selectedPerson = value;
      this.selectedPersonalEventResult = this.selectedEvent.eventResults.find(er => er.personId === this.selectedPerson.id);
    }
  }

  selectedPersonalEventResult: IEventResult;

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventResultService: EventResultService,
              private eventManager: EventManager,
              private router: Router) {
  }

  ngOnInit() {

    const getEvents$ = this.eventService.query();

    getEvents$.subscribe((eventsResponse) => {
      this.events = Event.resolveArrayResponse(eventsResponse);
      this.eventSelectItems = this.events.map(e => ({label: e.name, value: e}));
      ArrayUtils.insertItem(this.eventSelectItems, {label: '--- VYBER UDÁLOST ---', value: null}, 0);
    });
  }

  rowSelect(event: IEvent) {
    this.router.navigate(['/admin/results/edit', event.id]);
  }


  personChanged(changedEvent: any) {
    this.selectedPersonalEventResult = this._selectedEvent.eventResults.find(er => er.personId === this._selectedPerson.id);
  }

  createEventResult() {

    const eventResult = new EventResult(this._selectedEvent, this._selectedPerson);

    this.eventResultService
      .create(eventResult)
      .subscribe((eventResultResponse: HttpResponse<IEventResult>) => {
        this.selectedPersonalEventResult = eventResultResponse.body;
        this.eventManager.broadcast({
          name: 'eventResultCreated',
          content: this.selectedPersonalEventResult
        });
      });
  }

}
