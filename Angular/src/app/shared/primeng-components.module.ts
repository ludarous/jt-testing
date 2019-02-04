import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  DataTableModule,
  DialogModule,
  TooltipModule,
  GrowlModule,
  ConfirmDialogModule,
  DragDropModule,
  PanelModule,
  AccordionModule,
  PanelMenu,
  MenuModule,
  PanelMenuModule,
  DataListModule,
  OverlayPanelModule,
  FileUploadModule,
  TreeModule,
  ConfirmationService,
  TreeTableModule,
  InputTextareaModule,
  InputTextModule,
  MessagesModule,
  MessageModule,
  KeyFilterModule,
  SelectButtonModule, AutoCompleteModule, PickListModule, CalendarModule, DropdownModule, CheckboxModule, ButtonModule, ScrollPanelModule,
} from 'primeng/primeng';
import {TableModule} from 'primeng/table';
import {ToastModule} from 'primeng/toast';
import {DataViewModule} from 'primeng/dataview';
import {FullCalendarModule} from 'primeng/fullcalendar';

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
    TreeModule,
    TreeTableModule,
    ToastModule,
    InputTextareaModule,
    InputTextModule,
    MessagesModule,
    MessageModule,
    KeyFilterModule,
    SelectButtonModule,
    AutoCompleteModule,
    PickListModule,
    DataViewModule,
    CalendarModule,
    FullCalendarModule,
    DropdownModule,
    CheckboxModule,
    ButtonModule,
    ScrollPanelModule
  ],
})
export class PrimeNgComponentsModule { }
