import { element, by, promise, ElementFinder } from 'protractor';

export class ActivityGroupResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-activity-group-result div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class ActivityGroupResultUpdatePage {
    pageTitle = element(by.id('jhi-activity-group-result-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    noteInput = element(by.id('field_note'));
    eventResultSelect = element(by.id('field_eventResult'));
    activityGroupSelect = element(by.id('field_activityGroup'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setNoteInput(note): promise.Promise<void> {
        return this.noteInput.sendKeys(note);
    }

    getNoteInput() {
        return this.noteInput.getAttribute('value');
    }

    eventResultSelectLastOption(): promise.Promise<void> {
        return this.eventResultSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    eventResultSelectOption(option): promise.Promise<void> {
        return this.eventResultSelect.sendKeys(option);
    }

    getEventResultSelect(): ElementFinder {
        return this.eventResultSelect;
    }

    getEventResultSelectedOption() {
        return this.eventResultSelect.element(by.css('option:checked')).getText();
    }

    activityGroupSelectLastOption(): promise.Promise<void> {
        return this.activityGroupSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    activityGroupSelectOption(option): promise.Promise<void> {
        return this.activityGroupSelect.sendKeys(option);
    }

    getActivityGroupSelect(): ElementFinder {
        return this.activityGroupSelect;
    }

    getActivityGroupSelectedOption() {
        return this.activityGroupSelect.element(by.css('option:checked')).getText();
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
