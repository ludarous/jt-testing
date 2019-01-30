/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { EventResultDetailComponent } from 'app/entities/event-result/event-result-detail.component';
import { EventResult } from 'app/shared/model/event-result.model';

describe('Component Tests', () => {
    describe('EventResult Management Detail Component', () => {
        let comp: EventResultDetailComponent;
        let fixture: ComponentFixture<EventResultDetailComponent>;
        const route = ({ data: of({ eventResult: new EventResult(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [EventResultDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(EventResultDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(EventResultDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.eventResult).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
