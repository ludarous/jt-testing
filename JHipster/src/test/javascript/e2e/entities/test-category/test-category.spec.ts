/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { TestCategoryComponentsPage, TestCategoryDeleteDialog, TestCategoryUpdatePage } from './test-category.page-object';

const expect = chai.expect;

describe('TestCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let testCategoryUpdatePage: TestCategoryUpdatePage;
    let testCategoryComponentsPage: TestCategoryComponentsPage;
    let testCategoryDeleteDialog: TestCategoryDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load TestCategories', async () => {
        await navBarPage.goToEntity('test-category');
        testCategoryComponentsPage = new TestCategoryComponentsPage();
        expect(await testCategoryComponentsPage.getTitle()).to.eq('jtTestingApp.testCategory.home.title');
    });

    it('should load create TestCategory page', async () => {
        await testCategoryComponentsPage.clickOnCreateButton();
        testCategoryUpdatePage = new TestCategoryUpdatePage();
        expect(await testCategoryUpdatePage.getPageTitle()).to.eq('jtTestingApp.testCategory.home.createOrEditLabel');
        await testCategoryUpdatePage.cancel();
    });

    it('should create and save TestCategories', async () => {
        const nbButtonsBeforeCreate = await testCategoryComponentsPage.countDeleteButtons();

        await testCategoryComponentsPage.clickOnCreateButton();
        await testCategoryUpdatePage.setNameInput('name');
        expect(await testCategoryUpdatePage.getNameInput()).to.eq('name');
        await testCategoryUpdatePage.setKeyInput('key');
        expect(await testCategoryUpdatePage.getKeyInput()).to.eq('key');
        await testCategoryUpdatePage.setDescriptionInput('description');
        expect(await testCategoryUpdatePage.getDescriptionInput()).to.eq('description');
        await testCategoryUpdatePage.save();
        expect(await testCategoryUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await testCategoryComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last TestCategory', async () => {
        const nbButtonsBeforeDelete = await testCategoryComponentsPage.countDeleteButtons();
        await testCategoryComponentsPage.clickOnLastDeleteButton();

        testCategoryDeleteDialog = new TestCategoryDeleteDialog();
        expect(await testCategoryDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.testCategory.delete.question');
        await testCategoryDeleteDialog.clickOnConfirmButton();

        expect(await testCategoryComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
