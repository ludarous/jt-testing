/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { EventResultComponentsPage, EventResultDeleteDialog, EventResultUpdatePage } from './event-result.page-object';

const expect = chai.expect;

describe('EventResult e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let eventResultUpdatePage: EventResultUpdatePage;
    let eventResultComponentsPage: EventResultComponentsPage;
    /*let eventResultDeleteDialog: EventResultDeleteDialog;*/

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load EventResults', async () => {
        await navBarPage.goToEntity('event-result');
        eventResultComponentsPage = new EventResultComponentsPage();
        expect(await eventResultComponentsPage.getTitle()).to.eq('jtTestingApp.eventResult.home.title');
    });

    it('should load create EventResult page', async () => {
        await eventResultComponentsPage.clickOnCreateButton();
        eventResultUpdatePage = new EventResultUpdatePage();
        expect(await eventResultUpdatePage.getPageTitle()).to.eq('jtTestingApp.eventResult.home.createOrEditLabel');
        await eventResultUpdatePage.cancel();
    });

    /* it('should create and save EventResults', async () => {
        const nbButtonsBeforeCreate = await eventResultComponentsPage.countDeleteButtons();

        await eventResultComponentsPage.clickOnCreateButton();
        await eventResultUpdatePage.setNoteInput('note');
        expect(await eventResultUpdatePage.getNoteInput()).to.eq('note');
        await eventResultUpdatePage.setActualHeightInCmInput('5');
        expect(await eventResultUpdatePage.getActualHeightInCmInput()).to.eq('5');
        await eventResultUpdatePage.setActualWeightInKgInput('5');
        expect(await eventResultUpdatePage.getActualWeightInKgInput()).to.eq('5');
        await eventResultUpdatePage.eventSelectLastOption();
        await eventResultUpdatePage.personSelectLastOption();
        await eventResultUpdatePage.save();
        expect(await eventResultUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await eventResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });*/

    /* it('should delete last EventResult', async () => {
        const nbButtonsBeforeDelete = await eventResultComponentsPage.countDeleteButtons();
        await eventResultComponentsPage.clickOnLastDeleteButton();

        eventResultDeleteDialog = new EventResultDeleteDialog();
        expect(await eventResultDeleteDialog.getDialogTitle())
            .to.eq('jtTestingApp.eventResult.delete.question');
        await eventResultDeleteDialog.clickOnConfirmButton();

        expect(await eventResultComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });*/

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
