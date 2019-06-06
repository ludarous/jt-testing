import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {EventResultService} from '../../../services/event-result.service';
import {EventService} from '../../../services/event.service';
import {IEventResult} from '../../../entities/event-result';
import {IEvent, Event} from '../../../entities/event';
import { Router } from '@angular/router';

@Component({
  selector: 'ngx-user-results',
  templateUrl: './user-results.component.html',
  styleUrls: ['./user-results.component.scss']
})
export class UserResultsComponent implements OnInit {

  constructor(private router: Router,
              private eventResultService: EventResultService,
              private eventService: EventService) { }

  myEventResults: Array<IEventResult>;
  myEvents: Array<IEvent>;

  eventRouterLink: (e) => any[];

  ngOnInit() {
    this.eventRouterLink = this.getEventRouterLink;

    const getMyEvent$ = this.eventService.queryMyEvents();
    getMyEvent$.subscribe((myEventsResponse: HttpResponse<Array<IEvent>>) => {
      this.myEvents = Event.resolveArrayResponse(myEventsResponse);
    });
  }

  getEventRouterLink(e: IEvent): any[] {
    return new Array(<any>'/user/results/events/', <any>e.id, <any>'results');
  }

  loadNext(cardData) {
    if (cardData.loading) { return; }

    // cardData.loading = true;
    // cardData.placeholders = new Array(this.pageSize);
    // this.newsService.load(cardData.pageToLoadNext, this.pageSize)
    //   .subscribe(nextNews => {
    //     cardData.placeholders = [];
    //     cardData.news.push(...nextNews);
    //     cardData.loading = false;
    //     cardData.pageToLoadNext++;
    //   });
  }

  goToEventResults(event: IEvent) {
    this.router.navigate(['/pages/user/my-results/event/', event.id]);
  }


}
