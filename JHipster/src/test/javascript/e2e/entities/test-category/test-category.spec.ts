import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { TestCategoryComponentsPage, TestCategoryUpdatePage } from './test-category.page-object';

describe('TestCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let testCategoryUpdatePage: TestCategoryUpdatePage;
    let testCategoryComponentsPage: TestCategoryComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load TestCategories', () => {
        navBarPage.goToEntity('test-category');
        testCategoryComponentsPage = new TestCategoryComponentsPage();
        expect(testCategoryComponentsPage.getTitle()).toMatch(/jtTestingApp.testCategory.home.title/);
    });

    it('should load create TestCategory page', () => {
        testCategoryComponentsPage.clickOnCreateButton();
        testCategoryUpdatePage = new TestCategoryUpdatePage();
        expect(testCategoryUpdatePage.getPageTitle()).toMatch(/jtTestingApp.testCategory.home.createOrEditLabel/);
        testCategoryUpdatePage.cancel();
    });

    it('should create and save TestCategories', () => {
        testCategoryComponentsPage.clickOnCreateButton();
        testCategoryUpdatePage.setNameInput('name');
        expect(testCategoryUpdatePage.getNameInput()).toMatch('name');
        testCategoryUpdatePage.setKeyInput('key');
        expect(testCategoryUpdatePage.getKeyInput()).toMatch('key');
        testCategoryUpdatePage.setDescriptionInput('description');
        expect(testCategoryUpdatePage.getDescriptionInput()).toMatch('description');
        testCategoryUpdatePage.save();
        expect(testCategoryUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
