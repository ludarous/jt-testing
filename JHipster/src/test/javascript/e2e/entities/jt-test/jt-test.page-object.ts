import { element, by, promise, ElementFinder } from 'protractor';

export class JTTestComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-jt-test div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class JTTestUpdatePage {
    pageTitle = element(by.id('jhi-jt-test-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    descriptionInput = element(by.id('field_description'));
    minAgeInput = element(by.id('field_minAge'));
    maxAgeInput = element(by.id('field_maxAge'));
    activitiesSelect = element(by.id('field_activities'));
    categoriesSelect = element(by.id('field_categories'));
    sportsSelect = element(by.id('field_sports'));

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

    categoriesSelectLastOption(): promise.Promise<void> {
        return this.categoriesSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    categoriesSelectOption(option): promise.Promise<void> {
        return this.categoriesSelect.sendKeys(option);
    }

    getCategoriesSelect(): ElementFinder {
        return this.categoriesSelect;
    }

    getCategoriesSelectedOption() {
        return this.categoriesSelect.element(by.css('option:checked')).getText();
    }

    sportsSelectLastOption(): promise.Promise<void> {
        return this.sportsSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    sportsSelectOption(option): promise.Promise<void> {
        return this.sportsSelect.sendKeys(option);
    }

    getSportsSelect(): ElementFinder {
        return this.sportsSelect;
    }

    getSportsSelectedOption() {
        return this.sportsSelect.element(by.css('option:checked')).getText();
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
