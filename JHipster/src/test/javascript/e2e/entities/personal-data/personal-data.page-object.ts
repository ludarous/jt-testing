import { element, by, promise, ElementFinder } from 'protractor';

export class PersonalDataComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-personal-data div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
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

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setFirstNameInput(firstName): promise.Promise<void> {
        return this.firstNameInput.sendKeys(firstName);
    }

    getFirstNameInput() {
        return this.firstNameInput.getAttribute('value');
    }

    setLastNameInput(lastName): promise.Promise<void> {
        return this.lastNameInput.sendKeys(lastName);
    }

    getLastNameInput() {
        return this.lastNameInput.getAttribute('value');
    }

    setBirthDateInput(birthDate): promise.Promise<void> {
        return this.birthDateInput.sendKeys(birthDate);
    }

    getBirthDateInput() {
        return this.birthDateInput.getAttribute('value');
    }

    setNationalityInput(nationality): promise.Promise<void> {
        return this.nationalityInput.sendKeys(nationality);
    }

    getNationalityInput() {
        return this.nationalityInput.getAttribute('value');
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
