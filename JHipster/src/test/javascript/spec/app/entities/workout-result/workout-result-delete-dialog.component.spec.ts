/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { WorkoutResultDeleteDialogComponent } from 'app/entities/workout-result/workout-result-delete-dialog.component';
import { WorkoutResultService } from 'app/entities/workout-result/workout-result.service';

describe('Component Tests', () => {
    describe('WorkoutResult Management Delete Component', () => {
        let comp: WorkoutResultDeleteDialogComponent;
        let fixture: ComponentFixture<WorkoutResultDeleteDialogComponent>;
        let service: WorkoutResultService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [WorkoutResultDeleteDialogComponent]
            })
                .overrideTemplate(WorkoutResultDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(WorkoutResultDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(WorkoutResultService);
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
