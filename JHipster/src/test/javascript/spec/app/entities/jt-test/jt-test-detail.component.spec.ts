/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { JTTestDetailComponent } from 'app/entities/jt-test/jt-test-detail.component';
import { JTTest } from 'app/shared/model/jt-test.model';

describe('Component Tests', () => {
    describe('JTTest Management Detail Component', () => {
        let comp: JTTestDetailComponent;
        let fixture: ComponentFixture<JTTestDetailComponent>;
        const route = ({ data: of({ jTTest: new JTTest(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [JTTestDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(JTTestDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(JTTestDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.jTTest).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
