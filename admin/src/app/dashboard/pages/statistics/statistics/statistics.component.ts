import { Component, OnInit } from '@angular/core';
import { InstitutesService } from 'src/app/dashboard/services/institutes.service';
import { Institute } from 'src/app/models/institute.model';

@Component({
  selector: 'app-statistics',
  templateUrl: './statistics.component.html',
  styleUrls: ['./statistics.component.css']
})
export class StatisticsComponent implements OnInit {

 institutes: Institute[] = []

  constructor( private institutesService: InstitutesService) { }

  ngOnInit(): void {

    this.institutesService.getAll()
      .subscribe( (resp: any) => {
        this.institutes = resp.institutes;
      })

  }




}
