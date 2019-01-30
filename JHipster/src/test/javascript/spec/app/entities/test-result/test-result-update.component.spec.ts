/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupResultUpdateComponent } from 'app/entities/test-result/test-result-update.component';
import { ActivityGroupResultService } from 'app/entities/test-result/test-result.service';
import { ActivityGroupResult } from 'app/shared/model/test-result.model';

describe('Component Tests', () => {
    describe('ActivityGroupResult Management Update Component', () => {
        let comp: ActivityGroupResultUpdateComponent;
        let fixture: ComponentFixture<ActivityGroupResultUpdateComponent>;
        let service: ActivityGroupResultService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupResultUpdateComponent]
            })
                .overrideTemplate(ActivityGroupResultUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(ActivityGroupResultUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupResultService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new ActivityGroupResult(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.activityGroupResult = entity;
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
                    const entity = new ActivityGroupResult();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.activityGroupResult = entity;
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
