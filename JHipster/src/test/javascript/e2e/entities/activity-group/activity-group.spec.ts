import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityGroupComponentsPage, ActivityGroupUpdatePage } from './activity-group.page-object';

describe('ActivityGroup e2e test', () => {
    let navBarPage: NavBarPage;
    let activityGroupUpdatePage: ActivityGroupUpdatePage;
    let activityGroupComponentsPage: ActivityGroupComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityGroups', () => {
        navBarPage.goToEntity('activity-group');
        activityGroupComponentsPage = new ActivityGroupComponentsPage();
        expect(activityGroupComponentsPage.getTitle()).toMatch(/jtTestingApp.activityGroup.home.title/);
    });

    it('should load create ActivityGroup page', () => {
        activityGroupComponentsPage.clickOnCreateButton();
        activityGroupUpdatePage = new ActivityGroupUpdatePage();
        expect(activityGroupUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activityGroup.home.createOrEditLabel/);
        activityGroupUpdatePage.cancel();
    });

    it('should create and save ActivityGroups', () => {
        activityGroupComponentsPage.clickOnCreateButton();
        activityGroupUpdatePage.setNameInput('name');
        expect(activityGroupUpdatePage.getNameInput()).toMatch('name');
        activityGroupUpdatePage.setDescriptionInput('description');
        expect(activityGroupUpdatePage.getDescriptionInput()).toMatch('description');
        activityGroupUpdatePage.setMinAgeInput('5');
        expect(activityGroupUpdatePage.getMinAgeInput()).toMatch('5');
        activityGroupUpdatePage.setMaxAgeInput('5');
        expect(activityGroupUpdatePage.getMaxAgeInput()).toMatch('5');
        // activityGroupUpdatePage.activitiesSelectLastOption();
        // activityGroupUpdatePage.activityGroupCategoriesSelectLastOption();
        activityGroupUpdatePage.save();
        expect(activityGroupUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
