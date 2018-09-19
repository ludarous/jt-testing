import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { AddressComponentsPage, AddressUpdatePage } from './address.page-object';

describe('Address e2e test', () => {
    let navBarPage: NavBarPage;
    let addressUpdatePage: AddressUpdatePage;
    let addressComponentsPage: AddressComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Addresses', () => {
        navBarPage.goToEntity('address');
        addressComponentsPage = new AddressComponentsPage();
        expect(addressComponentsPage.getTitle()).toMatch(/jtTestingApp.address.home.title/);
    });

    it('should load create Address page', () => {
        addressComponentsPage.clickOnCreateButton();
        addressUpdatePage = new AddressUpdatePage();
        expect(addressUpdatePage.getPageTitle()).toMatch(/jtTestingApp.address.home.createOrEditLabel/);
        addressUpdatePage.cancel();
    });

    it('should create and save Addresses', () => {
        addressComponentsPage.clickOnCreateButton();
        addressUpdatePage.setCountryInput('country');
        expect(addressUpdatePage.getCountryInput()).toMatch('country');
        addressUpdatePage.setCityInput('city');
        expect(addressUpdatePage.getCityInput()).toMatch('city');
        addressUpdatePage.setStreetInput('street');
        expect(addressUpdatePage.getStreetInput()).toMatch('street');
        addressUpdatePage.setZipCodeInput('zipCode');
        expect(addressUpdatePage.getZipCodeInput()).toMatch('zipCode');
        addressUpdatePage.save();
        expect(addressUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
