/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { PersonalDataUpdateComponent } from 'app/entities/personal-data/personal-data-update.component';
import { PersonalDataService } from 'app/entities/personal-data/personal-data.service';
import { PersonalData } from 'app/shared/model/personal-data.model';

describe('Component Tests', () => {
    describe('PersonalData Management Update Component', () => {
        let comp: PersonalDataUpdateComponent;
        let fixture: ComponentFixture<PersonalDataUpdateComponent>;
        let service: PersonalDataService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [PersonalDataUpdateComponent]
            })
                .overrideTemplate(PersonalDataUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(PersonalDataUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(PersonalDataService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new PersonalData(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.personalData = entity;
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
                    const entity = new PersonalData();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.personalData = entity;
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
