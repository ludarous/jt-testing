/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, inject, fakeAsync, tick } from '@angular/core/testing';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Observable, of } from 'rxjs';
import { JhiEventManager } from 'ng-jhipster';

import { JtTestingTestModule } from '../../../test.module';
import { TestCategoryDeleteDialogComponent } from 'app/entities/test-category/test-category-delete-dialog.component';
import { TestCategoryService } from 'app/entities/test-category/test-category.service';

describe('Component Tests', () => {
    describe('TestCategory Management Delete Component', () => {
        let comp: TestCategoryDeleteDialogComponent;
        let fixture: ComponentFixture<TestCategoryDeleteDialogComponent>;
        let service: TestCategoryService;
        let mockEventManager: any;
        let mockActiveModal: any;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [TestCategoryDeleteDialogComponent]
            })
                .overrideTemplate(TestCategoryDeleteDialogComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(TestCategoryDeleteDialogComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(TestCategoryService);
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
