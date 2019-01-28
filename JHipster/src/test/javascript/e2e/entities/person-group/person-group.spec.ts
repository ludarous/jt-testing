import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { PersonGroupComponentsPage, PersonGroupUpdatePage } from './person-group.page-object';

describe('PersonGroup e2e test', () => {
    let navBarPage: NavBarPage;
    let personGroupUpdatePage: PersonGroupUpdatePage;
    let personGroupComponentsPage: PersonGroupComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load PersonGroups', () => {
        navBarPage.goToEntity('person-group');
        personGroupComponentsPage = new PersonGroupComponentsPage();
        expect(personGroupComponentsPage.getTitle()).toMatch(/jtTestingApp.personGroup.home.title/);
    });

    it('should load create PersonGroup page', () => {
        personGroupComponentsPage.clickOnCreateButton();
        personGroupUpdatePage = new PersonGroupUpdatePage();
        expect(personGroupUpdatePage.getPageTitle()).toMatch(/jtTestingApp.personGroup.home.createOrEditLabel/);
        personGroupUpdatePage.cancel();
    });

    /* it('should create and save PersonGroups', () => {
        personGroupComponentsPage.clickOnCreateButton();
        personGroupUpdatePage.groupRoleSelectLastOption();
        personGroupUpdatePage.personSelectLastOption();
        personGroupUpdatePage.groupSelectLastOption();
        personGroupUpdatePage.save();
        expect(personGroupUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
