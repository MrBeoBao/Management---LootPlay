<template>
  <header class="header">
    <div class="header-container">

      <!-- Left trust badges -->
      <div class="header-left">

        <span class="trust-item">
          <i class="bx bx-shield-quarter"></i>
          <span>100% Game Bản Quyền</span>
        </span>

        <span class="trust-divider"></span>

        <span class="trust-item">
          <i class="bx bx-bolt-circle"></i>
          <span>Giao Key Tức Thì 24/7</span>
        </span>

        <span class="trust-divider"></span>

        <span class="trust-item d-none d-md-flex">
          <i class="bx bx-headphone"></i>
          <span>Hỗ Trợ Kỹ Thuật</span>
        </span>

      </div>


      <!-- Right -->
      <div class="header-right">

        <!-- Cart -->
        <button
          class="cart-button"
          @click="goToCart"
          title="Xem giỏ hàng của bạn"
        >
          <span class="cart-icon-wrapper">
            <i class="bx bx-shopping-bag"></i>
          </span>

          <span class="cart-label">
            GIỎ HÀNG
          </span>
        </button>


        <!-- Logged in -->
        <div
          v-if="user"
          class="user-area"
        >

          <!-- Order History -->
          <button
            class="history-button"
            @click="goToOrders"
            title="Xem lịch sử đơn hàng"
          >
            <i class="bx bx-history"></i>

            <span class="history-label">
              LỊCH SỬ
            </span>
          </button>


          <!-- User -->
          <div class="user-pill">

            <span class="user-avatar">
              <i class="bx bxs-user"></i>
            </span>

            <span class="welcome-text">

              <span class="welcome-muted">
                Chào,
              </span>

              <strong class="user-name">
                {{ user.name }}
              </strong>

            </span>

          </div>


          <!-- Logout -->
          <button
            class="logout-button"
            @click="logout"
            title="Đăng xuất khỏi tài khoản"
          >
            <i class="bx bx-log-out"></i>

            <span class="logout-label">
              ĐĂNG XUẤT
            </span>
          </button>

        </div>


        <!-- Guest -->
        <div
          v-else
          class="auth-buttons"
        >

          <button
            class="login-button"
            @click="goToLogin"
          >
            <i class="bx bx-log-in"></i>

            <span>
              ĐĂNG NHẬP
            </span>
          </button>


          <button
            class="register-button"
            @click="goToRegister"
          >
            <i class="bx bx-user-plus"></i>

            <span>
              ĐĂNG KÝ
            </span>
          </button>

        </div>

      </div>

    </div>
  </header>
</template>


<script>

export default {

  name: 'HeaderClient',

  data() {

    return {

      user: null

    }

  },


  mounted() {

    this.loadUser()

  },


  methods: {

    loadUser() {

      const savedUser =
        localStorage.getItem('user')


      if (savedUser) {

        try {

          this.user =
            JSON.parse(savedUser)

        }

        catch (e) {

          localStorage.removeItem('user')

          this.user = null

        }

      }

    },


    goToLogin() {

      window.location.href =
        '/login'

    },


    goToRegister() {

      window.location.href =
        '/register'

    },


    goToCart() {

      window.location.href =
        '/cart'

    },


    goToOrders() {

      window.location.href =
        '/orders'

    },


    logout() {

      localStorage.removeItem('user')

      this.user = null

      window.location.href =
        '/'

    }

  }

}

</script>


<style scoped>

.header {
  width: 100%;

  background:
    rgba(10, 14, 23, 0.95);

  border-bottom:
    1px solid rgba(255, 255, 255, 0.06);

  font-family:
    var(--font-main, sans-serif);
}


.header-container {
  max-width: 1280px;

  height: 48px;

  margin: 0 auto;

  padding: 0 24px;

  display: flex;

  align-items: center;

  justify-content: space-between;
}


/* =========================
   LEFT TRUST
========================= */

.header-left {
  display: flex;

  align-items: center;

  gap: 14px;
}


.trust-item {
  display: flex;

  align-items: center;

  gap: 6px;

  font-size: 12px;

  font-weight: 500;

  color: #94a3b8;

  letter-spacing: 0.2px;
}


.trust-item i {
  color: #3b82f6;

  font-size: 15px;
}


.trust-divider {
  width: 1px;

  height: 14px;

  background:
    rgba(255, 255, 255, 0.1);
}


/* =========================
   RIGHT
========================= */

.header-right {
  display: flex;

  align-items: center;

  gap: 10px;
}


/* =========================
   CART
========================= */

.cart-button {
  display: inline-flex;

  align-items: center;

  gap: 8px;

  padding: 6px 14px;

  background:
    rgba(255, 255, 255, 0.05);

  border:
    1px solid rgba(255, 255, 255, 0.12);

  border-radius: 8px;

  color: #f1f5f9;

  font-size: 12px;

  font-weight: 700;

  letter-spacing: 0.5px;

  cursor: pointer;

  transition: all 0.2s ease;
}


