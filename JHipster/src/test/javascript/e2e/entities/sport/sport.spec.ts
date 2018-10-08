/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { SportComponentsPage, SportDeleteDialog, SportUpdatePage } from './sport.page-object';

const expect = chai.expect;

describe('Sport e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let sportUpdatePage: SportUpdatePage;
    let sportComponentsPage: SportComponentsPage;
    let sportDeleteDialog: SportDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load Sports', async () => {
        await navBarPage.goToEntity('sport');
        sportComponentsPage = new SportComponentsPage();
        expect(await sportComponentsPage.getTitle()).to.eq('jtTestingApp.sport.home.title');
    });

    it('should load create Sport page', async () => {
        await sportComponentsPage.clickOnCreateButton();
        sportUpdatePage = new SportUpdatePage();
        expect(await sportUpdatePage.getPageTitle()).to.eq('jtTestingApp.sport.home.createOrEditLabel');
        await sportUpdatePage.cancel();
    });

    it('should create and save Sports', async () => {
        const nbButtonsBeforeCreate = await sportComponentsPage.countDeleteButtons();

        await sportComponentsPage.clickOnCreateButton();
        await sportUpdatePage.setNameInput('name');
        expect(await sportUpdatePage.getNameInput()).to.eq('name');
        await sportUpdatePage.save();
        expect(await sportUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await sportComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last Sport', async () => {
        const nbButtonsBeforeDelete = await sportComponentsPage.countDeleteButtons();
        await sportComponentsPage.clickOnLastDeleteButton();

        sportDeleteDialog = new SportDeleteDialog();
        expect(await sportDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.sport.delete.question');
        await sportDeleteDialog.clickOnConfirmButton();

        expect(await sportComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
