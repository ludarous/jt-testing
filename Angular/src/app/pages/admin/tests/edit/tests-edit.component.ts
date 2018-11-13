import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormArray, FormControl, FormGroup, Validators} from '@angular/forms';
import {Activity, IActivity} from '../../../../entities/activity';
import {ActivityCategory, IActivityCategory} from '../../../../entities/activity-category';
import {ActivatedRoute} from '@angular/router';
import {HttpResponse} from '@angular/common/http';
import {ActivityService} from '../../../../services/activity.service';
import {ActivityResultUnits} from '../../../../entities/enums/activity-result-units';
import {CustomValidators} from '../../../../shared/validators/custom-validators';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {ITest, Test} from '../../../../entities/test';
import {ISport} from '../../../../entities/sport';
import {TestService} from '../../../../services/test.service';
import {TestCategoryService} from '../../../../services/test-category.service';
import {SportService} from '../../../../services/sport.service';

@Component({
  selector: 'app-tests-edit',
  templateUrl: './tests-edit.component.html',
  styleUrls: ['./tests-edit.component.scss']
})
export class TestsEditComponent implements OnInit {

  testForm: FormGroup;
  test: ITest;
  testId: number;

  testActivities: Array<IActivity>;
  selectedActivities: Array<IActivity>;

  testCategories: Array<IActivityCategory>;
  selectedCategories: Array<IActivityCategory>;

  sports: Array<ISport>;
  selectedSports: Array<ISport>;

  constructor(private activatedRoute: ActivatedRoute,
              private activityService: ActivityService,
              private testService: TestService,
              private testCategoryService: TestCategoryService,
              private sportService: SportService) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.testId = +params['id'];

      const getActivities$ = this.activityService.query();
      const getCategories$ = this.testCategoryService.query();
      const getSports$ = this.sportService.query();
      const getTest$ = this.getTest(this.testId);

      zip(getTest$, getActivities$, getCategories$, getSports$).subscribe(([test, activities, categories, sports]) => {
        this.test = test;
        this.testCategories = categories.body;
        this.sports = sports.body;
        this.testActivities = activities.body;

        this.setTestForm(this.test, this.testActivities, this.testCategories, this.sports);
      });

    });
  }

  onItemSelect(item: any) {
    console.log(item);
  }
  onSelectAll(items: any) {
    console.log(items);
  }

  setTestForm(test: ITest, activities: Array<IActivity>, categories: Array<IActivityCategory>, sports: Array<ISport>) {

    this.testForm = new FormGroup({
      id: new FormControl(test.id),
      name: new FormControl(test.name),
    });

    if (test.activities) {
      this.selectedActivities = activities.filter((a) => test.activities.some((sa) => sa.id === a.id));
    }

    if (test.sports) {
      this.selectedSports = sports.filter((s) => test.sports.some((ss) => ss.id === s.id));
    }

    if (test.categories) {
      this.selectedCategories = categories.filter((c) => test.categories.some((sc) => sc.id === c.id));
    }

  }

  saveTest() {
    if (this.testForm.valid) {

      const testToSave = <ITest>this.testForm.value;
      let saveTest$;
      if (testToSave.id) {
        saveTest$ = this.testService.update(testToSave);
      } else {
        saveTest$ = this.testService.create(testToSave);
      }

      testToSave.categories = this.selectedCategories;
      testToSave.activities = this.selectedActivities;
      testToSave.sports = this.selectedSports;

      saveTest$.subscribe((testResponse: HttpResponse<ITest>) => {
        this.test = testResponse.body;
        this.setTestForm(this.test, this.testActivities, this.testCategories, this.sports);
      });
    }
  }

  getTest(testId: number): Observable<ITest> {
    if (testId) {
      return this.testService.find(testId).pipe(map((activityResponse: HttpResponse<ITest>) => {
        return activityResponse.body;
      }));

    } else {
      return RxjsUtils.create(new Test());
    }
  }
}
