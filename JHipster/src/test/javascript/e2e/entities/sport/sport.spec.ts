import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { SportComponentsPage, SportUpdatePage } from './sport.page-object';

describe('Sport e2e test', () => {
    let navBarPage: NavBarPage;
    let sportUpdatePage: SportUpdatePage;
    let sportComponentsPage: SportComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Sports', () => {
        navBarPage.goToEntity('sport');
        sportComponentsPage = new SportComponentsPage();
        expect(sportComponentsPage.getTitle()).toMatch(/jtTestingApp.sport.home.title/);
    });

    it('should load create Sport page', () => {
        sportComponentsPage.clickOnCreateButton();
        sportUpdatePage = new SportUpdatePage();
        expect(sportUpdatePage.getPageTitle()).toMatch(/jtTestingApp.sport.home.createOrEditLabel/);
        sportUpdatePage.cancel();
    });

    it('should create and save Sports', () => {
        sportComponentsPage.clickOnCreateButton();
        sportUpdatePage.setNameInput('name');
        expect(sportUpdatePage.getNameInput()).toMatch('name');
        sportUpdatePage.save();
        expect(sportUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
