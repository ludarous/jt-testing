import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityGroupComponentsPage, ActivityGroupUpdatePage } from './jt-test.page-object';

describe('ActivityGroup e2e test', () => {
    let navBarPage: NavBarPage;
    let jTTestUpdatePage: ActivityGroupUpdatePage;
    let jTTestComponentsPage: ActivityGroupComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityGroups', () => {
        navBarPage.goToEntity('jt-test');
        jTTestComponentsPage = new ActivityGroupComponentsPage();
        expect(jTTestComponentsPage.getTitle()).toMatch(/jtTestingApp.jTTest.home.title/);
    });

    it('should load create ActivityGroup page', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage = new ActivityGroupUpdatePage();
        expect(jTTestUpdatePage.getPageTitle()).toMatch(/jtTestingApp.jTTest.home.createOrEditLabel/);
        jTTestUpdatePage.cancel();
    });

    it('should create and save ActivityGroups', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage.setNameInput('name');
        expect(jTTestUpdatePage.getNameInput()).toMatch('name');
        jTTestUpdatePage.setDescriptionInput('description');
        expect(jTTestUpdatePage.getDescriptionInput()).toMatch('description');
        jTTestUpdatePage.setMinAgeInput('5');
        expect(jTTestUpdatePage.getMinAgeInput()).toMatch('5');
        jTTestUpdatePage.setMaxAgeInput('5');
        expect(jTTestUpdatePage.getMaxAgeInput()).toMatch('5');
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
