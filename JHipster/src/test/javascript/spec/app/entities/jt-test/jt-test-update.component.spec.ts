/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { JTTestUpdateComponent } from 'app/entities/jt-test/jt-test-update.component';
import { JTTestService } from 'app/entities/jt-test/jt-test.service';
import { JTTest } from 'app/shared/model/jt-test.model';

describe('Component Tests', () => {
    describe('JTTest Management Update Component', () => {
        let comp: JTTestUpdateComponent;
        let fixture: ComponentFixture<JTTestUpdateComponent>;
        let service: JTTestService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [JTTestUpdateComponent]
            })
                .overrideTemplate(JTTestUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(JTTestUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(JTTestService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new JTTest(123);
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
                    const entity = new JTTest();
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
