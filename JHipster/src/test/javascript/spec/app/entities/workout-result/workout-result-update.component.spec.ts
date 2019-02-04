/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { WorkoutResultUpdateComponent } from 'app/entities/workout-result/workout-result-update.component';
import { WorkoutResultService } from 'app/entities/workout-result/workout-result.service';
import { WorkoutResult } from 'app/shared/model/activity-group-result.model';

describe('Component Tests', () => {
    describe('WorkoutResult Management Update Component', () => {
        let comp: WorkoutResultUpdateComponent;
        let fixture: ComponentFixture<WorkoutResultUpdateComponent>;
        let service: WorkoutResultService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [WorkoutResultUpdateComponent]
            })
                .overrideTemplate(WorkoutResultUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(WorkoutResultUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(WorkoutResultService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new WorkoutResult(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.workoutResult = entity;
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
                    const entity = new WorkoutResult();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.workoutResult = entity;
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
