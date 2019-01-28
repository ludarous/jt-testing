import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { GroupComponentsPage, GroupUpdatePage } from './group.page-object';

describe('Group e2e test', () => {
    let navBarPage: NavBarPage;
    let groupUpdatePage: GroupUpdatePage;
    let groupComponentsPage: GroupComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Groups', () => {
        navBarPage.goToEntity('group');
        groupComponentsPage = new GroupComponentsPage();
        expect(groupComponentsPage.getTitle()).toMatch(/jtTestingApp.group.home.title/);
    });

    it('should load create Group page', () => {
        groupComponentsPage.clickOnCreateButton();
        groupUpdatePage = new GroupUpdatePage();
        expect(groupUpdatePage.getPageTitle()).toMatch(/jtTestingApp.group.home.createOrEditLabel/);
        groupUpdatePage.cancel();
    });

    it('should create and save Groups', () => {
        groupComponentsPage.clickOnCreateButton();
        groupUpdatePage.setNameInput('name');
        expect(groupUpdatePage.getNameInput()).toMatch('name');
        groupUpdatePage.save();
        expect(groupUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
