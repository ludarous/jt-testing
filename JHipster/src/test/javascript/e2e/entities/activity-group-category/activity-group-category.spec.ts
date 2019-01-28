import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityGroupCategoryComponentsPage, ActivityGroupCategoryUpdatePage } from './activity-group-category.page-object';

describe('ActivityGroupCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let activityGroupCategoryUpdatePage: ActivityGroupCategoryUpdatePage;
    let activityGroupCategoryComponentsPage: ActivityGroupCategoryComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityGroupCategories', () => {
        navBarPage.goToEntity('activity-group-category');
        activityGroupCategoryComponentsPage = new ActivityGroupCategoryComponentsPage();
        expect(activityGroupCategoryComponentsPage.getTitle()).toMatch(/jtTestingApp.activityGroupCategory.home.title/);
    });

    it('should load create ActivityGroupCategory page', () => {
        activityGroupCategoryComponentsPage.clickOnCreateButton();
        activityGroupCategoryUpdatePage = new ActivityGroupCategoryUpdatePage();
        expect(activityGroupCategoryUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activityGroupCategory.home.createOrEditLabel/);
        activityGroupCategoryUpdatePage.cancel();
    });

    it('should create and save ActivityGroupCategories', () => {
        activityGroupCategoryComponentsPage.clickOnCreateButton();
        activityGroupCategoryUpdatePage.setNameInput('name');
        expect(activityGroupCategoryUpdatePage.getNameInput()).toMatch('name');
        activityGroupCategoryUpdatePage.setKeyInput('key');
        expect(activityGroupCategoryUpdatePage.getKeyInput()).toMatch('key');
        activityGroupCategoryUpdatePage.setDescriptionInput('description');
        expect(activityGroupCategoryUpdatePage.getDescriptionInput()).toMatch('description');
        activityGroupCategoryUpdatePage.save();
        expect(activityGroupCategoryUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
