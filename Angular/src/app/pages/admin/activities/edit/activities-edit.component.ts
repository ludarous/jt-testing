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
import {ResultType} from '../../../../entities/enums/result-type';

@Component({
  selector: 'app-edit',
  templateUrl: './activities-edit.component.html',
  styleUrls: ['./activities-edit.component.scss']
})
export class ActivitiesEditComponent implements OnInit {

  activityForm: FormGroup;
  activity: IActivity;
  activityId: number;

  units: Array<ActivityResultUnits>;
  resultTypes: Array<ResultType>;
  activityCategories: Array<IActivityCategory>;

  selectedCategories: Array<IActivityCategory>;

  constructor(private activatedRoute: ActivatedRoute,
              private activityService: ActivityService,
              private activityCategoryService: ActivityCategoryService) { }

  ngOnInit() {

    this.units = ActivityResultUnits.getAll();
    this.resultTypes = ResultType.getAll();

    const params$ = this.activatedRoute.params;
    params$.subscribe((params) => {
      this.activityId = +params['id'];

      const getCategories$ = this.activityCategoryService.query();
      const getActivity$ = this.getActivity(this.activityId);

      zip(getActivity$, getCategories$).subscribe(([activity, categories]) => {
        this.activity = activity;
        this.activityCategories = categories.body;
        this.setActivityForm(this.activity, this.activityCategories);
      });

      // this.activityCategoryService.query().subscribe((activityCategoriesResponse: HttpResponse<Array<IActivityCategory>>) => {
      //   this.activityCategories = activityCategoriesResponse.body;
      // });

      // if (this.activityId) {
      //   this.activityService.find(this.activityId).subscribe((activityResponse: HttpResponse<IActivity>) => {
      //     this.activity = Activity.resolveResponse(activityResponse);
      //     this.setActivityForm(this.activity);
      //   });
      // } else {
      //   this.activity = new Activity();
      //   this.setActivityForm(this.activity);
      // }
    });
  }

  onItemSelect(item: any) {
    console.log(item);
  }
  onSelectAll(items: any) {
    console.log(items);
  }

  setActivityForm(activity: IActivity, categories: Array<IActivityCategory>) {

    this.activityForm = new FormGroup({
      id: new FormControl(activity.id),
      name: new FormControl(activity.name),
      description: new FormControl(activity.description),
      help: new FormControl(activity.help),
      key: new FormControl(activity.key),
      primaryResultValueUnit: new FormControl(activity.primaryResultValueUnit ? activity.primaryResultValueUnit.ordinal : null),
      secondaryResultValueUnit: new FormControl(activity.secondaryResultValueUnit ? activity.secondaryResultValueUnit.ordinal : null),
      minAge: new FormControl(activity.minAge, [CustomValidators.integerPositive, Validators.min(0), Validators.max(120)]),
      maxAge: new FormControl(activity.maxAge, [CustomValidators.integerPositive, Validators.min(0), Validators.max(120)]),
      primaryResultType: new FormControl(activity.primaryResultType ? activity.primaryResultType.ordinal : null),
      secondaryResultType: new FormControl(activity.secondaryResultType ? activity.secondaryResultType.ordinal : null),
    });

    if (activity.categories) {
      this.selectedCategories = categories.filter((c) => activity.categories.some((ac) => ac.id === c.id));
    }
  }

  saveActivity() {
    if (this.activityForm.valid) {

      const activityToSave = <IActivity>this.activityForm.value;
      let saveActivity$;
      if (activityToSave.id) {
        saveActivity$ = this.activityService.update(activityToSave);
      } else {
        saveActivity$ = this.activityService.create(activityToSave);
      }

      activityToSave.categories = new Array<IActivityCategory>();
      activityToSave.categories = this.selectedCategories;

      saveActivity$.subscribe((activityResponse: HttpResponse<IActivity>) => {
        this.activity = Activity.resolveResponse(activityResponse);
        this.setActivityForm(this.activity, this.activityCategories);
      });
    }
  }

  getActivity(activityId: number): Observable<IActivity> {
    if (activityId) {
      return this.activityService.find(this.activityId).pipe(map((activityResponse: HttpResponse<IActivity>) => {
        return Activity.resolveResponse(activityResponse);
      }));

    } else {
      return RxjsUtils.create(new Activity());
    }
  }
}
