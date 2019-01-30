/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupUpdateComponent } from 'app/entities/jt-test/jt-test-update.component';
import { ActivityGroupService } from 'app/entities/jt-test/jt-test.service';
import { ActivityGroup } from 'app/shared/model/jt-test.model';

describe('Component Tests', () => {
    describe('ActivityGroup Management Update Component', () => {
        let comp: ActivityGroupUpdateComponent;
        let fixture: ComponentFixture<ActivityGroupUpdateComponent>;
        let service: ActivityGroupService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupUpdateComponent]
            })
                .overrideTemplate(ActivityGroupUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(ActivityGroupUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new ActivityGroup(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.jTTest = entity;
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
                    const entity = new ActivityGroup();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.jTTest = entity;
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
