/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { PersonalDataDetailComponent } from 'app/entities/personal-data/personal-data-detail.component';
import { PersonalData } from 'app/shared/model/personal-data.model';

describe('Component Tests', () => {
    describe('PersonalData Management Detail Component', () => {
        let comp: PersonalDataDetailComponent;
        let fixture: ComponentFixture<PersonalDataDetailComponent>;
        const route = ({ data: of({ personalData: new PersonalData(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [PersonalDataDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(PersonalDataDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(PersonalDataDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.personalData).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
