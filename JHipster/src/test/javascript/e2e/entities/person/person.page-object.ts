import { element, by, ElementFinder } from 'protractor';

export class PersonComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    deleteButtons = element.all(by.css('jhi-person div table .btn-danger'));
    title = element.all(by.css('jhi-person div h2#page-heading span')).first();

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

export class PersonUpdatePage {
    pageTitle = element(by.id('jhi-person-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    personalDataSelect = element(by.id('field_personalData'));
    addressSelect = element(by.id('field_address'));

    async getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    async personalDataSelectLastOption() {
        await this.personalDataSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async personalDataSelectOption(option) {
        await this.personalDataSelect.sendKeys(option);
    }

    getPersonalDataSelect(): ElementFinder {
        return this.personalDataSelect;
    }

    async getPersonalDataSelectedOption() {
        return this.personalDataSelect.element(by.css('option:checked')).getText();
    }

    async addressSelectLastOption() {
        await this.addressSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    async addressSelectOption(option) {
        await this.addressSelect.sendKeys(option);
    }

    getAddressSelect(): ElementFinder {
        return this.addressSelect;
    }

    async getAddressSelectedOption() {
        return this.addressSelect.element(by.css('option:checked')).getText();
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

export class PersonDeleteDialog {
    private dialogTitle = element(by.id('jhi-delete-person-heading'));
    private confirmButton = element(by.id('jhi-confirm-delete-person'));

    async getDialogTitle() {
        return this.dialogTitle.getAttribute('jhiTranslate');
    }

    async clickOnConfirmButton() {
        await this.confirmButton.click();
    }
}
