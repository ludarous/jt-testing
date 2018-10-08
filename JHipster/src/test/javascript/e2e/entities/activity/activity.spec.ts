/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { ActivityComponentsPage, ActivityDeleteDialog, ActivityUpdatePage } from './activity.page-object';

const expect = chai.expect;

describe('Activity e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let activityUpdatePage: ActivityUpdatePage;
    let activityComponentsPage: ActivityComponentsPage;
    let activityDeleteDialog: ActivityDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load Activities', async () => {
        await navBarPage.goToEntity('activity');
        activityComponentsPage = new ActivityComponentsPage();
        expect(await activityComponentsPage.getTitle()).to.eq('jtTestingApp.activity.home.title');
    });

    it('should load create Activity page', async () => {
        await activityComponentsPage.clickOnCreateButton();
        activityUpdatePage = new ActivityUpdatePage();
        expect(await activityUpdatePage.getPageTitle()).to.eq('jtTestingApp.activity.home.createOrEditLabel');
        await activityUpdatePage.cancel();
    });

    it('should create and save Activities', async () => {
        const nbButtonsBeforeCreate = await activityComponentsPage.countDeleteButtons();

        await activityComponentsPage.clickOnCreateButton();
        await activityUpdatePage.setNameInput('name');
        expect(await activityUpdatePage.getNameInput()).to.eq('name');
        await activityUpdatePage.setDescriptionInput('description');
        expect(await activityUpdatePage.getDescriptionInput()).to.eq('description');
        await activityUpdatePage.setHelpInput('help');
        expect(await activityUpdatePage.getHelpInput()).to.eq('help');
        await activityUpdatePage.setKeyInput('key');
        expect(await activityUpdatePage.getKeyInput()).to.eq('key');
        await activityUpdatePage.primaryResultValueUnitSelectLastOption();
        await activityUpdatePage.secondaryResultValueUnitSelectLastOption();
        await activityUpdatePage.setMinAgeInput('5');
        expect(await activityUpdatePage.getMinAgeInput()).to.eq('5');
        await activityUpdatePage.setMaxAgeInput('5');
        expect(await activityUpdatePage.getMaxAgeInput()).to.eq('5');
        // activityUpdatePage.categoriesSelectLastOption();
        await activityUpdatePage.save();
        expect(await activityUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await activityComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last Activity', async () => {
        const nbButtonsBeforeDelete = await activityComponentsPage.countDeleteButtons();
        await activityComponentsPage.clickOnLastDeleteButton();

        activityDeleteDialog = new ActivityDeleteDialog();
        expect(await activityDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.activity.delete.question');
        await activityDeleteDialog.clickOnConfirmButton();

        expect(await activityComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
