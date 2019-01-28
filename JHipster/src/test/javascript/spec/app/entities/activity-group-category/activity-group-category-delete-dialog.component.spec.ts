/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupCategoryDeleteDialogComponent } from 'app/entities/activity-group-category/activity-group-category-delete-dialog.component';
import { ActivityGroupCategoryService } from 'app/entities/activity-group-category/activity-group-category.service';

describe('Component Tests', () => {
    describe('ActivityGroupCategory Management Delete Component', () => {
        let comp: ActivityGroupCategoryDeleteDialogComponent;
        let fixture: ComponentFixture<ActivityGroupCategoryDeleteDialogComponent>;
        let service: ActivityGroupCategoryService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupCategoryDeleteDialogComponent]
            })
                .overrideTemplate(ActivityGroupCategoryDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupCategoryDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupCategoryService);
            mockEventManager = fixture.debugElement.injector.get(JhiEventManager);
            mockActiveModal = fixture.debugElement.injector.get(NgbActiveModal);
        });

        describe('confirmDelete', () => {
            it('Should call delete service on confirmDelete', inject(
                [],
                fakeAsync(() => {
                    // GIVEN
                    spyOn(service, 'delete').and.returnValue(of({}));

                    // WHEN
                    comp.confirmDelete(123);
                    tick();

                    // THEN
                    expect(service.delete).toHaveBeenCalledWith(123);
                    expect(mockActiveModal.dismissSpy).toHaveBeenCalled();
                    expect(mockEventManager.broadcastSpy).toHaveBeenCalled();
                })
            ));
        });
    });
});
