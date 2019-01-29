import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityGroupResultComponentsPage, ActivityGroupResultUpdatePage } from './activity-group-result.page-object';

describe('ActivityGroupResult e2e test', () => {
    let navBarPage: NavBarPage;
    let activityGroupResultUpdatePage: ActivityGroupResultUpdatePage;
    let activityGroupResultComponentsPage: ActivityGroupResultComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityGroupResults', () => {
        navBarPage.goToEntity('activity-group-result');
        activityGroupResultComponentsPage = new ActivityGroupResultComponentsPage();
        expect(activityGroupResultComponentsPage.getTitle()).toMatch(/jtTestingApp.activityGroupResult.home.title/);
    });

    it('should load create ActivityGroupResult page', () => {
        activityGroupResultComponentsPage.clickOnCreateButton();
        activityGroupResultUpdatePage = new ActivityGroupResultUpdatePage();
        expect(activityGroupResultUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activityGroupResult.home.createOrEditLabel/);
        activityGroupResultUpdatePage.cancel();
    });

    /* it('should create and save ActivityGroupResults', () => {
        activityGroupResultComponentsPage.clickOnCreateButton();
        activityGroupResultUpdatePage.setNoteInput('note');
        expect(activityGroupResultUpdatePage.getNoteInput()).toMatch('note');
        activityGroupResultUpdatePage.eventResultSelectLastOption();
        activityGroupResultUpdatePage.activityGroupSelectLastOption();
        activityGroupResultUpdatePage.save();
        expect(activityGroupResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
