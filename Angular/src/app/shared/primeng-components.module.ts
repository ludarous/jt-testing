import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  DataTableModule, DialogModule, TooltipModule, GrowlModule, ConfirmDialogModule, DragDropModule, PanelModule,
  AccordionModule, PanelMenu, MenuModule, PanelMenuModule, DataListModule, OverlayPanelModule, FileUploadModule,
  TreeModule, ConfirmationService,
} from 'primeng/primeng';
import {TableModule} from 'primeng/table';

@NgModule({
  imports: [
    CommonModule
  ],
  providers: [
    ConfirmationService
  ],
  exports: [
    // angular common modules
    CommonModule,
    // primeng components
    TableModule,
    DataTableModule,
    DataListModule,
    DialogModule,
    TooltipModule,
    ConfirmDialogModule,
    PanelModule,
    GrowlModule,
    DragDropModule,
    AccordionModule,
    MenuModule,
    PanelMenuModule,
    OverlayPanelModule,
    FileUploadModule,
    TreeModule
  ],
})
export class PrimeNgComponentsModule { }
