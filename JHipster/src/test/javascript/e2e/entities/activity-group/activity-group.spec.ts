import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { WorkoutComponentsPage, WorkoutUpdatePage } from './activity-group.page-object';

describe('Workout e2e test', () => {
    let navBarPage: NavBarPage;
    let workoutUpdatePage: WorkoutUpdatePage;
    let workoutComponentsPage: WorkoutComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load Workouts', () => {
        navBarPage.goToEntity('activity-group');
        workoutComponentsPage = new WorkoutComponentsPage();
        expect(workoutComponentsPage.getTitle()).toMatch(/jtTestingApp.workout.home.title/);
    });

    it('should load create Workout page', () => {
        workoutComponentsPage.clickOnCreateButton();
        workoutUpdatePage = new WorkoutUpdatePage();
        expect(workoutUpdatePage.getPageTitle()).toMatch(/jtTestingApp.workout.home.createOrEditLabel/);
        workoutUpdatePage.cancel();
    });

    it('should create and save Workouts', () => {
        workoutComponentsPage.clickOnCreateButton();
        workoutUpdatePage.setNameInput('name');
        expect(workoutUpdatePage.getNameInput()).toMatch('name');
        workoutUpdatePage.setDescriptionInput('description');
        expect(workoutUpdatePage.getDescriptionInput()).toMatch('description');
        workoutUpdatePage.setMinAgeInput('5');
        expect(workoutUpdatePage.getMinAgeInput()).toMatch('5');
        workoutUpdatePage.setMaxAgeInput('5');
        expect(workoutUpdatePage.getMaxAgeInput()).toMatch('5');
        // workoutUpdatePage.activitiesSelectLastOption();
        // workoutUpdatePage.workoutCategoriesSelectLastOption();
        workoutUpdatePage.save();
        expect(workoutUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
