import { element, by, ElementFinder } from 'protractor';

export class PersonalDataComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-personal-data div table .btn-danger'));
    title = element.all(by.css('jhi-personal-data div h2#page-heading span')).first();

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

export class PersonalDataUpdatePage {
    pageTitle = element(by.id('jhi-personal-data-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    firstNameInput = element(by.id('field_firstName'));
    lastNameInput = element(by.id('field_lastName'));
    birthDateInput = element(by.id('field_birthDate'));
    nationalityInput = element(by.id('field_nationality'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async setFirstNameInput(firstName) {
        await this.firstNameInput.sendKeys(firstName);
    }

    async getFirstNameInput() {
        return this.firstNameInput.getAttribute('value');
    }

    async setLastNameInput(lastName) {
        await this.lastNameInput.sendKeys(lastName);
    }

    async getLastNameInput() {
        return this.lastNameInput.getAttribute('value');
    }

    async setBirthDateInput(birthDate) {
        await this.birthDateInput.sendKeys(birthDate);
    }

    async getBirthDateInput() {
        return this.birthDateInput.getAttribute('value');
    }

    async setNationalityInput(nationality) {
        await this.nationalityInput.sendKeys(nationality);
    }

    async getNationalityInput() {
        return this.nationalityInput.getAttribute('value');
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

export class PersonalDataDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-personalData-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-personalData'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
