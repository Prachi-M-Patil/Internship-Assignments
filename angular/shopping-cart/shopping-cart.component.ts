import { Component } from '@angular/core';
import { CartService } from '../cart.service';

@Component({
  selector: 'app-shopping-cart',
  standalone: false,
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.css'] // Corrected property name
})
export class ShoppingCartComponent {

  title = 'ShoppingCart';
  constructor(private cartService: CartService) {}

  get cartItems$(){
    return this.cartService.cart$;
  }  
  // Added space after assignment operator

  removeFromCart(productId: number){
    this.cartService.removeItem(productId);
  }

  clearCart():void{
    this.cartService.clearCart();
  }

}
