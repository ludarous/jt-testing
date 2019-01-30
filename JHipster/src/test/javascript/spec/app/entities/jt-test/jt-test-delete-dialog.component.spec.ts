/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupDeleteDialogComponent } from 'app/entities/jt-test/jt-test-delete-dialog.component';
import { ActivityGroupService } from 'app/entities/jt-test/jt-test.service';

describe('Component Tests', () => {
    describe('ActivityGroup Management Delete Component', () => {
        let comp: ActivityGroupDeleteDialogComponent;
        let fixture: ComponentFixture<ActivityGroupDeleteDialogComponent>;
        let service: ActivityGroupService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupDeleteDialogComponent]
            })
                .overrideTemplate(ActivityGroupDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupService);
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
