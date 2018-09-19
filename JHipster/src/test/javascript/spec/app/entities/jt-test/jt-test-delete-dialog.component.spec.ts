/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { JTTestDeleteDialogComponent } from 'app/entities/jt-test/jt-test-delete-dialog.component';
import { JTTestService } from 'app/entities/jt-test/jt-test.service';

describe('Component Tests', () => {
    describe('JTTest Management Delete Component', () => {
        let comp: JTTestDeleteDialogComponent;
        let fixture: ComponentFixture<JTTestDeleteDialogComponent>;
        let service: JTTestService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [JTTestDeleteDialogComponent]
            })
                .overrideTemplate(JTTestDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(JTTestDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(JTTestService);
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
