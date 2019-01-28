/* tslint:disable max-line-length */
import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { Observable, of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { PersonGroupUpdateComponent } from 'app/entities/person-group/person-group-update.component';
import { PersonGroupService } from 'app/entities/person-group/person-group.service';
import { PersonGroup } from 'app/shared/model/person-group.model';

describe('Component Tests', () => {
    describe('PersonGroup Management Update Component', () => {
        let comp: PersonGroupUpdateComponent;
        let fixture: ComponentFixture<PersonGroupUpdateComponent>;
        let service: PersonGroupService;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [PersonGroupUpdateComponent]
            })
                .overrideTemplate(PersonGroupUpdateComponent, '')
                .compileComponents();

            fixture = TestBed.createComponent(PersonGroupUpdateComponent);
            comp = fixture.componentInstance;
            service = fixture.debugElement.injector.get(PersonGroupService);
        });

        describe('save', () => {
            it(
                'Should call update service on save for existing entity',
                fakeAsync(() => {
                    // GIVEN
                    const entity = new PersonGroup(123);
                    spyOn(service, 'update').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.personGroup = entity;
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
                    const entity = new PersonGroup();
                    spyOn(service, 'create').and.returnValue(of(new HttpResponse({ body: entity })));
                    comp.personGroup = entity;
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
