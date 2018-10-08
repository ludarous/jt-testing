import { element, by, ElementFinder } from 'protractor';

export class JTTestComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-jt-test div table .btn-danger'));
    title = element.all(by.css('jhi-jt-test div h2#page-heading span')).first();

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

export class JTTestUpdatePage {
    pageTitle = element(by.id('jhi-jt-test-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    descriptionInput = element(by.id('field_description'));
    activitiesSelect = element(by.id('field_activities'));
    categoriesSelect = element(by.id('field_categories'));
    sportsSelect = element(by.id('field_sports'));

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

    async activitiesSelectLastOption() {
        await this.activitiesSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async activitiesSelectOption(option) {
        await this.activitiesSelect.sendKeys(option);
    }

    getActivitiesSelect(): ElementFinder {
        return this.activitiesSelect;
    }

    async getActivitiesSelectedOption() {
        return this.activitiesSelect.element(by.css('option:checked')).getText();
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

    async sportsSelectLastOption() {
        await this.sportsSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async sportsSelectOption(option) {
        await this.sportsSelect.sendKeys(option);
    }

    getSportsSelect(): ElementFinder {
        return this.sportsSelect;
    }

    async getSportsSelectedOption() {
        return this.sportsSelect.element(by.css('option:checked')).getText();
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

export class JTTestDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-jTTest-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-jTTest'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
