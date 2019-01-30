/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupResultDetailComponent } from 'app/entities/test-result/test-result-detail.component';
import { ActivityGroupResult } from 'app/shared/model/test-result.model';

describe('Component Tests', () => {
    describe('ActivityGroupResult Management Detail Component', () => {
        let comp: ActivityGroupResultDetailComponent;
        let fixture: ComponentFixture<ActivityGroupResultDetailComponent>;
        const route = ({ data: of({ activityGroupResult: new ActivityGroupResult(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupResultDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(ActivityGroupResultDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupResultDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.activityGroupResult).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
