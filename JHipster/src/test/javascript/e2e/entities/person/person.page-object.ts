import { element, by, promise, ElementFinder } from 'protractor';

export class PersonComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-person div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class PersonUpdatePage {
    pageTitle = element(by.id('jhi-person-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    personalDataSelect = element(by.id('field_personalData'));
    addressSelect = element(by.id('field_address'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    personalDataSelectLastOption(): promise.Promise<void> {
        return this.personalDataSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    personalDataSelectOption(option): promise.Promise<void> {
        return this.personalDataSelect.sendKeys(option);
    }

    getPersonalDataSelect(): ElementFinder {
        return this.personalDataSelect;
    }

    getPersonalDataSelectedOption() {
        return this.personalDataSelect.element(by.css('option:checked')).getText();
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
