import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

interface cartItems{
  id:number;
  name: string;
  price: number;
  quantity: number;

}

@Injectable({
  providedIn: 'root'
})
export class CartService {

  private cartSubject = new BehaviorSubject<cartItems[]>([]);
  cart$ = this.cartSubject.asObservable();

  constructor() { }

  addItem(product: cartItems): void{
    const currentCart = this.cartSubject.value;
    const existingProducts = currentCart.find(items => items.id === product.id);

    if(existingProducts){
      existingProducts.quantity += 1;
    }
    else{
      currentCart.push({...product, quantity: 1});
    }

    this.cartSubject.next([...currentCart])

  }

  removeItem(itemId: number){
    const updatedCart =  this.cartSubject.value.filter(items => items.id !== itemId ) ;
    this.cartSubject.next(updatedCart);

  }

  clearCart():void{
    this.cartSubject.next([]);
  }
}
