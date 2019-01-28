import { Component, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { NgbActiveModal, NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';
import { JhiEventManager } from 'ng-jhipster';

import { IPersonGroup } from 'app/shared/model/person-group.model';
import { PersonGroupService } from './person-group.service';

@Component({
    selector: 'jhi-person-group-delete-dialog',
    templateUrl: './person-group-delete-dialog.component.html'
})
export class PersonGroupDeleteDialogComponent {
    personGroup: IPersonGroup;

    constructor(
        private personGroupService: PersonGroupService,
        public activeModal: NgbActiveModal,
        private eventManager: JhiEventManager
    ) {}

    clear() {
        this.activeModal.dismiss('cancel');
    }

    confirmDelete(id: number) {
        this.personGroupService.delete(id).subscribe(response => {
            this.eventManager.broadcast({
                name: 'personGroupListModification',
                content: 'Deleted an personGroup'
            });
            this.activeModal.dismiss(true);
        });
    }
}

@Component({
    selector: 'jhi-person-group-delete-popup',
    template: ''
})
export class PersonGroupDeletePopupComponent implements OnInit, OnDestroy {
    private ngbModalRef: NgbModalRef;

    constructor(private activatedRoute: ActivatedRoute, private router: Router, private modalService: NgbModal) {}

    ngOnInit() {
        this.activatedRoute.data.subscribe(({ personGroup }) => {
            setTimeout(() => {
                this.ngbModalRef = this.modalService.open(PersonGroupDeleteDialogComponent as Component, {
                    size: 'lg',
                    backdrop: 'static'
                });
                this.ngbModalRef.componentInstance.personGroup = personGroup;
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
