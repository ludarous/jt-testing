/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupCategoryDetailComponent } from 'app/entities/activity-group-category/activity-group-category-detail.component';
import { ActivityGroupCategory } from 'app/shared/model/activity-group-category.model';

describe('Component Tests', () => {
    describe('ActivityGroupCategory Management Detail Component', () => {
        let comp: ActivityGroupCategoryDetailComponent;
        let fixture: ComponentFixture<ActivityGroupCategoryDetailComponent>;
        const route = ({ data: of({ activityGroupCategory: new ActivityGroupCategory(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupCategoryDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(ActivityGroupCategoryDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupCategoryDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.activityGroupCategory).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
