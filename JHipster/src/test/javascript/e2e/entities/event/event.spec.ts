import { browser, protractor } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { EventComponentsPage, EventUpdatePage } from './event.page-object';

describe('Event e2e test', () => {
    let navBarPage: NavBarPage;
    let eventUpdatePage: EventUpdatePage;
    let eventComponentsPage: EventComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Events', () => {
        navBarPage.goToEntity('event');
        eventComponentsPage = new EventComponentsPage();
        expect(eventComponentsPage.getTitle()).toMatch(/jtTestingApp.event.home.title/);
    });

    it('should load create Event page', () => {
        eventComponentsPage.clickOnCreateButton();
        eventUpdatePage = new EventUpdatePage();
        expect(eventUpdatePage.getPageTitle()).toMatch(/jtTestingApp.event.home.createOrEditLabel/);
        eventUpdatePage.cancel();
    });

    it('should create and save Events', () => {
        eventComponentsPage.clickOnCreateButton();
        eventUpdatePage.setNameInput('name');
        expect(eventUpdatePage.getNameInput()).toMatch('name');
        eventUpdatePage.setDateInput('01/01/2001' + protractor.Key.TAB + '02:30AM');
        expect(eventUpdatePage.getDateInput()).toContain('2001-01-01T02:30');
        eventUpdatePage.setMinAgeInput('5');
        expect(eventUpdatePage.getMinAgeInput()).toMatch('5');
        eventUpdatePage.setMaxAgeInput('5');
        expect(eventUpdatePage.getMaxAgeInput()).toMatch('5');
        eventUpdatePage.addressSelectLastOption();
        // eventUpdatePage.workoutsSelectLastOption();
        // eventUpdatePage.attachedPersonsSelectLastOption();
        eventUpdatePage.save();
        expect(eventUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
