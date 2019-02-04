import { Component, OnInit } from '@angular/core';
import {HttpErrorResponse, HttpResponse} from '@angular/common/http';
import {Router} from '@angular/router';
import {WorkoutService} from '../../../../services/workout.service';
import {IWorkout} from '../../../../entities/workout';
import {MessageService} from 'primeng/api';

@Component({
  selector: 'app-tests-list',
  templateUrl: './workouts-list.component.html',
  styleUrls: ['./workouts-list.component.scss']
})
export class WorkoutsListComponent implements OnInit {

  tableCols: Array<any>;
  tests: Array<IWorkout>;

  constructor(private WorkoutService: WorkoutService,
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
    this.WorkoutService.query().subscribe((testsResponse: HttpResponse<Array<IWorkout>>) => {
      this.tests = testsResponse.body;
    });
  }

  rowSelect(test: IWorkout) {
    this.router.navigate(['/admin/workouts/edit', test.id]);
  }

  delete(event, test: IWorkout) {
    event.stopPropagation();

    if (confirm('Opravdu chceš smazat test ' + test.name)) {
      this.WorkoutService.delete(test.id).subscribe(() => {
        this.load();
      }, (errorResponse: HttpErrorResponse) => {
        this.messageService.add({severity: 'error', summary: 'Test se nepodařilo smazat', detail: errorResponse.error.detail});
      });
    }

  }
}
