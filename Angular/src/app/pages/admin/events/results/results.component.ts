import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {EventService} from '../../../../services/event.service';
import {IEvent, Event} from '../../../../entities/event';
import {IPersonFull, PersonFull} from '../../../../entities/person-full';
import {zip} from 'rxjs';
import {IEventResult} from '../../../../entities/event-result';
import {EventManager} from '../../../../services/event.manager';

@Component({
  selector: 'app-results',
  templateUrl: './results.component.html',
  styleUrls: ['./results.component.scss']
})
export class ResultsComponent implements OnInit {

  eventId: number;
  event: IEvent;

  eventResults: Array<IEventResult>;
  selectedPerson: IPersonFull;

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService,
              private eventManager: EventManager) { }

  ngOnInit() {
    this.activatedRoute.parent.params.subscribe((params) => {
      this.eventId = +params['id'];

      const getEvent$ = this.eventService.find(this.eventId);
      const getEventResults$ = this.eventService.queryEventResults(this.eventId);

      zip(getEvent$, getEventResults$).subscribe(([eventResponse, eventResultResponse]) => {
        this.event = Event.resolveResponse(eventResponse);
        this.eventResults = eventResultResponse.body;
        this.event.attachedPersons = PersonFull.sortByName(this.event.attachedPersons);
      });

    });

    this.eventManager.subscribe('eventResultCreated', (eventResultEvent: any) => {
      this.eventResults.push(eventResultEvent.content);
    });
  }

  rowSelect(person: IPersonFull) {
    this.selectedPerson = person;
  }

  getResultForPerson(person: IPersonFull): IEventResult {
    if (person) {
      return this.eventResults.find((er) => er.personId === person.id);
    }
  }

}