.cart-button:hover {
  background:
    rgba(59, 130, 246, 0.15);

  border-color:
    rgba(59, 130, 246, 0.5);

  color: #60a5fa;

  transform: translateY(-1px);

  box-shadow:
    0 4px 12px
    rgba(59, 130, 246, 0.2);
}


.cart-icon-wrapper i {
  font-size: 15px;

  color: #38bdf8;
}


/* =========================
   USER AREA
========================= */

.user-area {
  display: flex;

  align-items: center;

  gap: 8px;
}


/* =========================
   HISTORY
========================= */

.history-button {
  display: inline-flex;

  align-items: center;

  gap: 6px;

  padding: 6px 12px;

  background:
    rgba(56, 189, 248, 0.08);

  border:
    1px solid rgba(56, 189, 248, 0.22);

  border-radius: 8px;

  color: #7dd3fc;

  font-size: 11px;

  font-weight: 700;

  letter-spacing: 0.4px;

  cursor: pointer;

  transition: all 0.2s ease;
}


.history-button i {
  font-size: 15px;
}


.history-button:hover {
  background:
    rgba(59, 130, 246, 0.18);

  border-color:
    rgba(59, 130, 246, 0.5);

  color: #ffffff;

  transform: translateY(-1px);

  box-shadow:
    0 4px 12px
    rgba(59, 130, 246, 0.2);
}


/* =========================
   USER
========================= */

.user-pill {
  display: flex;

  align-items: center;

  gap: 8px;

  padding: 4px 12px 4px 6px;

  background:
    rgba(30, 41, 59, 0.6);

  border:
    1px solid rgba(255, 255, 255, 0.08);

  border-radius: 20px;
}


.user-avatar {
  width: 26px;

  height: 26px;

  border-radius: 50%;

  background:
    linear-gradient(
      135deg,
      #3b82f6,
      #8b5cf6
    );

  display: flex;

  align-items: center;

  justify-content: center;

  color: #fff;

  font-size: 14px;
}


.welcome-text {
  font-size: 12px;
}


.welcome-muted {
  color: #94a3b8;

  margin-right: 4px;
}


.user-name {
  color: #38bdf8;

  font-weight: 600;
}


/* =========================
   LOGOUT
========================= */

.logout-button {
  display: inline-flex;

  align-items: center;

  gap: 5px;

  padding: 6px 12px;

  background:
    rgba(239, 68, 68, 0.1);

  border:
    1px solid rgba(239, 68, 68, 0.25);

  border-radius: 8px;

  color: #f87171;

  font-size: 11px;

  font-weight: 700;

  cursor: pointer;

  transition: all 0.2s ease;
}


.logout-button:hover {
  background: #ef4444;

  color: #ffffff;

  border-color: #ef4444;

  box-shadow:
    0 4px 12px
    rgba(239, 68, 68, 0.3);

  transform: translateY(-1px);
}


/* =========================
   LOGIN REGISTER
========================= */

.auth-buttons {
  display: flex;

  align-items: center;

  gap: 8px;
}


.login-button,
.register-button {
  display: inline-flex;

  align-items: center;

  gap: 6px;

  padding: 6px 14px;

  border-radius: 8px;

  font-size: 12px;

  font-weight: 700;

  letter-spacing: 0.4px;

  cursor: pointer;

  transition: all 0.2s ease;
}


.login-button {
  background: transparent;

  color: #93c5fd;

  border:
    1px solid rgba(147, 197, 253, 0.3);
}


.login-button:hover {
  background:
    rgba(59, 130, 246, 0.15);

  border-color: #3b82f6;

  color: #ffffff;

  transform: translateY(-1px);
}


.register-button {
  background:
    linear-gradient(
      135deg,
      #2563eb,
      #7c3aed
    );

  color: #ffffff;

  border:
    1px solid transparent;

  box-shadow:
    0 2px 10px
    rgba(37, 99, 235, 0.3);
}


.register-button:hover {
  background:
    linear-gradient(
      135deg,
      #1d4ed8,
      #6d28d9
    );

  box-shadow:
    0 4px 15px
    rgba(37, 99, 235, 0.5);

  transform: translateY(-1px);
}


/* =========================
   RESPONSIVE
========================= */

@media (max-width: 900px) {

  .header-left {
    display: none;
  }

  .header-container {
    justify-content: flex-end;
  }

  .cart-label,
  .history-label,
  .logout-label {
    display: none;
  }

  .cart-button,
  .history-button {
    padding: 6px 10px;
  }

}


@media (max-width: 600px) {

  .user-pill {
    padding-right: 6px;
  }

  .welcome-text {
    display: none;
  }

}

</style>