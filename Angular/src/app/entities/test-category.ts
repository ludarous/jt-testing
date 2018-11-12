export interface ITestCategory {
  id?: number;
  name?: string;
  description?: string;
  key?: string;
}

export class TestCategory implements ITestCategory {
  id: number;
  name: string;
  description: string;
  key: string;
}
