import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IActivityGroupCategory } from 'app/shared/model/activity-group-category.model';
import { ActivityGroupCategoryService } from './activity-group-category.service';

@Component({
    selector: 'jhi-activity-group-category-delete-dialog',
    templateUrl: './activity-group-category-delete-dialog.component.html'
})
export class ActivityGroupCategoryDeleteDialogComponent {
    activityGroupCategory: IActivityGroupCategory;

    constructor(
        private activityGroupCategoryService: ActivityGroupCategoryService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.activityGroupCategoryService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'activityGroupCategoryListModification',
                content: 'Deleted an activityGroupCategory'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-activity-group-category-delete-popup',
    template: ''
})
export class ActivityGroupCategoryDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ activityGroupCategory }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(ActivityGroupCategoryDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.activityGroupCategory = activityGroupCategory;
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
