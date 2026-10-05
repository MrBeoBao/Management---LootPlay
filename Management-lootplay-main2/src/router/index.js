import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import Register from '../views/Register.vue'
import Login from '../views/Login.vue'
import Games from '../views/Games.vue'
import GameDetail from '../views/GameDetail.vue'
import Cart from '../views/Cart.vue'

const router = createRouter({

    history: createWebHistory(),

    routes: [

        {
            path: '/',
            name: 'Home',
            component: Home
        },

        {
            path: '/register',
            name: 'Register',
            component: Register
        },

        {
            path: '/login',
            name: 'Login',
            component: Login
        },

        {
            path: '/games',
            name: 'Games',
            component: Games
        },

        {
            path: '/games/:id',
            name: 'GameDetail',
            component: GameDetail
        },

        {
            path: '/cart',
            name: 'Cart',
            component: Cart
        },

        {
            path: '/orders',
            name: 'OrderHistory',
            component: () =>
                import('../views/OrderHistory.vue')
        },

        {
            path: '/orders/:id',
            name: 'OrderDetail',
            component: () =>
                import('../views/OrderDetail.vue')
        }

    ]

})

export default router