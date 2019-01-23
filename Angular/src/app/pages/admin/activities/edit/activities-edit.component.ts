import { Component, OnInit } from '@angular/core';
import {AbstractControl, FormArray, FormControl, FormGroup, Validators} from '@angular/forms';
import {Activity, IActivity} from '../../../../entities/activity';
import {ActivityCategory, IActivityCategory} from '../../../../entities/activity-category';
import {ActivatedRoute, Router} from '@angular/router';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityService} from '../../../../services/activity.service';
import {ActivityResultUnits} from '../../../../entities/enums/activity-result-units';
import {CustomValidators} from '../../../../shared/validators/custom-validators';
import {ActivityCategoryService} from '../../../../services/activity-category.service';
import {Observable, zip} from 'rxjs';
import {map} from 'rxjs/operators';
import {RxjsUtils} from '../../../../utils/rxjs.utils';
import {ResultType} from '../../../../entities/enums/result-type';
import {MessageService, SelectItem} from 'primeng/api';
import {ArrayUtils} from '../../../../utils/array.utils';
import {TranslateService} from '@ngx-translate/core';
import {EnumTranslatorService} from '../../../../shared/pipes/enum-translator/enum-translator';

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
  unitsOptions: Array<SelectItem>;

  resultTypes: Array<ResultType>;
  resultTypesOptions: Array<SelectItem>;

  activityCategories: Array<IActivityCategory>;
  suggestedCategories: Array<IActivityCategory>;
  selectedCategories: Array<IActivityCategory>;

  constructor(private activatedRoute: ActivatedRoute,
              private activityService: ActivityService,
              private activityCategoryService: ActivityCategoryService,
              private enumTranslateService: EnumTranslatorService,
              private messageService: MessageService,
              private router: Router) {
  }

  ngOnInit() {

    this.units = ActivityResultUnits.getAll();
    this.resultTypes = ResultType.getAll();

    this.unitsOptions = this.units.map(u => ({label: this.enumTranslateService.translate(u, 'plural-1p'), value: u.ordinal}));
    ArrayUtils.insertItem(this.unitsOptions, {label: 'NONE', value: null}, 0);

    this.resultTypesOptions = this.resultTypes.map(rt => ({label: this.enumTranslateService.translate(rt, 'plural'), value: rt.ordinal}));

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
      name: new FormControl(activity.name, Validators.required),
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

      saveActivity$.subscribe(
        (activityResponse: HttpResponse<IActivity>) => {
        this.activity = Activity.resolveResponse(activityResponse);
        this.setActivityForm(this.activity, this.activityCategories);
          this.messageService.add({severity: 'success', summary: 'Aktivita uložena'});
          this.router.navigate(['/admin/activities/list']);
      },
        (errorResponse: HttpErrorResponse) => {
          this.messageService.add({severity: 'error', summary: 'Aktivita nebyla uložena', detail: errorResponse.error.detail});
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

  search(event) {
    const filteredCategories = this.activityCategories.filter(c => c.name.includes(event.query));
    this.suggestedCategories = filteredCategories;
  }
}

