/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupCategoryUpdateComponent } from 'app/entities/activity-group-category/activity-group-category-update.component';
import { ActivityGroupCategoryService } from 'app/entities/activity-group-category/activity-group-category.service';
import { ActivityGroupCategory } from 'app/shared/model/activity-group-category.model';

describe('Component Tests', () => {
    describe('ActivityGroupCategory Management Update Component', () => {
        let comp: ActivityGroupCategoryUpdateComponent;
        let fixture: ComponentFixture<ActivityGroupCategoryUpdateComponent>;
        let service: ActivityGroupCategoryService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupCategoryUpdateComponent]
            })
                .overrideTemplate(ActivityGroupCategoryUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(ActivityGroupCategoryUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupCategoryService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new ActivityGroupCategory(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.activityGroupCategory = entity;
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
                    const entity = new ActivityGroupCategory();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.activityGroupCategory = entity;
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
