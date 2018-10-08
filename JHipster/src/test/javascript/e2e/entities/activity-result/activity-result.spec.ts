/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { ActivityResultComponentsPage, ActivityResultDeleteDialog, ActivityResultUpdatePage } from './activity-result.page-object';

const expect = chai.expect;

describe('ActivityResult e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let activityResultUpdatePage: ActivityResultUpdatePage;
    let activityResultComponentsPage: ActivityResultComponentsPage;
    /*let activityResultDeleteDialog: ActivityResultDeleteDialog;*/

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load ActivityResults', async () => {
        await navBarPage.goToEntity('activity-result');
        activityResultComponentsPage = new ActivityResultComponentsPage();
        expect(await activityResultComponentsPage.getTitle()).to.eq('jtTestingApp.activityResult.home.title');
    });

    it('should load create ActivityResult page', async () => {
        await activityResultComponentsPage.clickOnCreateButton();
        activityResultUpdatePage = new ActivityResultUpdatePage();
        expect(await activityResultUpdatePage.getPageTitle()).to.eq('jtTestingApp.activityResult.home.createOrEditLabel');
        await activityResultUpdatePage.cancel();
    });

    /* it('should create and save ActivityResults', async () => {
        const nbButtonsBeforeCreate = await activityResultComponentsPage.countDeleteButtons();

        await activityResultComponentsPage.clickOnCreateButton();
        await activityResultUpdatePage.setPrimaryResultValueInput('5');
        expect(await activityResultUpdatePage.getPrimaryResultValueInput()).to.eq('5');
        await activityResultUpdatePage.setSecondaryResultValueInput('5');
        expect(await activityResultUpdatePage.getSecondaryResultValueInput()).to.eq('5');
        await activityResultUpdatePage.setNoteInput('note');
        expect(await activityResultUpdatePage.getNoteInput()).to.eq('note');
        await activityResultUpdatePage.testResultSelectLastOption();
        await activityResultUpdatePage.activitySelectLastOption();
        await activityResultUpdatePage.save();
        expect(await activityResultUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await activityResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });*/

    /* it('should delete last ActivityResult', async () => {
        const nbButtonsBeforeDelete = await activityResultComponentsPage.countDeleteButtons();
        await activityResultComponentsPage.clickOnLastDeleteButton();

        activityResultDeleteDialog = new ActivityResultDeleteDialog();
        expect(await activityResultDeleteDialog.getDialogTitle())
            .to.eq('jtTestingApp.activityResult.delete.question');
        await activityResultDeleteDialog.clickOnConfirmButton();

        expect(await activityResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });*/

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
