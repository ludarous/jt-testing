/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { WorkoutResultDetailComponent } from 'app/entities/workout-result/workout-result-detail.component';
import { WorkoutResult } from 'app/shared/model/workout-result.model';

describe('Component Tests', () => {
    describe('WorkoutResult Management Detail Component', () => {
        let comp: WorkoutResultDetailComponent;
        let fixture: ComponentFixture<WorkoutResultDetailComponent>;
        const route = ({ data: of({ workoutResult: new WorkoutResult(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [WorkoutResultDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(WorkoutResultDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(WorkoutResultDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.workoutResult).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
