import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {WorkoutService} from '../../../../services/workout.service';
import {IWorkout} from '../../../../entities/workout';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'ngx-workouts-list',
  templateUrl: './workouts-list.component.html',
  styleUrls: ['./workouts-list.component.scss']
})
export class WorkoutsListComponent implements OnInit {

  tableCols: Array<any>;
  workouts: Array<IWorkout>;

  constructor(private workoutService: WorkoutService,
              private router: Router,
              private messageService: MessageService) { }

  ngOnInit() {

    this.tableCols = [
      { field: 'name', header: 'Název' },
      { field: 'description', header: 'Popis' },
    ];
    this.load();
  }

  load() {
    this.workoutService.query().subscribe((testsResponse: HttpResponse<Array<IWorkout>>) => {
      this.workouts = testsResponse.body;
    });
  }

  rowSelect(workout: IWorkout) {
    this.edit(workout);
  }

  delete(workout: IWorkout) {
    if (confirm('Opravdu chceš smazat cvičení ' + workout.name)) {
      this.workoutService.delete(workout.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Cvičení se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }

  edit(workout: IWorkout) {
    this.router.navigate(['/pages/admin/workouts/edit', workout.id]);
  }

  create() {
    this.router.navigate(['/pages/admin/workouts/create']);
  }
}
