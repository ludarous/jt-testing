import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { WorkoutComponentsPage, WorkoutUpdatePage } from './jt-test.page-object';

describe('Workout e2e test', () => {
    let navBarPage: NavBarPage;
    let jTTestUpdatePage: WorkoutUpdatePage;
    let jTTestComponentsPage: WorkoutComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Workouts', () => {
        navBarPage.goToEntity('jt-test');
        jTTestComponentsPage = new WorkoutComponentsPage();
        expect(jTTestComponentsPage.getTitle()).toMatch(/jtTestingApp.jTTest.home.title/);
    });

    it('should load create Workout page', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage = new WorkoutUpdatePage();
        expect(jTTestUpdatePage.getPageTitle()).toMatch(/jtTestingApp.jTTest.home.createOrEditLabel/);
        jTTestUpdatePage.cancel();
    });

    it('should create and save Workouts', () => {
        jTTestComponentsPage.clickOnCreateButton();
        jTTestUpdatePage.setNameInput('name');
        expect(jTTestUpdatePage.getNameInput()).toMatch('name');
        jTTestUpdatePage.setDescriptionInput('description');
        expect(jTTestUpdatePage.getDescriptionInput()).toMatch('description');
        jTTestUpdatePage.setMinAgeInput('5');
        expect(jTTestUpdatePage.getMinAgeInput()).toMatch('5');
        jTTestUpdatePage.setMaxAgeInput('5');
        expect(jTTestUpdatePage.getMaxAgeInput()).toMatch('5');
        // jTTestUpdatePage.activitiesSelectLastOption();
        // jTTestUpdatePage.categoriesSelectLastOption();
        // jTTestUpdatePage.sportsSelectLastOption();
        jTTestUpdatePage.save();
        expect(jTTestUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
