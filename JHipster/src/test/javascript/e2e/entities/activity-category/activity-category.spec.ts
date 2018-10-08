/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { ActivityCategoryComponentsPage, ActivityCategoryDeleteDialog, ActivityCategoryUpdatePage } from './activity-category.page-object';

const expect = chai.expect;

describe('ActivityCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let activityCategoryUpdatePage: ActivityCategoryUpdatePage;
    let activityCategoryComponentsPage: ActivityCategoryComponentsPage;
    let activityCategoryDeleteDialog: ActivityCategoryDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load ActivityCategories', async () => {
        await navBarPage.goToEntity('activity-category');
        activityCategoryComponentsPage = new ActivityCategoryComponentsPage();
        expect(await activityCategoryComponentsPage.getTitle()).to.eq('jtTestingApp.activityCategory.home.title');
    });

    it('should load create ActivityCategory page', async () => {
        await activityCategoryComponentsPage.clickOnCreateButton();
        activityCategoryUpdatePage = new ActivityCategoryUpdatePage();
        expect(await activityCategoryUpdatePage.getPageTitle()).to.eq('jtTestingApp.activityCategory.home.createOrEditLabel');
        await activityCategoryUpdatePage.cancel();
    });

    it('should create and save ActivityCategories', async () => {
        const nbButtonsBeforeCreate = await activityCategoryComponentsPage.countDeleteButtons();

        await activityCategoryComponentsPage.clickOnCreateButton();
        await activityCategoryUpdatePage.setNameInput('name');
        expect(await activityCategoryUpdatePage.getNameInput()).to.eq('name');
        await activityCategoryUpdatePage.setKeyInput('key');
        expect(await activityCategoryUpdatePage.getKeyInput()).to.eq('key');
        await activityCategoryUpdatePage.setDescriptionInput('description');
        expect(await activityCategoryUpdatePage.getDescriptionInput()).to.eq('description');
        await activityCategoryUpdatePage.save();
        expect(await activityCategoryUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await activityCategoryComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last ActivityCategory', async () => {
        const nbButtonsBeforeDelete = await activityCategoryComponentsPage.countDeleteButtons();
        await activityCategoryComponentsPage.clickOnLastDeleteButton();

        activityCategoryDeleteDialog = new ActivityCategoryDeleteDialog();
        expect(await activityCategoryDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.activityCategory.delete.question');
        await activityCategoryDeleteDialog.clickOnConfirmButton();

        expect(await activityCategoryComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
