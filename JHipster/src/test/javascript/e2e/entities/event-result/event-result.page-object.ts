import { element, by, ElementFinder } from 'protractor';

export class EventResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-event-result div table .btn-danger'));
    title = element.all(by.css('jhi-event-result div h2#page-heading span')).first();

    async clickOnCreateButton() {
        await this.createButton.click();
    }

    async clickOnLastDeleteButton() {
        await this.deleteButtons.last().click();
    }

    async countDeleteButtons() {
        return this.deleteButtons.count();
    }

    async getTitle() {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class EventResultUpdatePage {
    pageTitle = element(by.id('jhi-event-result-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    noteInput = element(by.id('field_note'));
    actualHeightInCmInput = element(by.id('field_actualHeightInCm'));
    actualWeightInKgInput = element(by.id('field_actualWeightInKg'));
    eventSelect = element(by.id('field_event'));
    personSelect = element(by.id('field_person'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async setNoteInput(note) {
        await this.noteInput.sendKeys(note);
    }

    async getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    async setActualHeightInCmInput(actualHeightInCm) {
        await this.actualHeightInCmInput.sendKeys(actualHeightInCm);
    }

    async getActualHeightInCmInput() {
        return this.actualHeightInCmInput.getAttribute('value');
    }

    async setActualWeightInKgInput(actualWeightInKg) {
        await this.actualWeightInKgInput.sendKeys(actualWeightInKg);
    }

    async getActualWeightInKgInput() {
        return this.actualWeightInKgInput.getAttribute('value');
    }

    async eventSelectLastOption() {
        await this.eventSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async eventSelectOption(option) {
        await this.eventSelect.sendKeys(option);
    }

    getEventSelect(): ElementFinder {
        return this.eventSelect;
    }

    async getEventSelectedOption() {
        return this.eventSelect.element(by.css('option:checked')).getText();
    }

    async personSelectLastOption() {
        await this.personSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async personSelectOption(option) {
        await this.personSelect.sendKeys(option);
    }

    getPersonSelect(): ElementFinder {
        return this.personSelect;
    }

    async getPersonSelectedOption() {
        return this.personSelect.element(by.css('option:checked')).getText();
    }

    async save() {
        await this.saveButton.click();
    }

    async cancel() {
        await this.cancelButton.click();
    }

    getSaveButton(): ElementFinder {
        return this.saveButton;
    }
}

export class EventResultDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-eventResult-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-eventResult'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
