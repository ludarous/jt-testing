export class StatsUtils {

  static average(array: Array<number>): number {
    let sum = 0;

    for (let i = 0; i < array.length; i++) {
      sum += array[i];
    }

    const average = sum / array.length;
    return average;
  }

}
