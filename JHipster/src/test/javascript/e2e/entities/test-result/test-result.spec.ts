import { browser } from 'protractor';
import { NavBarPage } from './../../page-objects/jhi-page-objects';
import { WorkoutResultComponentsPage, WorkoutResultUpdatePage } from './test-result.page-object';

describe('WorkoutResult e2e test', () => {
    let navBarPage: NavBarPage;
    let workoutResultUpdatePage: WorkoutResultUpdatePage;
    let workoutResultComponentsPage: WorkoutResultComponentsPage;

    beforeAll(() => {
        browser.get('/');
        browser.waitForAngular();
        navBarPage = new NavBarPage();
        navBarPage.getSignInPage().autoSignInUsing('admin', 'admin');
        browser.waitForAngular();
    });

    it('should load WorkoutResults', () => {
        navBarPage.goToEntity('test-result');
        workoutResultComponentsPage = new WorkoutResultComponentsPage();
        expect(workoutResultComponentsPage.getTitle()).toMatch(/jtTestingApp.workoutResult.home.title/);
    });

    it('should load create WorkoutResult page', () => {
        workoutResultComponentsPage.clickOnCreateButton();
        workoutResultUpdatePage = new WorkoutResultUpdatePage();
        expect(workoutResultUpdatePage.getPageTitle()).toMatch(/jtTestingApp.workoutResult.home.createOrEditLabel/);
        workoutResultUpdatePage.cancel();
    });

    /* it('should create and save WorkoutResults', () => {
        workoutResultComponentsPage.clickOnCreateButton();
        workoutResultUpdatePage.setNoteInput('note');
        expect(workoutResultUpdatePage.getNoteInput()).toMatch('note');
        workoutResultUpdatePage.eventResultSelectLastOption();
        workoutResultUpdatePage.testSelectLastOption();
        workoutResultUpdatePage.save();
        expect(workoutResultUpdatePage.getSaveButton().isPresent()).toBeFalsy();
    });*/

    afterAll(() => {
        navBarPage.autoSignOut();
    });
});
