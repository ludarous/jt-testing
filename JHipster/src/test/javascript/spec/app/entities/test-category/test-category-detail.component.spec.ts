/* tslint:disable max-line-length */
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ActivatedRoute } from '@angular/router';
import { of } from 'rxjs';

import { JtTestingTestModule } from '../../../test.module';
import { TestCategoryDetailComponent } from 'app/entities/test-category/test-category-detail.component';
import { TestCategory } from 'app/shared/model/test-category.model';

describe('Component Tests', () => {
    describe('TestCategory Management Detail Component', () => {
        let comp: TestCategoryDetailComponent;
        let fixture: ComponentFixture<TestCategoryDetailComponent>;
        const route = ({ data: of({ testCategory: new TestCategory(123) }) } as any) as ActivatedRoute;

        beforeEach(() => {
            TestBed.configureTestingModule({
                imports: [JtTestingTestModule],
                declarations: [TestCategoryDetailComponent],
                providers: [{ provide: ActivatedRoute, useValue: route }]
            })
                .overrideTemplate(TestCategoryDetailComponent, '')
                .compileComponents();
            fixture = TestBed.createComponent(TestCategoryDetailComponent);
            comp = fixture.componentInstance;
        });

        describe('OnInit', () => {
            it('Should call load all on init', () => {
                // GIVEN

                // WHEN
                comp.ngOnInit();

                // THEN
                expect(comp.testCategory).toEqual(jasmine.objectContaining({ id: 123 }));
            });
        });
    });
});
