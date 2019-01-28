import { element, by, promise, ElementFinder } from 'protractor';

export class PersonGroupComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-person-group div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class PersonGroupUpdatePage {
    pageTitle = element(by.id('jhi-person-group-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    groupRoleSelect = element(by.id('field_groupRole'));
    personSelect = element(by.id('field_person'));
    groupSelect = element(by.id('field_group'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setGroupRoleSelect(groupRole): promise.Promise<void> {
        return this.groupRoleSelect.sendKeys(groupRole);
    }

    getGroupRoleSelect() {
        return this.groupRoleSelect.element(by.css('option:checked')).getText();
    }

    groupRoleSelectLastOption(): promise.Promise<void> {
        return this.groupRoleSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }
    personSelectLastOption(): promise.Promise<void> {
        return this.personSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    personSelectOption(option): promise.Promise<void> {
        return this.personSelect.sendKeys(option);
    }

    getPersonSelect(): ElementFinder {
        return this.personSelect;
    }

    getPersonSelectedOption() {
        return this.personSelect.element(by.css('option:checked')).getText();
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
