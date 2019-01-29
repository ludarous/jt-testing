import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IActivityGroupResult } from 'app/shared/model/activity-group-result.model';
import { ActivityGroupResultService } from './activity-group-result.service';

@Component({
    selector: 'jhi-activity-group-result-delete-dialog',
    templateUrl: './activity-group-result-delete-dialog.component.html'
})
export class ActivityGroupResultDeleteDialogComponent {
    activityGroupResult: IActivityGroupResult;

    constructor(
        private activityGroupResultService: ActivityGroupResultService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.activityGroupResultService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'activityGroupResultListModification',
                content: 'Deleted an activityGroupResult'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-activity-group-result-delete-popup',
    template: ''
})
export class ActivityGroupResultDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ activityGroupResult }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(ActivityGroupResultDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.activityGroupResult = activityGroupResult;
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
