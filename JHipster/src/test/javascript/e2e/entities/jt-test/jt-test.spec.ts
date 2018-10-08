/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { JTTestComponentsPage, JTTestDeleteDialog, JTTestUpdatePage } from './jt-test.page-object';

const expect = chai.expect;

describe('JTTest e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let jTTestUpdatePage: JTTestUpdatePage;
    let jTTestComponentsPage: JTTestComponentsPage;
    let jTTestDeleteDialog: JTTestDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load JTTests', async () => {
        await navBarPage.goToEntity('jt-test');
        jTTestComponentsPage = new JTTestComponentsPage();
        expect(await jTTestComponentsPage.getTitle()).to.eq('jtTestingApp.jTTest.home.title');
    });

    it('should load create JTTest page', async () => {
        await jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage = new JTTestUpdatePage();
        expect(await jTTestUpdatePage.getPageTitle()).to.eq('jtTestingApp.jTTest.home.createOrEditLabel');
        await jTTestUpdatePage.cancel();
    });

    it('should create and save JTTests', async () => {
        const nbButtonsBeforeCreate = await jTTestComponentsPage.countDeleteButtons();

        await jTTestComponentsPage.clickOnCreateButton();
        await jTTestUpdatePage.setNameInput('name');
        expect(await jTTestUpdatePage.getNameInput()).to.eq('name');
        await jTTestUpdatePage.setDescriptionInput('description');
        expect(await jTTestUpdatePage.getDescriptionInput()).to.eq('description');
        // jTTestUpdatePage.activitiesSelectLastOption();
        // jTTestUpdatePage.categoriesSelectLastOption();
        // jTTestUpdatePage.sportsSelectLastOption();
        await jTTestUpdatePage.save();
        expect(await jTTestUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await jTTestComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last JTTest', async () => {
        const nbButtonsBeforeDelete = await jTTestComponentsPage.countDeleteButtons();
        await jTTestComponentsPage.clickOnLastDeleteButton();

        jTTestDeleteDialog = new JTTestDeleteDialog();
        expect(await jTTestDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.jTTest.delete.question');
        await jTTestDeleteDialog.clickOnConfirmButton();

        expect(await jTTestComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
