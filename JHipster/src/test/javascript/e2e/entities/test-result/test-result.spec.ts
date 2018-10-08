/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { TestResultComponentsPage, TestResultDeleteDialog, TestResultUpdatePage } from './test-result.page-object';

const expect = chai.expect;

describe('TestResult e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let testResultUpdatePage: TestResultUpdatePage;
    let testResultComponentsPage: TestResultComponentsPage;
    /*let testResultDeleteDialog: TestResultDeleteDialog;*/

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load TestResults', async () => {
        await navBarPage.goToEntity('test-result');
        testResultComponentsPage = new TestResultComponentsPage();
        expect(await testResultComponentsPage.getTitle()).to.eq('jtTestingApp.testResult.home.title');
    });

    it('should load create TestResult page', async () => {
        await testResultComponentsPage.clickOnCreateButton();
        testResultUpdatePage = new TestResultUpdatePage();
        expect(await testResultUpdatePage.getPageTitle()).to.eq('jtTestingApp.testResult.home.createOrEditLabel');
        await testResultUpdatePage.cancel();
    });

    /* it('should create and save TestResults', async () => {
        const nbButtonsBeforeCreate = await testResultComponentsPage.countDeleteButtons();

        await testResultComponentsPage.clickOnCreateButton();
        await testResultUpdatePage.setNoteInput('note');
        expect(await testResultUpdatePage.getNoteInput()).to.eq('note');
        await testResultUpdatePage.eventResultSelectLastOption();
        await testResultUpdatePage.testSelectLastOption();
        await testResultUpdatePage.save();
        expect(await testResultUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await testResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });*/

    /* it('should delete last TestResult', async () => {
        const nbButtonsBeforeDelete = await testResultComponentsPage.countDeleteButtons();
        await testResultComponentsPage.clickOnLastDeleteButton();

        testResultDeleteDialog = new TestResultDeleteDialog();
        expect(await testResultDeleteDialog.getDialogTitle())
            .to.eq('jtTestingApp.testResult.delete.question');
        await testResultDeleteDialog.clickOnConfirmButton();

        expect(await testResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });*/

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
