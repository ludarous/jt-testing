/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { PersonalDataDeleteDialogComponent } from 'app/entities/personal-data/personal-data-delete-dialog.component';
import { PersonalDataService } from 'app/entities/personal-data/personal-data.service';

describe('Component Tests', () => {
    describe('PersonalData Management Delete Component', () => {
        let comp: PersonalDataDeleteDialogComponent;
        let fixture: ComponentFixture<PersonalDataDeleteDialogComponent>;
        let service: PersonalDataService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [PersonalDataDeleteDialogComponent]
            })
                .overrideTemplate(PersonalDataDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(PersonalDataDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(PersonalDataService);
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
