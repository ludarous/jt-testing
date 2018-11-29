import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { PersonComponentsPage, PersonUpdatePage } from './person.page-object';

describe('Person e2e test', () => {
    let navBarPage: NavBarPage;
    let personUpdatePage: PersonUpdatePage;
    let personComponentsPage: PersonComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load People', () => {
        navBarPage.goToEntity('person');
        personComponentsPage = new PersonComponentsPage();
        expect(personComponentsPage.getTitle()).toMatch(/jtTestingApp.person.home.title/);
    });

    it('should load create Person page', () => {
        personComponentsPage.clickOnCreateButton();
        personUpdatePage = new PersonUpdatePage();
        expect(personUpdatePage.getPageTitle()).toMatch(/jtTestingApp.person.home.createOrEditLabel/);
        personUpdatePage.cancel();
    });

    it('should create and save People', () => {
        personComponentsPage.clickOnCreateButton();
        personUpdatePage.setEmailInput('email');
        expect(personUpdatePage.getEmailInput()).toMatch('email');
        personUpdatePage
            .getVirtualInput()
            .isSelected()
            .then(selected => {
                if (selected) {
                    personUpdatePage.getVirtualInput().click();
                    expect(personUpdatePage.getVirtualInput().isSelected()).toBeFalsy();
                } else {
                    personUpdatePage.getVirtualInput().click();
                    expect(personUpdatePage.getVirtualInput().isSelected()).toBeTruthy();
                }
            });
        personUpdatePage.personalDataSelectLastOption();
        personUpdatePage.addressSelectLastOption();
        personUpdatePage.save();
        expect(personUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
