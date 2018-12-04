import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityCategoryComponentsPage, ActivityCategoryUpdatePage } from './activity-category.page-object';

describe('ActivityCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let activityCategoryUpdatePage: ActivityCategoryUpdatePage;
    let activityCategoryComponentsPage: ActivityCategoryComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityCategories', () => {
        navBarPage.goToEntity('activity-category');
        activityCategoryComponentsPage = new ActivityCategoryComponentsPage();
        expect(activityCategoryComponentsPage.getTitle()).toMatch(/jtTestingApp.activityCategory.home.title/);
    });

    it('should load create ActivityCategory page', () => {
        activityCategoryComponentsPage.clickOnCreateButton();
        activityCategoryUpdatePage = new ActivityCategoryUpdatePage();
        expect(activityCategoryUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activityCategory.home.createOrEditLabel/);
        activityCategoryUpdatePage.cancel();
    });

    it('should create and save ActivityCategories', () => {
        activityCategoryComponentsPage.clickOnCreateButton();
        activityCategoryUpdatePage.setNameInput('name');
        expect(activityCategoryUpdatePage.getNameInput()).toMatch('name');
        activityCategoryUpdatePage.setKeyInput('key');
        expect(activityCategoryUpdatePage.getKeyInput()).toMatch('key');
        activityCategoryUpdatePage.setDescriptionInput('description');
        expect(activityCategoryUpdatePage.getDescriptionInput()).toMatch('description');
        activityCategoryUpdatePage.parentSelectLastOption();
        activityCategoryUpdatePage.save();
        expect(activityCategoryUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
