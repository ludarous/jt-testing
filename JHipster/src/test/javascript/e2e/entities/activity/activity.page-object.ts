import { element, by, ElementFinder } from 'protractor';

export class ActivityComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-activity div table .btn-danger'));
    title = element.all(by.css('jhi-activity div h2#page-heading span')).first();

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
    categoriesSelect = element(by.id('field_categories'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async setNameInput(name) {
        await this.nameInput.sendKeys(name);
    }

    async getNameInput() {
        return this.nameInput.getAttribute('value');
    }

    async setDescriptionInput(description) {
        await this.descriptionInput.sendKeys(description);
    }

    async getDescriptionInput() {
        return this.descriptionInput.getAttribute('value');
    }

    async setHelpInput(help) {
        await this.helpInput.sendKeys(help);
    }

    async getHelpInput() {
        return this.helpInput.getAttribute('value');
    }

    async setKeyInput(key) {
        await this.keyInput.sendKeys(key);
    }

    async getKeyInput() {
        return this.keyInput.getAttribute('value');
    }

    async setPrimaryResultValueUnitSelect(primaryResultValueUnit) {
        await this.primaryResultValueUnitSelect.sendKeys(primaryResultValueUnit);
    }

    async getPrimaryResultValueUnitSelect() {
        return this.primaryResultValueUnitSelect.element(by.css('option:checked')).getText();
    }

    async primaryResultValueUnitSelectLastOption() {
        await this.primaryResultValueUnitSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async setSecondaryResultValueUnitSelect(secondaryResultValueUnit) {
        await this.secondaryResultValueUnitSelect.sendKeys(secondaryResultValueUnit);
    }

    async getSecondaryResultValueUnitSelect() {
        return this.secondaryResultValueUnitSelect.element(by.css('option:checked')).getText();
    }

    async secondaryResultValueUnitSelectLastOption() {
        await this.secondaryResultValueUnitSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async setMinAgeInput(minAge) {
        await this.minAgeInput.sendKeys(minAge);
    }

    async getMinAgeInput() {
        return this.minAgeInput.getAttribute('value');
    }

    async setMaxAgeInput(maxAge) {
        await this.maxAgeInput.sendKeys(maxAge);
    }

    async getMaxAgeInput() {
        return this.maxAgeInput.getAttribute('value');
    }

    async categoriesSelectLastOption() {
        await this.categoriesSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async categoriesSelectOption(option) {
        await this.categoriesSelect.sendKeys(option);
    }

    getCategoriesSelect(): ElementFinder {
        return this.categoriesSelect;
    }

    async getCategoriesSelectedOption() {
        return this.categoriesSelect.element(by.css('option:checked')).getText();
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

export class ActivityDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-activity-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-activity'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
