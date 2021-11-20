import { Component, OnInit } from '@angular/core';
import { Novedad } from 'src/app/models/novedad.model';
import { NewsService } from '../../../services/news.service';

@Component({
  selector: 'app-news',
  templateUrl: './news.component.html',
  styleUrls: ['./news.component.css']
})
export class NewsComponent implements OnInit {

  news: Novedad[] = [];
  isLoading: boolean = false;


  constructor( private newsService: NewsService ) { }

  ngOnInit(): void {

    this.isLoading = true;


   // this.newsService.getAll()
     // .subscribe( resp => {
       // this.news = resp;
        //this.isLoading = false;
     // })
  }

}
