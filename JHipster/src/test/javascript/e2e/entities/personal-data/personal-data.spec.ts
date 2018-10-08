/* tslint:disable no-unused-expression */
import { browser, ExpectedConditions as ec, protractor } from 'protractor';
import { NavBarPage, SignInPage } from '../../page-objects/jhi-page-objects';

import { PersonalDataComponentsPage, PersonalDataDeleteDialog, PersonalDataUpdatePage } from './personal-data.page-object';

const expect = chai.expect;

describe('PersonalData e2e test', () => {
    let navBarPage: NavBarPage;
    let signInPage: SignInPage;
    let personalDataUpdatePage: PersonalDataUpdatePage;
    let personalDataComponentsPage: PersonalDataComponentsPage;
    let personalDataDeleteDialog: PersonalDataDeleteDialog;

    before(async () => {
        await browser.get('/');
        navBarPage = new NavBarPage();
        signInPage = await navBarPage.getSignInPage();
        await signInPage.loginWithOAuth('admin', 'admin');
        await browser.wait(ec.visibilityOf(navBarPage.entityMenu), 5000);
    });

    it('should load PersonalData', async () => {
        await navBarPage.goToEntity('personal-data');
        personalDataComponentsPage = new PersonalDataComponentsPage();
        expect(await personalDataComponentsPage.getTitle()).to.eq('jtTestingApp.personalData.home.title');
    });

    it('should load create PersonalData page', async () => {
        await personalDataComponentsPage.clickOnCreateButton();
        personalDataUpdatePage = new PersonalDataUpdatePage();
        expect(await personalDataUpdatePage.getPageTitle()).to.eq('jtTestingApp.personalData.home.createOrEditLabel');
        await personalDataUpdatePage.cancel();
    });

    it('should create and save PersonalData', async () => {
        const nbButtonsBeforeCreate = await personalDataComponentsPage.countDeleteButtons();

        await personalDataComponentsPage.clickOnCreateButton();
        await personalDataUpdatePage.setFirstNameInput('firstName');
        expect(await personalDataUpdatePage.getFirstNameInput()).to.eq('firstName');
        await personalDataUpdatePage.setLastNameInput('lastName');
        expect(await personalDataUpdatePage.getLastNameInput()).to.eq('lastName');
        await personalDataUpdatePage.setBirthDateInput('01/01/2001' + protractor.Key.TAB + '02:30AM');
        expect(await personalDataUpdatePage.getBirthDateInput()).to.contain('2001-01-01T02:30');
        await personalDataUpdatePage.setNationalityInput('nationality');
        expect(await personalDataUpdatePage.getNationalityInput()).to.eq('nationality');
        await personalDataUpdatePage.save();
        expect(await personalDataUpdatePage.getSaveButton().isPresent()).to.be.false;

        expect(await personalDataComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeCreate + 1);
    });

    it('should delete last PersonalData', async () => {
        const nbButtonsBeforeDelete = await personalDataComponentsPage.countDeleteButtons();
        await personalDataComponentsPage.clickOnLastDeleteButton();

        personalDataDeleteDialog = new PersonalDataDeleteDialog();
        expect(await personalDataDeleteDialog.getDialogTitle()).to.eq('jtTestingApp.personalData.delete.question');
        await personalDataDeleteDialog.clickOnConfirmButton();

        expect(await personalDataComponentsPage.countDeleteButtons()).to.eq(nbButtonsBeforeDelete - 1);
    });

    after(async () => {
        await navBarPage.autoSignOut();
    });
});
