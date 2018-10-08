import { element, by, ElementFinder } from 'protractor';

export class ActivityResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-activity-result div table .btn-danger'));
    title = element.all(by.css('jhi-activity-result div h2#page-heading span')).first();

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

export class ActivityResultUpdatePage {
    pageTitle = element(by.id('jhi-activity-result-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    primaryResultValueInput = element(by.id('field_primaryResultValue'));
    secondaryResultValueInput = element(by.id('field_secondaryResultValue'));
    noteInput = element(by.id('field_note'));
    testResultSelect = element(by.id('field_testResult'));
    activitySelect = element(by.id('field_activity'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async setPrimaryResultValueInput(primaryResultValue) {
        await this.primaryResultValueInput.sendKeys(primaryResultValue);
    }

    async getPrimaryResultValueInput() {
        return this.primaryResultValueInput.getAttribute('value');
    }

    async setSecondaryResultValueInput(secondaryResultValue) {
        await this.secondaryResultValueInput.sendKeys(secondaryResultValue);
    }

    async getSecondaryResultValueInput() {
        return this.secondaryResultValueInput.getAttribute('value');
    }

    async setNoteInput(note) {
        await this.noteInput.sendKeys(note);
    }

    async getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    async testResultSelectLastOption() {
        await this.testResultSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async testResultSelectOption(option) {
        await this.testResultSelect.sendKeys(option);
    }

    getTestResultSelect(): ElementFinder {
        return this.testResultSelect;
    }

    async getTestResultSelectedOption() {
        return this.testResultSelect.element(by.css('option:checked')).getText();
    }

    async activitySelectLastOption() {
        await this.activitySelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async activitySelectOption(option) {
        await this.activitySelect.sendKeys(option);
    }

    getActivitySelect(): ElementFinder {
        return this.activitySelect;
    }

    async getActivitySelectedOption() {
        return this.activitySelect.element(by.css('option:checked')).getText();
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

export class ActivityResultDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-activityResult-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-activityResult'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
