import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { EventResultComponentsPage, EventResultUpdatePage } from './event-result.page-object';

describe('EventResult e2e test', () => {
    let navBarPage: NavBarPage;
    let eventResultUpdatePage: EventResultUpdatePage;
    let eventResultComponentsPage: EventResultComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load EventResults', () => {
        navBarPage.goToEntity('event-result');
        eventResultComponentsPage = new EventResultComponentsPage();
        expect(eventResultComponentsPage.getTitle()).toMatch(/activityGroupingApp.eventResult.home.title/);
    });

    it('should load create EventResult page', () => {
        eventResultComponentsPage.clickOnCreateButton();
        eventResultUpdatePage = new EventResultUpdatePage();
        expect(eventResultUpdatePage.getPageTitle()).toMatch(/activityGroupingApp.eventResult.home.createOrEditLabel/);
        eventResultUpdatePage.cancel();
    });

    /* it('should create and save EventResults', () => {
        eventResultComponentsPage.clickOnCreateButton();
        eventResultUpdatePage.setNoteInput('note');
        expect(eventResultUpdatePage.getNoteInput()).toMatch('note');
        eventResultUpdatePage.setActualHeightInCmInput('5');
        expect(eventResultUpdatePage.getActualHeightInCmInput()).toMatch('5');
        eventResultUpdatePage.setActualWeightInKgInput('5');
        expect(eventResultUpdatePage.getActualWeightInKgInput()).toMatch('5');
        eventResultUpdatePage.eventSelectLastOption();
        eventResultUpdatePage.personSelectLastOption();
        eventResultUpdatePage.save();
        expect(eventResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
