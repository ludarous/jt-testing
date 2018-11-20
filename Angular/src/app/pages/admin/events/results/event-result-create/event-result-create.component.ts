import { Component, OnInit } from '@angular/core';
import {ActivatedRoute} from '@angular/router';
import {IEvent} from '../../../../../entities/event';
import {EventService} from '../../../../../services/event.service';
import {HttpResponse} from '@angular/common/http';
import {IPerson} from '../../../../../entities/person';
import {IPersonFull} from '../../../../../entities/person-full';

@Component({
  selector: 'app-event-result-create',
  templateUrl: './event-result-create.component.html',
  styleUrls: ['./event-result-create.component.scss']
})
export class EventResultCreateComponent implements OnInit {

  eventId: number;
  event: IEvent;

  selectedPerson: IPersonFull;

  constructor(private activatedRoute: ActivatedRoute,
              private eventService: EventService) { }

  ngOnInit() {
    this.activatedRoute.parent.params.subscribe((params) => {
      this.eventId = +params['id'];

      this.eventService.find(this.eventId).subscribe((eventResponse) => {
        this.event = eventResponse.body;
      });

    });
  }

}
