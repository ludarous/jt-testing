/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { EventResultUpdateComponent } from 'app/entities/event-result/event-result-update.component';
import { EventResultService } from 'app/entities/event-result/event-result.service';
import { EventResult } from 'app/shared/model/event-result.model';

describe('Component Tests', () => {
    describe('EventResult Management Update Component', () => {
        let comp: EventResultUpdateComponent;
        let fixture: ComponentFixture<EventResultUpdateComponent>;
        let service: EventResultService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [EventResultUpdateComponent]
            })
                .overrideTemplate(EventResultUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(EventResultUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(EventResultService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new EventResult(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.eventResult = entity;
                    // WHEN
                    comp.save();
                    tick(); // simulate async

                    // THEN
                    expect(service.update).toHaveBeenCalledWith(entity);
                    expect(comp.isSaving).toEqual(false);
                })
            );

            it(
                'Should call create service on save for new entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new EventResult();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.eventResult = entity;
                    // WHEN
                    comp.save();
                    tick(); // simulate async

                    // THEN
                    expect(service.create).toHaveBeenCalledWith(entity);
                    expect(comp.isSaving).toEqual(false);
                })
            );
        });
    });
});
