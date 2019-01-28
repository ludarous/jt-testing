/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupDetailComponent } from 'app/entities/activity-group/activity-group-detail.component';
import { ActivityGroup } from 'app/shared/model/activity-group.model';

describe('Component Tests', () => {
    describe('ActivityGroup Management Detail Component', () => {
        let comp: ActivityGroupDetailComponent;
        let fixture: ComponentFixture<ActivityGroupDetailComponent>;
        const route = ({ data: of({ activityGroup: new ActivityGroup(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(ActivityGroupDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.activityGroup).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
