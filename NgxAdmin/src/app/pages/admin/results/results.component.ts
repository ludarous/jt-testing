import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {EventService} from '../../../services/event.service';
import {IEvent, Event} from '../../../entities/event';
import {EventManager} from '../../../services/event.manager';
import {SelectItem} from 'primeng/api';
import {IPerson} from '../../../entities/person';
import {EventResult, IEventResult} from '../../../entities/event-result';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {EventResultService} from '../../../services/event-result.service';
import {IPersonFull} from '../../../entities/person-full';
import {ArrayUtils} from '../../../../../../NgxAdmin/src/app/@core/utils/array.utils';
import {TranslateService} from '@ngx-translate/core';
import {NbStepperComponent} from '@nebular/theme';
import event = google.maps.event;

@Component({
  selector: 'ngx-results',
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
      this.tablePersons = this._selectedEvent.attachedPersons
        .map(p => (
          {
            data: p,
            firstName: p.personalData.firstName,
            lastName: p.personalData.lastName
          }
          ));
    }
  }

  tablePersons: Array<any>;

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

  @ViewChild('stepper')
  stepper: NbStepperComponent;

  selectedPersonalEventResult: IEventResult;

  selectedStepperIndex = 0;

  eventsCols: Array<any>;
  personsCols: Array<any>;

  eventRouterLink: (e) => any[];

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventResultService: EventResultService,
              private eventManager: EventManager,
              private translateService: TranslateService,
              private router: Router) {
  }

  ngOnInit() {

    this.eventRouterLink = this.getEventRouterLink;

    const getEvents$ = this.eventService.query();

    getEvents$.subscribe((eventsResponse) => {
      this.events = Event.resolveArrayResponse(eventsResponse);
    });

    this.eventsCols = [
      { field: 'name', header: 'Název' },
    ];

    this.personsCols = [
      { field: 'firstName', header: 'Křestní jméno' },
      { field: 'lastName', header: 'Příjmení' },
    ];
  }

  getEventRouterLink(e: IEvent): any[] {
    return new Array(<any>'/pages/admin/events/', <any>e.id, <any>'results');
  }

  eventSelect(e: IEvent) {
    this.selectedEvent = e;
    this.stepper.next();
  }

  personSelect(tablePerson: any) {
    this.selectedPerson = tablePerson.data;
    this.selectedPersonalEventResult = this._selectedEvent.eventResults.find(er => er.personId === this._selectedPerson.id);
    if (!this.selectedPersonalEventResult) {
      this.createEventResult();
    }
    this.stepper.next();
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

  getCardHeader(): string {
    if (!this.selectedEvent) {
      return this.translateService.instant('Výsledky');
    } else if (this.selectedEvent && !this.selectedPerson) {
      return this.translateService.instant('Výsledky události') + ' ' + this.selectedEvent.name;
    } else {
      return this.translateService.instant('Výsledky uživatele') +
        ' ' +
        this.selectedPerson.personalData.firstName +
        ' ' +
        this.selectedPerson.personalData.lastName +
        ' ' +
        this.translateService.instant('pro událost') +
        ' ' +
        this.selectedEvent.name;
    }
  }

}
