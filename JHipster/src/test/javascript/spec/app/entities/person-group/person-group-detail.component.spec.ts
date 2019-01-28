/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { PersonGroupDetailComponent } from 'app/entities/person-group/person-group-detail.component';
import { PersonGroup } from 'app/shared/model/person-group.model';

describe('Component Tests', () => {
    describe('PersonGroup Management Detail Component', () => {
        let comp: PersonGroupDetailComponent;
        let fixture: ComponentFixture<PersonGroupDetailComponent>;
        const route = ({ data: of({ personGroup: new PersonGroup(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [PersonGroupDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(PersonGroupDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(PersonGroupDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.personGroup).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
