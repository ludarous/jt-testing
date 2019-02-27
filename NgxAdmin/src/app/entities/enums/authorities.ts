import {EnumWrapper} from './enum-wrapper';

export enum AuthoritiesEnum {
  ROLE_ADMIN, ROLE_USER, ROLE_SERVICEMAN, ROLE_MANAGER
}

export class Authorities extends EnumWrapper {

  constructor(value: number | string) {
    super(AuthoritiesEnum, value);
  }

  public static ROLE_ADMIN = new Authorities(AuthoritiesEnum.ROLE_ADMIN);
  public static ROLE_USER = new Authorities(AuthoritiesEnum.ROLE_USER);
  public static ROLE_SERVICEMAN = new Authorities(AuthoritiesEnum.ROLE_SERVICEMAN);
  public static ROLE_MANAGER = new Authorities(AuthoritiesEnum.ROLE_MANAGER);
}
