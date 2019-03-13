import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
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
import {ArrayUtils} from '../../../../@core/utils/array.utils';
import {NbStepperComponent, NbToastrService} from '@nebular/theme';
import {ToasterService} from 'angular2-toaster';
import {TranslateService} from '@ngx-translate/core';

@Component({
  selector: 'ngx-workout-edit',
  templateUrl: './workouts-edit.component.html',
  styleUrls: ['./workouts-edit.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class WorkoutsEditComponent implements OnInit {

  workoutForm: FormGroup;
  workout: IWorkout;
  workoutId: number;

  workoutActivities: Array<IActivity>;
  suggestedActivities: Array<IActivity> = new Array<IActivity>();
  selectedActivities: Array<IActivity> = new Array<IActivity>();
  activityFilter: string;

  draggedActivity: IActivity;

  workoutCategories: Array<IWorkoutCategory>;
  suggestedCategories: Array<IWorkoutCategory>;
  selectedCategories: Array<IWorkoutCategory>;

  sports: Array<ISport>;
  selectedSports: Array<ISport>;

  selectedStepperIndex = 0;

  submitted: false;

  @ViewChild('stepper')
  stepper: NbStepperComponent;

  constructor(private activatedRoute: ActivatedRoute,
              private activityService: ActivityService,
              private workoutService: WorkoutService,
              private workoutCategoryService: WorkoutCategoryService,
              private sportService: SportService,
              private messageService: MessageService,
              private toasterService: NbToastrService,
              private translateService: TranslateService,
              private router: Router) { }

  ngOnInit() {

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.workoutId = +params['id'];

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
      const getTest$ = this.getTest(this.workoutId);

      zip(getTest$, getActivities$, getCategories$, getSports$).subscribe(([workout, activities, categories, sports]) => {
        this.workout = workout;
        this.workoutCategories = categories.body;
        this.sports = sports.body;
        this.workoutActivities = activities.body;

        this.setTestForm(this.workout, this.workoutActivities, this.workoutCategories, this.sports);
      });

    });
  }

  onItemSelect(item: any) {
    console.log(item);
  }
  onSelectAll(items: any) {
    console.log(items);
  }

  setTestForm(workout: IWorkout, activities: Array<IActivity>, categories: Array<IActivityCategory>, sports: Array<ISport>) {

    this.workoutForm = new FormGroup({
      id: new FormControl(workout.id),
      name: new FormControl(workout.name),
      description: new FormControl(workout.description),
      minAge: new FormControl(workout.minAge),
      maxAge: new FormControl(workout.maxAge)
    });

    if (activities && workout.activities) {
      this.selectedActivities = activities.filter((a) => workout.activities.some((sa) => sa.id === a.id));
      this.suggestedActivities = activities.filter((a) => !this.selectedActivities.some((sa) => sa.id === a.id));
    } else {
      this.suggestedActivities = activities;
    }

    if (sports && workout.sports) {
      this.selectedSports = sports.filter((s) => workout.sports.some((ss) => ss.id === s.id));
    }

    if (categories && workout.categories) {
      this.selectedCategories = categories.filter((c) => workout.categories.some((sc) => sc.id === c.id));
    }

  }

  saveWorkout() {
    if (this.workoutForm.valid) {

      const workoutToSave = <IWorkout>this.workoutForm.value;
      let saveWorkout$;
      if (workoutToSave.id) {
        saveWorkout$ = this.workoutService.update(workoutToSave);
      } else {
        saveWorkout$ = this.workoutService.create(workoutToSave);
      }

      workoutToSave.categories = this.selectedCategories;
      workoutToSave.activities = this.selectedActivities;
      workoutToSave.sports = this.selectedSports;

      saveWorkout$.subscribe(
        (workoutResponse: HttpResponse<IWorkout>) => {
        this.workout = workoutResponse.body;
        this.setTestForm(this.workout, this.workoutActivities, this.workoutCategories, this.sports);
          this.toasterService.success(null, this.translateService.instant('Test uložen'));
          this.router.navigate(['/pages/admin/workouts/list']);
      },
        (errorResponse: HttpErrorResponse) => {
          this.toasterService.danger(null, this.translateService.instant('Test nebyl uloženo'));
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
    this.workoutForm.controls['id'].setValue(null);
    const workoutName = this.workoutForm.controls['name'].value;
    this.workoutForm.controls['name'].setValue(workoutName + ' kopie');

    this.saveWorkout();
  }

  search(event) {
    const filteredCategories = this.workoutCategories.filter(c => c.name.includes(this.activityFilter));
    this.suggestedCategories = [...filteredCategories];
  }

  filterActivity(activity: IActivity, filter: string): boolean {
    if (filter && filter.length > 0) {
      return activity.name.toLowerCase().includes(filter.toLowerCase()) ||
        activity.categories.some(c => c.name.toLowerCase().includes(filter.toLowerCase()));
    }
    return true;
  }

  /* DRAG n DROP */

  sourceDragStart($event, activity: IActivity) {
    this.draggedActivity = activity;
  }

  sourceDragEnd($event) {
    this.draggedActivity = null;
  }

  sourceDrop($event) {
    this.workoutActivities.push(this.draggedActivity);
    ArrayUtils.removeItem(this.selectedActivities, this.draggedActivity);
  }

  targetDragStart($event, activity: IActivity) {
    this.draggedActivity = activity;
  }

  targetDragEnd($event) {
    this.draggedActivity = null;
  }

  targetDrop($event) {
    this.selectedActivities.push(this.draggedActivity);
    ArrayUtils.removeItem(this.workoutActivities, this.draggedActivity);
    ArrayUtils.removeItem(this.suggestedActivities, this.draggedActivity);
  }



}
