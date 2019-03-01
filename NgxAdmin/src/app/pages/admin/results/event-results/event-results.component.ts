import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {EventService} from '../../../../services/event.service';
import {EventResultService} from '../../../../services/event-result.service';
import {EventManager} from '../../../../services/event.manager';
import {TranslateService} from '@ngx-translate/core';
import {IEvent, Event} from '../../../../entities/event';
import {HttpResponse} from '@angular/common/http';
import {EventResult, IEventResult} from '../../../../entities/event-result';

@Component({
  selector: 'ngx-event-results',
  templateUrl: './event-results.component.html',
  styleUrls: ['./event-results.component.scss']
})
export class EventResultsComponent implements OnInit {

  eventId: number;
  event: IEvent;

  tablePersons: Array<any>;

  personsCols: Array<any>;



  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventResultService: EventResultService,
              private eventManager: EventManager,
              private translateService: TranslateService,
              private router: Router) {
  }

  ngOnInit() {

    this.personsCols = [
      { field: 'firstName', header: 'Křestní jméno' },
      { field: 'lastName', header: 'Příjmení' },
    ];

    this.activatedRoute.params.subscribe((params) => {
      this.eventId = params['eventId'];
      this.eventService.find(this.eventId).subscribe((eventResponse: HttpResponse<IEvent>) => {
        this.event = Event.resolveResponse(eventResponse);

        this.tablePersons = this.event.attachedPersons
          .map(p => (
            {
              data: p,
              firstName: p.personalData.firstName,
              lastName: p.personalData.lastName
            }
          ));
      });
    });
  }

  personSelect(tablePerson: any) {
    this.router.navigate(['/pages/admin/events/', this.event.id, 'results', 'person', tablePerson.data.id]);
  }


}
