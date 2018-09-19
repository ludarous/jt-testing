import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { JTTestComponentsPage, JTTestUpdatePage } from './jt-test.page-object';

describe('JTTest e2e test', () => {
    let navBarPage: NavBarPage;
    let jTTestUpdatePage: JTTestUpdatePage;
    let jTTestComponentsPage: JTTestComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load JTTests', () => {
        navBarPage.goToEntity('jt-test');
        jTTestComponentsPage = new JTTestComponentsPage();
        expect(jTTestComponentsPage.getTitle()).toMatch(/jtTestingApp.jTTest.home.title/);
    });

    it('should load create JTTest page', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage = new JTTestUpdatePage();
        expect(jTTestUpdatePage.getPageTitle()).toMatch(/jtTestingApp.jTTest.home.createOrEditLabel/);
        jTTestUpdatePage.cancel();
    });

    it('should create and save JTTests', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage.setNameInput('name');
        expect(jTTestUpdatePage.getNameInput()).toMatch('name');
        jTTestUpdatePage.setDescriptionInput('description');
        expect(jTTestUpdatePage.getDescriptionInput()).toMatch('description');
        // jTTestUpdatePage.activitiesSelectLastOption();
        // jTTestUpdatePage.categoriesSelectLastOption();
        // jTTestUpdatePage.sportsSelectLastOption();
        jTTestUpdatePage.save();
        expect(jTTestUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
