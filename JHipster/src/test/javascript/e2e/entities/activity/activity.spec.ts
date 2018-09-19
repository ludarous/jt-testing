import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityComponentsPage, ActivityUpdatePage } from './activity.page-object';

describe('Activity e2e test', () => {
    let navBarPage: NavBarPage;
    let activityUpdatePage: ActivityUpdatePage;
    let activityComponentsPage: ActivityComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Activities', () => {
        navBarPage.goToEntity('activity');
        activityComponentsPage = new ActivityComponentsPage();
        expect(activityComponentsPage.getTitle()).toMatch(/jtTestingApp.activity.home.title/);
    });

    it('should load create Activity page', () => {
        activityComponentsPage.clickOnCreateButton();
        activityUpdatePage = new ActivityUpdatePage();
        expect(activityUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activity.home.createOrEditLabel/);
        activityUpdatePage.cancel();
    });

    it('should create and save Activities', () => {
        activityComponentsPage.clickOnCreateButton();
        activityUpdatePage.setNameInput('name');
        expect(activityUpdatePage.getNameInput()).toMatch('name');
        activityUpdatePage.setDescriptionInput('description');
        expect(activityUpdatePage.getDescriptionInput()).toMatch('description');
        activityUpdatePage.setHelpInput('help');
        expect(activityUpdatePage.getHelpInput()).toMatch('help');
        activityUpdatePage.setKeyInput('key');
        expect(activityUpdatePage.getKeyInput()).toMatch('key');
        activityUpdatePage.primaryResultValueUnitSelectLastOption();
        activityUpdatePage.secondaryResultValueUnitSelectLastOption();
        activityUpdatePage.setMinAgeInput('5');
        expect(activityUpdatePage.getMinAgeInput()).toMatch('5');
        activityUpdatePage.setMaxAgeInput('5');
        expect(activityUpdatePage.getMaxAgeInput()).toMatch('5');
        // activityUpdatePage.categoriesSelectLastOption();
        activityUpdatePage.save();
        expect(activityUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
