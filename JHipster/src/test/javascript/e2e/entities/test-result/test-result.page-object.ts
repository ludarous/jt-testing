import { element, by, ElementFinder } from 'protractor';

export class TestResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-test-result div table .btn-danger'));
    title = element.all(by.css('jhi-test-result div h2#page-heading span')).first();

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

export class TestResultUpdatePage {
    pageTitle = element(by.id('jhi-test-result-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    noteInput = element(by.id('field_note'));
    eventResultSelect = element(by.id('field_eventResult'));
    testSelect = element(by.id('field_test'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async setNoteInput(note) {
        await this.noteInput.sendKeys(note);
    }

    async getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    async eventResultSelectLastOption() {
        await this.eventResultSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async eventResultSelectOption(option) {
        await this.eventResultSelect.sendKeys(option);
    }

    getEventResultSelect(): ElementFinder {
        return this.eventResultSelect;
    }

    async getEventResultSelectedOption() {
        return this.eventResultSelect.element(by.css('option:checked')).getText();
    }

    async testSelectLastOption() {
        await this.testSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async testSelectOption(option) {
        await this.testSelect.sendKeys(option);
    }

    getTestSelect(): ElementFinder {
        return this.testSelect;
    }

    async getTestSelectedOption() {
        return this.testSelect.element(by.css('option:checked')).getText();
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

export class TestResultDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-testResult-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-testResult'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
