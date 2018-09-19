import { element, by, promise, ElementFinder } from 'protractor';

export class AddressComponentsPage {
    createButton = element(by.id('jh-create-entity'));
    title = element.all(by.css('jhi-address div h2#page-heading span')).first();

    clickOnCreateButton(): promise.Promise<void> {
        return this.createButton.click();
    }

    getTitle(): any {
        return this.title.getAttribute('jhiTranslate');
    }
}

export class AddressUpdatePage {
    pageTitle = element(by.id('jhi-address-heading'));
    saveButton = element(by.id('save-entity'));
    cancelButton = element(by.id('cancel-save'));
    countryInput = element(by.id('field_country'));
    cityInput = element(by.id('field_city'));
    streetInput = element(by.id('field_street'));
    zipCodeInput = element(by.id('field_zipCode'));

    getPageTitle() {
        return this.pageTitle.getAttribute('jhiTranslate');
    }

    setCountryInput(country): promise.Promise<void> {
        return this.countryInput.sendKeys(country);
    }

    getCountryInput() {
        return this.countryInput.getAttribute('value');
    }

    setCityInput(city): promise.Promise<void> {
        return this.cityInput.sendKeys(city);
    }

    getCityInput() {
        return this.cityInput.getAttribute('value');
    }

    setStreetInput(street): promise.Promise<void> {
        return this.streetInput.sendKeys(street);
    }

    getStreetInput() {
        return this.streetInput.getAttribute('value');
    }

    setZipCodeInput(zipCode): promise.Promise<void> {
        return this.zipCodeInput.sendKeys(zipCode);
    }

    getZipCodeInput() {
        return this.zipCodeInput.getAttribute('value');
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
