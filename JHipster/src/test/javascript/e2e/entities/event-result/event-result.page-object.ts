import { element, by, promise, ElementFinder } from 'protractor';

export class EventResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-event-result div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
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

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setNoteInput(note): promise.Promise<void> {
        return this.noteInput.sendKeys(note);
    }

    getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    setActualHeightInCmInput(actualHeightInCm): promise.Promise<void> {
        return this.actualHeightInCmInput.sendKeys(actualHeightInCm);
    }

    getActualHeightInCmInput() {
        return this.actualHeightInCmInput.getAttribute('value');
    }

    setActualWeightInKgInput(actualWeightInKg): promise.Promise<void> {
        return this.actualWeightInKgInput.sendKeys(actualWeightInKg);
    }

    getActualWeightInKgInput() {
        return this.actualWeightInKgInput.getAttribute('value');
    }

    eventSelectLastOption(): promise.Promise<void> {
        return this.eventSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    eventSelectOption(option): promise.Promise<void> {
        return this.eventSelect.sendKeys(option);
    }

    getEventSelect(): ElementFinder {
        return this.eventSelect;
    }

    getEventSelectedOption() {
        return this.eventSelect.element(by.css('option:checked')).getText();
    }

    personSelectLastOption(): promise.Promise<void> {
        return this.personSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    personSelectOption(option): promise.Promise<void> {
        return this.personSelect.sendKeys(option);
    }

    getPersonSelect(): ElementFinder {
        return this.personSelect;
    }

    getPersonSelectedOption() {
        return this.personSelect.element(by.css('option:checked')).getText();
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
