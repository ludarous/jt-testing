import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IWorkoutResult } from 'app/shared/model/activity-group-result.model';
import { WorkoutResultService } from './workout-result.service';

@Component({
    selector: 'jhi-activity-group-result-delete-dialog',
    templateUrl: './workout-result-delete-dialog.component.html'
})
export class WorkoutResultDeleteDialogComponent {
    workoutResult: IWorkoutResult;

    constructor(
        private workoutResultService: WorkoutResultService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.workoutResultService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'workoutResultListModification',
                content: 'Deleted an workoutResult'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-activity-group-result-delete-popup',
    template: ''
})
export class WorkoutResultDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ workoutResult }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(WorkoutResultDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.workoutResult = workoutResult;
                this.ngbModalRef.result.then(
                    result => {
                        this.router.navigate([{ outlets: { popup: null } }], { replaceUrl: true, queryParamsHandling: 'merge' });
                        this.ngbModalRef = null;
                    },
                    reason => {
                        this.router.navigate([{ outlets: { popup: null } }], { replaceUrl: true, queryParamsHandling: 'merge' });
                        this.ngbModalRef = null;
                    }
                );
            }, 0);
        });
    }

    ngOnDestroy() {
        this.ngbModalRef = null;
    }
}
