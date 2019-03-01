import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {Activity, IActivity} from '../../../../entities/activity';
import {ActivityResult, IActivityResult} from '../../../../entities/activity-result';
import {IWorkoutResult} from '../../../../entities/workout-result';
import {FormControl, FormGroup} from '@angular/forms';
import {IEvent} from '../../../../entities/event';
import {IActivityCategory} from '../../../../entities/activity-category';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {ActivityResultService} from '../../../../services/activity-result.service';
import {NbToastrService} from '@nebular/theme';
import {TranslateService} from '@ngx-translate/core';
import {Router} from '@angular/router';

@Component({
  selector: 'ngx-activity-result-edit',
  templateUrl: './activity-result-edit.component.html',
  styleUrls: ['./activity-result-edit.component.scss']
})
export class ActivityResultEditComponent implements OnInit {

  constructor(private activityResultService: ActivityResultService,
              private toasterService: NbToastrService,
              private translateService: TranslateService,
              private router: Router) { }

  private _activity: IActivity;
  @Input()
  get activity(): IActivity {
    return this._activity;
  }

  set activity(value: IActivity) {
    this._activity = value;
  }

  private _activityResult: IActivityResult;
  @Input()
  get activityResult(): IActivityResult {
    return this._activityResult;
  }

  set activityResult(value: IActivityResult) {
    if (value) {
      this._activityResult = value;
      this.setActivityResultForm(this._activityResult);
    }
  }

  private _workoutResult: IWorkoutResult;
  @Input()
  get workoutResult(): IWorkoutResult {
    return this._workoutResult;
  }

  set workoutResult(value: IWorkoutResult) {
    this._workoutResult = value;
  }

  private _event: IEvent;
  @Input()
  get event(): IEvent {
    return this._event;
  }

  set event(value: IEvent) {
    this._event = value;
  }

  @Output()
  saveSuccess: EventEmitter<IActivityResult> = new EventEmitter<IActivityResult>();

  activityResultForm: FormGroup;
  submitted: boolean;

  ngOnInit() {
    // if (!this.activityResult) this.activityResult = new ActivityResult();
    if (this.activityResult) {
      this.setActivityResultForm(this.activityResult);
    }
  }

  setActivityResultForm(activityResult: IActivityResult) {
    this.activityResultForm = new FormGroup({
      id: new FormControl(activityResult.id),
      note: new FormControl(activityResult.note),
      primaryResultValue: new FormControl(activityResult.primaryResultValue),
      secondaryResultValue: new FormControl(activityResult.secondaryResultValue),
      workoutResultId: new FormControl(activityResult.workoutResultId),
      activityId: new FormControl(activityResult.activityId),
      date: new FormControl(this.event ? this.event.date : null)
    });
  }

  saveActivityResult() {
    if (this.activityResultForm.valid) {

      const activityResultToSave = <IActivityResult>this.activityResultForm.value;
      let saveActivityResult$;
      if (activityResultToSave.id) {
        saveActivityResult$ = this.activityResultService.update(activityResultToSave);
      } else {
        saveActivityResult$ = this.activityResultService.create(activityResultToSave);
      }


      saveActivityResult$.subscribe(
        (activityResultResponse: HttpResponse<IActivityResult>) => {
          this.activityResult = activityResultResponse.body;
          this.setActivityResultForm(this.activityResult);
          this.toasterService.success(null, this.translateService.instant('Výsledek uložen'));
          this.saveSuccess.emit(this.activityResult);
        },
        (errorResponse: HttpErrorResponse) => {
          this.toasterService.danger(null, this.translateService.instant('Výsledek nebyl uložen'));
        });
    }
  }

}
