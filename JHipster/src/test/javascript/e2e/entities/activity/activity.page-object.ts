import { element, by, promise, ElementFinder } from 'protractor';

export class ActivityComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-activity div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class ActivityUpdatePage {
    pageTitle = element(by.id('jhi-activity-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    descriptionInput = element(by.id('field_description'));
    helpInput = element(by.id('field_help'));
    keyInput = element(by.id('field_key'));
    primaryResultValueUnitSelect = element(by.id('field_primaryResultValueUnit'));
    secondaryResultValueUnitSelect = element(by.id('field_secondaryResultValueUnit'));
    minAgeInput = element(by.id('field_minAge'));
    maxAgeInput = element(by.id('field_maxAge'));
    primaryResultTypeSelect = element(by.id('field_primaryResultType'));
    secondaryResultTypeSelect = element(by.id('field_secondaryResultType'));
    creationTimeInput = element(by.id('field_creationTime'));
    categoriesSelect = element(by.id('field_categories'));
    authorSelect = element(by.id('field_author'));
    groupSelect = element(by.id('field_group'));

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

    setHelpInput(help): promise.Promise<void> {
        return this.helpInput.sendKeys(help);
    }

    getHelpInput() {
        return this.helpInput.getAttribute('value');
    }

    setKeyInput(key): promise.Promise<void> {
        return this.keyInput.sendKeys(key);
    }

    getKeyInput() {
        return this.keyInput.getAttribute('value');
    }

    setPrimaryResultValueUnitSelect(primaryResultValueUnit): promise.Promise<void> {
        return this.primaryResultValueUnitSelect.sendKeys(primaryResultValueUnit);
    }

    getPrimaryResultValueUnitSelect() {
        return this.primaryResultValueUnitSelect.element(by.css('option:checked')).getText();
    }

    primaryResultValueUnitSelectLastOption(): promise.Promise<void> {
        return this.primaryResultValueUnitSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }
    setSecondaryResultValueUnitSelect(secondaryResultValueUnit): promise.Promise<void> {
        return this.secondaryResultValueUnitSelect.sendKeys(secondaryResultValueUnit);
    }

    getSecondaryResultValueUnitSelect() {
        return this.secondaryResultValueUnitSelect.element(by.css('option:checked')).getText();
    }

    secondaryResultValueUnitSelectLastOption(): promise.Promise<void> {
        return this.secondaryResultValueUnitSelect
            .all(by.tagName('option'))
            .last()
            .click();
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

    setPrimaryResultTypeSelect(primaryResultType): promise.Promise<void> {
        return this.primaryResultTypeSelect.sendKeys(primaryResultType);
    }

    getPrimaryResultTypeSelect() {
        return this.primaryResultTypeSelect.element(by.css('option:checked')).getText();
    }

    primaryResultTypeSelectLastOption(): promise.Promise<void> {
        return this.primaryResultTypeSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }
    setSecondaryResultTypeSelect(secondaryResultType): promise.Promise<void> {
        return this.secondaryResultTypeSelect.sendKeys(secondaryResultType);
    }

    getSecondaryResultTypeSelect() {
        return this.secondaryResultTypeSelect.element(by.css('option:checked')).getText();
    }

    secondaryResultTypeSelectLastOption(): promise.Promise<void> {
        return this.secondaryResultTypeSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }
    setCreationTimeInput(creationTime): promise.Promise<void> {
        return this.creationTimeInput.sendKeys(creationTime);
    }

    getCreationTimeInput() {
        return this.creationTimeInput.getAttribute('value');
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

    authorSelectLastOption(): promise.Promise<void> {
        return this.authorSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    authorSelectOption(option): promise.Promise<void> {
        return this.authorSelect.sendKeys(option);
    }

    getAuthorSelect(): ElementFinder {
        return this.authorSelect;
    }

    getAuthorSelectedOption() {
        return this.authorSelect.element(by.css('option:checked')).getText();
    }

    groupSelectLastOption(): promise.Promise<void> {
        return this.groupSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    groupSelectOption(option): promise.Promise<void> {
        return this.groupSelect.sendKeys(option);
    }

    getGroupSelect(): ElementFinder {
        return this.groupSelect;
    }

    getGroupSelectedOption() {
        return this.groupSelect.element(by.css('option:checked')).getText();
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
