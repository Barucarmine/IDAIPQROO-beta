import { Pipe, PipeTransform } from '@angular/core';
import { environment } from '../../environments/environment';

const base_url = environment.base_url;

@Pipe({
  name: 'image'
})
export class ImagePipe implements PipeTransform {

  transform(imagen: string | undefined, tipo: 'reports' | 'users' | 'news' | 'institutes' | 'tips' ): string {
    
    
    if ( !imagen ) {
      return `${ base_url }/upload/no-image/no-image`;
    } else {
      return `${ base_url }/upload/${tipo}/${imagen}`;
    }

  }

}
