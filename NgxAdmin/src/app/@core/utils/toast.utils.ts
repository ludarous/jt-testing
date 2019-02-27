import {NbToastStatus} from '@nebular/theme/components/toastr/model';
import {NbGlobalPhysicalPosition} from '@nebular/theme';

export class Toast {
  title: string;
  body: string;
  config: any;
}

export class ToastUtils {

  public static prepareToast(type: NbToastStatus, title: string, body: string = null): Toast {
    const config = {
      status: type,
      destroyByClick: true,
      duration: 2000,
      hasIcon: true,
      position: NbGlobalPhysicalPosition.TOP_RIGHT,
      preventDuplicates: true,
    };

    const toast = new Toast();
    toast.body = body;
    toast.title = title;
    toast.config = config;

    return toast;

  }

}
