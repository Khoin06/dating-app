import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  registerNode = false;


  constructor() {} 

  ngOnInit(): void {

  }

  registerToggle(){
    this.registerNode = !this.registerNode;
  }


  cancelRegisterNode(event:boolean){
    this.registerNode = event;
  }
}
