import { browser, protractor } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { PersonalDataComponentsPage, PersonalDataUpdatePage } from './personal-data.page-object';

describe('PersonalData e2e test', () => {
    let navBarPage: NavBarPage;
    let personalDataUpdatePage: PersonalDataUpdatePage;
    let personalDataComponentsPage: PersonalDataComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load PersonalData', () => {
        navBarPage.goToEntity('personal-data');
        personalDataComponentsPage = new PersonalDataComponentsPage();
        expect(personalDataComponentsPage.getTitle()).toMatch(/jtTestingApp.personalData.home.title/);
    });

    it('should load create PersonalData page', () => {
        personalDataComponentsPage.clickOnCreateButton();
        personalDataUpdatePage = new PersonalDataUpdatePage();
        expect(personalDataUpdatePage.getPageTitle()).toMatch(/jtTestingApp.personalData.home.createOrEditLabel/);
        personalDataUpdatePage.cancel();
    });

    it('should create and save PersonalData', () => {
        personalDataComponentsPage.clickOnCreateButton();
        personalDataUpdatePage.setFirstNameInput('firstName');
        expect(personalDataUpdatePage.getFirstNameInput()).toMatch('firstName');
        personalDataUpdatePage.setLastNameInput('lastName');
        expect(personalDataUpdatePage.getLastNameInput()).toMatch('lastName');
        personalDataUpdatePage.setBirthDateInput('01/01/2001' + protractor.Key.TAB + '02:30AM');
        expect(personalDataUpdatePage.getBirthDateInput()).toContain('2001-01-01T02:30');
        personalDataUpdatePage.setNationalityInput('nationality');
        expect(personalDataUpdatePage.getNationalityInput()).toMatch('nationality');
        personalDataUpdatePage.sexSelectLastOption();
        personalDataUpdatePage.save();
        expect(personalDataUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
