import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { ActivityResultComponentsPage, ActivityResultUpdatePage } from './activity-result.page-object';

describe('ActivityResult e2e test', () => {
    let navBarPage: NavBarPage;
    let activityResultUpdatePage: ActivityResultUpdatePage;
    let activityResultComponentsPage: ActivityResultComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load ActivityResults', () => {
        navBarPage.goToEntity('activity-result');
        activityResultComponentsPage = new ActivityResultComponentsPage();
        expect(activityResultComponentsPage.getTitle()).toMatch(/jtTestingApp.activityResult.home.title/);
    });

    it('should load create ActivityResult page', () => {
        activityResultComponentsPage.clickOnCreateButton();
        activityResultUpdatePage = new ActivityResultUpdatePage();
        expect(activityResultUpdatePage.getPageTitle()).toMatch(/jtTestingApp.activityResult.home.createOrEditLabel/);
        activityResultUpdatePage.cancel();
    });

    /* it('should create and save ActivityResults', () => {
        activityResultComponentsPage.clickOnCreateButton();
        activityResultUpdatePage.setPrimaryResultValueInput('5');
        expect(activityResultUpdatePage.getPrimaryResultValueInput()).toMatch('5');
        activityResultUpdatePage.setSecondaryResultValueInput('5');
        expect(activityResultUpdatePage.getSecondaryResultValueInput()).toMatch('5');
        activityResultUpdatePage.setNoteInput('note');
        expect(activityResultUpdatePage.getNoteInput()).toMatch('note');
        activityResultUpdatePage.testResultSelectLastOption();
        activityResultUpdatePage.activitySelectLastOption();
        activityResultUpdatePage.save();
        expect(activityResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
