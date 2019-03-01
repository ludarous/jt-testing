import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {FormControl, FormGroup} from '@angular/forms';
import {IActivity} from '../../../../entities/activity';
import {IActivityCategory} from '../../../../entities/activity-category';
import {ActivatedRoute, Router} from '@angular/router';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityService} from '../../../../services/activity.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../../../../NgxAdmin/src/app/@core/utils/rxjs.utils';
import {Workout, IWorkout} from '../../../../entities/workout';
import {ISport} from '../../../../entities/sport';
import {WorkoutService} from '../../../../services/workout.service';
import {WorkoutCategoryService} from '../../../../services/workout-category.service';
import {SportService} from '../../../../services/sport.service';
import {IWorkoutCategory} from '../../../../entities/workout-category';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-edit',
  templateUrl: './workouts-edit.component.html',
  styleUrls: ['./workouts-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class WorkoutsEditComponent implements OnInit {

  testForm: FormGroup;
  test: IWorkout;
  testId: number;

  testActivities: Array<IActivity>;
  suggestedActivities: Array<IActivity> = new Array<IActivity>();
  selectedActivities: Array<IActivity> = new Array<IActivity>();

  testCategories: Array<IWorkoutCategory>;
  suggestedCategories: Array<IWorkoutCategory>;
  selectedCategories: Array<IWorkoutCategory>;

  sports: Array<ISport>;
  selectedSports: Array<ISport>;

  constructor(private activatedRoute: ActivatedRoute,
              private activityService: ActivityService,
              private workoutService: WorkoutService,
              private workoutCategoryService: WorkoutCategoryService,
              private sportService: SportService,
              private messageService: MessageService,
              private router: Router) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.testId = +params['id'];

      const getActivities$ = this.activityService.query({
        page: 0,
        size: 1000,
      });
      const getCategories$ = this.workoutCategoryService.query({
        page: 0,
        size: 1000,
      });
      const getSports$ = this.sportService.query({
        page: 0,
        size: 1000,
      });
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

  setTestForm(test: IWorkout, activities: Array<IActivity>, categories: Array<IActivityCategory>, sports: Array<ISport>) {

    this.testForm = new FormGroup({
      id: new FormControl(test.id),
      name: new FormControl(test.name),
      minAge: new FormControl(test.minAge),
      maxAge: new FormControl(test.maxAge)
    });

    if (activities && test.activities) {
      this.selectedActivities = activities.filter((a) => test.activities.some((sa) => sa.id === a.id));
      this.suggestedActivities = activities.filter((a) => !this.selectedActivities.some((sa) => sa.id === a.id));
    } else {
      this.suggestedActivities = activities;
    }

    if (sports && test.sports) {
      this.selectedSports = sports.filter((s) => test.sports.some((ss) => ss.id === s.id));
    }

    if (categories && test.categories) {
      this.selectedCategories = categories.filter((c) => test.categories.some((sc) => sc.id === c.id));
    }

  }

  saveWorkout() {
    if (this.testForm.valid) {

      const testToSave = <IWorkout>this.testForm.value;
      let saveTest$;
      if (testToSave.id) {
        saveTest$ = this.workoutService.update(testToSave);
      } else {
        saveTest$ = this.workoutService.create(testToSave);
      }

      testToSave.categories = this.selectedCategories;
      testToSave.activities = this.selectedActivities;
      testToSave.sports = this.selectedSports;

      saveTest$.subscribe(
        (testResponse: HttpResponse<IWorkout>) => {
        this.test = testResponse.body;
        this.setTestForm(this.test, this.testActivities, this.testCategories, this.sports);
          this.messageService.add({severity: 'success', summary: 'Test uložen'});
          this.router.navigate(['/admin/workouts/list']);
      },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Test nebyl uložen', detail: errorResponse.error.detail});
        });
    }
  }

  getTest(testId: number): Observable<IWorkout> {
    if (testId) {
      return this.workoutService.find(testId).pipe(map((activityResponse: HttpResponse<IWorkout>) => {
        return activityResponse.body;
      }));

    } else {
      return RxjsUtils.create(new Workout());
    }
  }

  duplicateTest() {
    this.testForm.controls['id'].setValue(null);
    const testName = this.testForm.controls['name'].value;
    this.testForm.controls['name'].setValue(testName + ' kopie');

    this.saveWorkout();
  }

  search(event) {
    const filteredCategories = this.testCategories.filter(c => c.name.includes(event.query));
    this.suggestedCategories = filteredCategories;
  }
}