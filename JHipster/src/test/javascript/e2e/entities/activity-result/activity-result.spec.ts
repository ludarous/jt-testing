import { browser, protractor } from 'protractor';
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
        activityResultUpdatePage.setEventDateInput('01/01/2001' + protractor.Key.TAB + '02:30AM');
        expect(activityResultUpdatePage.getEventDateInput()).toContain('2001-01-01T02:30');
        activityResultUpdatePage.setPersonBirthDateInput('01/01/2001' + protractor.Key.TAB + '02:30AM');
        expect(activityResultUpdatePage.getPersonBirthDateInput()).toContain('2001-01-01T02:30');
        activityResultUpdatePage.testResultSelectLastOption();
        activityResultUpdatePage.activitySelectLastOption();
        activityResultUpdatePage.testSelectLastOption();
        activityResultUpdatePage.eventSelectLastOption();
        activityResultUpdatePage.personSelectLastOption();
        activityResultUpdatePage.save();
        expect(activityResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
