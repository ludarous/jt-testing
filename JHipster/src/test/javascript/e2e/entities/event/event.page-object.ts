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
    minAgeInput = element(by.id('field_minAge'));
    maxAgeInput = element(by.id('field_maxAge'));
    addressSelect = element(by.id('field_address'));
    activityGroupsSelect = element(by.id('field_activityGroups'));
    attachedPersonsSelect = element(by.id('field_attachedPersons'));

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

    activityGroupsSelectLastOption(): promise.Promise<void> {
        return this.activityGroupsSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    activityGroupsSelectOption(option): promise.Promise<void> {
        return this.activityGroupsSelect.sendKeys(option);
    }

    getActivityGroupsSelect(): ElementFinder {
        return this.activityGroupsSelect;
    }

    getActivityGroupsSelectedOption() {
        return this.activityGroupsSelect.element(by.css('option:checked')).getText();
    }

    attachedPersonsSelectLastOption(): promise.Promise<void> {
        return this.attachedPersonsSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    attachedPersonsSelectOption(option): promise.Promise<void> {
        return this.attachedPersonsSelect.sendKeys(option);
    }

    getAttachedPersonsSelect(): ElementFinder {
        return this.attachedPersonsSelect;
    }

    getAttachedPersonsSelectedOption() {
        return this.attachedPersonsSelect.element(by.css('option:checked')).getText();
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
