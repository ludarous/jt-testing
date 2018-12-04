import { element, by, promise, ElementFinder } from 'protractor';

export class ActivityCategoryComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-activity-category div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class ActivityCategoryUpdatePage {
    pageTitle = element(by.id('jhi-activity-category-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    nameInput = element(by.id('field_name'));
    keyInput = element(by.id('field_key'));
    descriptionInput = element(by.id('field_description'));
    parentSelect = element(by.id('field_parent'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setNameInput(name): promise.Promise<void> {
        return this.nameInput.sendKeys(name);
    }

    getNameInput() {
        return this.nameInput.getAttribute('value');
    }

    setKeyInput(key): promise.Promise<void> {
        return this.keyInput.sendKeys(key);
    }

    getKeyInput() {
        return this.keyInput.getAttribute('value');
    }

    setDescriptionInput(description): promise.Promise<void> {
        return this.descriptionInput.sendKeys(description);
    }

    getDescriptionInput() {
        return this.descriptionInput.getAttribute('value');
    }

    parentSelectLastOption(): promise.Promise<void> {
        return this.parentSelect
            .all(by.tagName('option'))
            .last()
            .click();
    }

    parentSelectOption(option): promise.Promise<void> {
        return this.parentSelect.sendKeys(option);
    }

    getParentSelect(): ElementFinder {
        return this.parentSelect;
    }

    getParentSelectedOption() {
        return this.parentSelect.element(by.css('option:checked')).getText();
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
