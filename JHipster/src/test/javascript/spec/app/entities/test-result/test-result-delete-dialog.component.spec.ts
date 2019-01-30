/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { ActivityGroupResultDeleteDialogComponent } from 'app/entities/test-result/test-result-delete-dialog.component';
import { ActivityGroupResultService } from 'app/entities/test-result/test-result.service';

describe('Component Tests', () => {
    describe('ActivityGroupResult Management Delete Component', () => {
        let comp: ActivityGroupResultDeleteDialogComponent;
        let fixture: ComponentFixture<ActivityGroupResultDeleteDialogComponent>;
        let service: ActivityGroupResultService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [ActivityGroupResultDeleteDialogComponent]
            })
                .overrideTemplate(ActivityGroupResultDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(ActivityGroupResultDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(ActivityGroupResultService);
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
