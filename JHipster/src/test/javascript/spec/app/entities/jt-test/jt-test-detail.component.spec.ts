/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupDetailComponent } from 'app/entities/jt-test/jt-test-detail.component';
import { ActivityGroup } from 'app/shared/model/jt-test.model';

describe('Component Tests', () => {
    describe('ActivityGroup Management Detail Component', () => {
        let comp: ActivityGroupDetailComponent;
        let fixture: ComponentFixture<ActivityGroupDetailComponent>;
        const route = ({ data: of({ jTTest: new ActivityGroup(123) }) } as any) as ActivatedRoute;

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
                expect(comp.jTTest).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
