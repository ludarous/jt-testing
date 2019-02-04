import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { WorkoutCategoryComponentsPage, WorkoutCategoryUpdatePage } from './workout-category.page-object';

describe('WorkoutCategory e2e test', () => {
    let navBarPage: NavBarPage;
    let workoutCategoryUpdatePage: WorkoutCategoryUpdatePage;
    let workoutCategoryComponentsPage: WorkoutCategoryComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load WorkoutCategories', () => {
        navBarPage.goToEntity('workout-category');
        workoutCategoryComponentsPage = new WorkoutCategoryComponentsPage();
        expect(workoutCategoryComponentsPage.getTitle()).toMatch(/jtTestingApp.workoutCategory.home.title/);
    });

    it('should load create WorkoutCategory page', () => {
        workoutCategoryComponentsPage.clickOnCreateButton();
        workoutCategoryUpdatePage = new WorkoutCategoryUpdatePage();
        expect(workoutCategoryUpdatePage.getPageTitle()).toMatch(/jtTestingApp.workoutCategory.home.createOrEditLabel/);
        workoutCategoryUpdatePage.cancel();
    });

    it('should create and save WorkoutCategories', () => {
        workoutCategoryComponentsPage.clickOnCreateButton();
        workoutCategoryUpdatePage.setNameInput('name');
        expect(workoutCategoryUpdatePage.getNameInput()).toMatch('name');
        workoutCategoryUpdatePage.setKeyInput('key');
        expect(workoutCategoryUpdatePage.getKeyInput()).toMatch('key');
        workoutCategoryUpdatePage.setDescriptionInput('description');
        expect(workoutCategoryUpdatePage.getDescriptionInput()).toMatch('description');
        workoutCategoryUpdatePage.save();
        expect(workoutCategoryUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
