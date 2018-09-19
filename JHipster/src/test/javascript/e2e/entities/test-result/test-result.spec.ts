import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { TestResultComponentsPage, TestResultUpdatePage } from './test-result.page-object';

describe('TestResult e2e test', () => {
    let navBarPage: NavBarPage;
    let testResultUpdatePage: TestResultUpdatePage;
    let testResultComponentsPage: TestResultComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load TestResults', () => {
        navBarPage.goToEntity('test-result');
        testResultComponentsPage = new TestResultComponentsPage();
        expect(testResultComponentsPage.getTitle()).toMatch(/jtTestingApp.testResult.home.title/);
    });

    it('should load create TestResult page', () => {
        testResultComponentsPage.clickOnCreateButton();
        testResultUpdatePage = new TestResultUpdatePage();
        expect(testResultUpdatePage.getPageTitle()).toMatch(/jtTestingApp.testResult.home.createOrEditLabel/);
        testResultUpdatePage.cancel();
    });

    /* it('should create and save TestResults', () => {
        testResultComponentsPage.clickOnCreateButton();
        testResultUpdatePage.setNoteInput('note');
        expect(testResultUpdatePage.getNoteInput()).toMatch('note');
        testResultUpdatePage.eventResultSelectLastOption();
        testResultUpdatePage.testSelectLastOption();
        testResultUpdatePage.save();
        expect(testResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
