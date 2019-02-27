import { element, by, promise, ElementFinder } from 'protractor';

export class WorkoutResultComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-workout-result div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class WorkoutResultUpdatePage {
    pageTitle = element(by.id('jhi-workout-result-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    noteInput = element(by.id('field_note'));
    eventResultSelect = element(by.id('field_eventResult'));
    workoutSelect = element(by.id('field_workout'));

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

    workoutSelectLastOption(): promise.Promise<void> {
        return this.workoutSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    workoutSelectOption(option): promise.Promise<void> {
        return this.workoutSelect.sendKeys(option);
    }

    getWorkoutSelect(): ElementFinder {
        return this.workoutSelect;
    }

    getWorkoutSelectedOption() {
        return this.workoutSelect.element(by.css('option:checked')).getText();
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
