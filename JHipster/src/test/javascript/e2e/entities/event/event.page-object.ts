import { element, by, promise, ElementFinder } from 'protractor';

export class EventComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-event div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class EventUpdatePage {
    pageTitle = element(by.id('jhi-event-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    dateInput = element(by.id('field_date'));
    addressSelect = element(by.id('field_address'));
    testsSelect = element(by.id('field_tests'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setNameInput(name): promise.Promise<void> {
        return this.nameInput.sendKeys(name);
    }

    getNameInput() {
        return this.nameInput.getAttribute('value');
    }

    setDateInput(date): promise.Promise<void> {
        return this.dateInput.sendKeys(date);
    }

    getDateInput() {
        return this.dateInput.getAttribute('value');
    }

    addressSelectLastOption(): promise.Promise<void> {
        return this.addressSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    addressSelectOption(option): promise.Promise<void> {
        return this.addressSelect.sendKeys(option);
    }

    getAddressSelect(): ElementFinder {
        return this.addressSelect;
    }

    getAddressSelectedOption() {
        return this.addressSelect.element(by.css('option:checked')).getText();
    }

    testsSelectLastOption(): promise.Promise<void> {
        return this.testsSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    testsSelectOption(option): promise.Promise<void> {
        return this.testsSelect.sendKeys(option);
    }

    getTestsSelect(): ElementFinder {
        return this.testsSelect;
    }

    getTestsSelectedOption() {
        return this.testsSelect.element(by.css('option:checked')).getText();
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
