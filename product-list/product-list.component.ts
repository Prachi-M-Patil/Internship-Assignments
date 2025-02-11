import { Component } from '@angular/core';
import { CartService } from '../cart.service';

interface Product{
  id:number;
  name: string;
  price:number;
}
@Component({
  selector: 'app-product-list',
  standalone: false,
  templateUrl: './product-list.component.html',
  styleUrl: './product-list.component.css'
})
export class ProductListComponent {

  products: Product[]= [
    {id:1, name:"Laptop", price: 60000},
    {id:3, name:"Mobile", price: 20000},
    {id:2, name:"Tablet", price: 30000}

  ]

  constructor (private cartservice: CartService){

  }
  addToCart(product: Product):void{
    this.cartservice.addItem({id: product.id,
      name: product.name,
      price:product.price,
      quantity:1
    });

  }
}
