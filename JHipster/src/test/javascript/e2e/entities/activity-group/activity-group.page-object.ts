import { element, by, promise, ElementFinder } from 'protractor';

export class ActivityGroupComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-activity-group div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class ActivityGroupUpdatePage {
    pageTitle = element(by.id('jhi-activity-group-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    descriptionInput = element(by.id('field_description'));
    minAgeInput = element(by.id('field_minAge'));
    maxAgeInput = element(by.id('field_maxAge'));
    activitiesSelect = element(by.id('field_activities'));
    activityGroupCategoriesSelect = element(by.id('field_activityGroupCategories'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setNameInput(name): promise.Promise<void> {
        return this.nameInput.sendKeys(name);
    }

    getNameInput() {
        return this.nameInput.getAttribute('value');
    }

    setDescriptionInput(description): promise.Promise<void> {
        return this.descriptionInput.sendKeys(description);
    }

    getDescriptionInput() {
        return this.descriptionInput.getAttribute('value');
    }

    setMinAgeInput(minAge): promise.Promise<void> {
        return this.minAgeInput.sendKeys(minAge);
    }

    getMinAgeInput() {
        return this.minAgeInput.getAttribute('value');
    }

    setMaxAgeInput(maxAge): promise.Promise<void> {
        return this.maxAgeInput.sendKeys(maxAge);
    }

    getMaxAgeInput() {
        return this.maxAgeInput.getAttribute('value');
    }

    activitiesSelectLastOption(): promise.Promise<void> {
        return this.activitiesSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    activitiesSelectOption(option): promise.Promise<void> {
        return this.activitiesSelect.sendKeys(option);
    }

    getActivitiesSelect(): ElementFinder {
        return this.activitiesSelect;
    }

    getActivitiesSelectedOption() {
        return this.activitiesSelect.element(by.css('option:checked')).getText();
    }

    activityGroupCategoriesSelectLastOption(): promise.Promise<void> {
        return this.activityGroupCategoriesSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    activityGroupCategoriesSelectOption(option): promise.Promise<void> {
        return this.activityGroupCategoriesSelect.sendKeys(option);
    }

    getActivityGroupCategoriesSelect(): ElementFinder {
        return this.activityGroupCategoriesSelect;
    }

    getActivityGroupCategoriesSelectedOption() {
        return this.activityGroupCategoriesSelect.element(by.css('option:checked')).getText();
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
