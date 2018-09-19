import { element, by, promise, ElementFinder } from 'protractor';

export class ActivityResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-activity-result div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
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

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setPrimaryResultValueInput(primaryResultValue): promise.Promise<void> {
        return this.primaryResultValueInput.sendKeys(primaryResultValue);
    }

    getPrimaryResultValueInput() {
        return this.primaryResultValueInput.getAttribute('value');
    }

    setSecondaryResultValueInput(secondaryResultValue): promise.Promise<void> {
        return this.secondaryResultValueInput.sendKeys(secondaryResultValue);
    }

    getSecondaryResultValueInput() {
        return this.secondaryResultValueInput.getAttribute('value');
    }

    setNoteInput(note): promise.Promise<void> {
        return this.noteInput.sendKeys(note);
    }

    getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    testResultSelectLastOption(): promise.Promise<void> {
        return this.testResultSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    testResultSelectOption(option): promise.Promise<void> {
        return this.testResultSelect.sendKeys(option);
    }

    getTestResultSelect(): ElementFinder {
        return this.testResultSelect;
    }

    getTestResultSelectedOption() {
        return this.testResultSelect.element(by.css('option:checked')).getText();
    }

    activitySelectLastOption(): promise.Promise<void> {
        return this.activitySelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    activitySelectOption(option): promise.Promise<void> {
        return this.activitySelect.sendKeys(option);
    }

    getActivitySelect(): ElementFinder {
        return this.activitySelect;
    }

    getActivitySelectedOption() {
        return this.activitySelect.element(by.css('option:checked')).getText();
    }

    save(): promise.Promise<void> {
        return this.saveButton.click();
    }

    cancel(): promise.Promise<void> {
        return this.cancelButton.click();
    }

    getSaveButton(): ElementFinder {
        return this.saveButton;
    }
}
