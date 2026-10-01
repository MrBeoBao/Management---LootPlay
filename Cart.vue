<template>
  <div class="cart-page">
    <div class="container py-5">

      <!-- LOADING -->
      <div v-if="loading" class="text-center py-5">
        <div class="spinner-border" role="status"></div>
        <p class="mt-3">Đang tải giỏ hàng...</p>
      </div>

      <!-- ERROR -->
      <div v-else-if="error" class="alert alert-danger">
        {{ error }}
      </div>

      <div v-else>

        <!-- HEADER -->
        <div class="cart-header">
          <h1>
            <i class="bx bx-cart"></i>
            GIỎ HÀNG
          </h1>

          <span v-if="items.length > 0">
            {{ items.length }} sản phẩm
          </span>
        </div>

        <!-- GIỎ HÀNG TRỐNG -->
        <div v-if="items.length === 0" class="empty-cart">

          <i class="bx bx-cart-alt"></i>

          <h3>Giỏ hàng đang trống</h3>

          <p>
            Hãy thêm game vào giỏ hàng để tiếp tục.
          </p>

          <router-link
            to="/games"
            class="continue-btn"
          >
            <i class="bx bx-store"></i>
            XEM GAME
          </router-link>

        </div>

        <!-- DANH SÁCH GIỎ HÀNG -->
        <div v-else class="row g-4">

          <!-- DANH SÁCH GAME -->
          <div class="col-lg-8">

            <div
              v-for="item in items"
              :key="item.id"
              class="cart-item"
            >

              <!-- ẢNH GAME -->
              <div class="game-image">

                <img
                  v-if="
                    item.game &&
                    item.game.images &&
                    item.game.images.length > 0
                  "
                  :src="item.game.images[0].image_url"
                  :alt="item.game.name"
                >

                <div v-else class="no-image">
                  <i class="bx bx-image"></i>
                </div>

              </div>

              <!-- THÔNG TIN GAME -->
              <div class="game-info">

                <h3>
                  {{
                    item.game
                      ? item.game.name
                      : 'Game không tồn tại'
                  }}
                </h3>

                <p
                  v-if="item.game && item.game.category"
                  class="category"
                >
                  {{ item.game.category.name }}
                </p>

                <p class="price">
                  {{
                    formatPrice(
                      item.game
                        ? item.game.price
                        : 0
                    )
                  }}
                </p>

              </div>

              <!-- SỐ LƯỢNG -->
              <div class="quantity-box">

                <button
                  type="button"
                  @click="decreaseQuantity(item)"
                  :disabled="
                    updating ||
                    checkoutLoading ||
                    Number(item.quantity) <= 1
                  "
                >
                  −
                </button>

                <input
                  type="number"
                  min="1"
                  :value="item.quantity"
                  @change="
                    updateQuantity(
                      item,
                      $event.target.value
                    )
                  "
                  :disabled="
                    updating ||
                    checkoutLoading
                  "
                >

                <button
                  type="button"
                  @click="increaseQuantity(item)"
                  :disabled="
                    updating ||
                    checkoutLoading
                  "
                >
                  +
                </button>

              </div>

              <!-- TỔNG TIỀN GAME -->
              <div class="item-total">

                {{
                  formatPrice(
                    (
                      item.game
                        ? Number(item.game.price)
                        : 0
                    ) *
                    Number(item.quantity)
                  )
                }}

              </div>

              <!-- XÓA -->
              <button
                type="button"
                class="remove-btn"
                @click="removeItem(item)"
                :disabled="
                  updating ||
                  checkoutLoading
                "
              >
                <i class="bx bx-trash"></i>
              </button>

            </div>

          </div>

          <!-- TÓM TẮT ĐƠN -->
          <div class="col-lg-4">

            <div class="cart-summary">

              <h2>TÓM TẮT ĐƠN HÀNG</h2>

              <div class="summary-row">

                <span>Số sản phẩm</span>

                <strong>
                  {{ totalItems }}
                </strong>

              </div>

              <div class="summary-row">

                <span>Tạm tính</span>

                <strong>
                  {{ formatPrice(subTotal) }}
                </strong>

              </div>

              <div class="summary-row">

                <span>Phí xử lý</span>

                <strong>
                  0 ₫
                </strong>

              </div>

              <hr>

              <div class="summary-total">

                <span>
                  TỔNG CỘNG
                </span>

                <strong>
                  {{ formatPrice(subTotal) }}
                </strong>

              </div>

              <button
                type="button"
                class="checkout-btn"
                @click="checkout"
                :disabled="
                  updating ||
                  checkoutLoading ||
                  items.length === 0
                "
              >

                <i class="bx bx-credit-card"></i>

                {{
                  checkoutLoading
                    ? 'ĐANG XỬ LÝ...'
                    : 'TIẾN HÀNH THANH TOÁN'
                }}

              </button>

              <router-link
                to="/games"
                class="continue-shopping"
              >
                <i class="bx bx-arrow-back"></i>
                Tiếp tục mua game
              </router-link>

            </div>

          </div>

        </div>

      </div>

    </div>

    <!-- =========================
         PAYMENT MODAL
    ========================== -->
    <div
      v-if="showPaymentModal"
      class="payment-overlay"
    >

      <div class="payment-modal">

        <!-- NÚT ĐÓNG -->
        <button
          type="button"
          class="close-payment"
          @click="closePaymentModal"
        >
          <i class="bx bx-x"></i>
        </button>

        <!-- TIÊU ĐỀ -->
        <div class="payment-header">

          <i class="bx bx-credit-card"></i>

          <h2>
            THANH TOÁN CHUYỂN KHOẢN
          </h2>

          <p>
            Quét mã QR để chuyển khoản
          </p>

        </div>

        <!-- QR -->
        <div class="qr-container">

          <img
            v-if="qrImage && !qrImageErrorState"
            :src="qrImage"
            alt="QR thanh toán Vietcombank"
            class="qr-image"
            @error="qrImageError"
          >

          <div
            v-if="qrImageErrorState"
            class="qr-error"
          >
            Không thể tải mã QR.
          </div>

        </div>

        <!-- THÔNG TIN NGÂN HÀNG -->
        <div class="payment-information">

          <div class="payment-row">

            <span>
              Ngân hàng
            </span>

            <strong>
              Vietcombank
            </strong>

          </div>

          <div class="payment-row">

            <span>
              Chủ tài khoản
            </span>

            <strong>
              HOANG ANH TUAN
            </strong>

          </div>

          <div class="payment-row">

            <span>
              Số tài khoản
            </span>

            <strong>
              1048703459
            </strong>

          </div>

          <div class="payment-row">

            <span>
              Số tiền
            </span>

            <strong class="payment-amount">
              {{ formatPrice(paymentAmount) }}
            </strong>

          </div>

          <div
            v-if="paymentTransactionCode"
            class="payment-row"
          >

            <span>
              Mã giao dịch
            </span>

            <strong>
              {{ paymentTransactionCode }}
            </strong>

          </div>

          <div
            v-if="currentOrder"
            class="payment-row"
          >

            <span>
              Mã đơn hàng
            </span>

            <strong>
              {{ currentOrder.order_code }}
            </strong>

          </div>

        </div>

        <!-- LƯU Ý -->
        <div class="payment-note">

          <i class="bx bx-info-circle"></i>

          <div>

            <strong>
              Lưu ý
            </strong>

            <p>
              Vui lòng chuyển đúng số tiền hiển thị.
            </p>

            <p>
              Nội dung chuyển khoản nên sử dụng
              mã đơn hàng.
            </p>

            <p>
              Hệ thống sẽ tự động kiểm tra trạng thái
              thanh toán sau khi nhận được giao dịch.
            </p>

          </div>

        </div>

        <!-- ĐANG CHỜ -->
        <div
          v-if="paymentStatus === 'pending'"
          class="payment-waiting"
        >

          <i class="bx bx-time-five"></i>

          <span>
            Đang chờ xác nhận thanh toán...
          </span>

        </div>

        <!-- THANH TOÁN THÀNH CÔNG -->
        <div
          v-else-if="paymentStatus === 'paid'"
          class="payment-success"
        >

          <i class="bx bx-check-circle"></i>

          <div>

            <strong>
              THANH TOÁN THÀNH CÔNG
            </strong>

            <p>
              Đã nhận được thanh toán cho đơn hàng
              {{ currentOrder?.order_code }}
            </p>

          </div>

        </div>

        <!-- TRẠNG THÁI KHÁC -->
        <div
          v-else
          class="payment-waiting"
        >

          <i class="bx bx-time-five"></i>

          <span>
            Đang kiểm tra thanh toán...
          </span>

        </div>

        <!-- NÚT ĐÓNG -->
        <button
          type="button"
          class="payment-done-btn"
          @click="closePaymentModal"
        >
          {{
            paymentStatus === 'paid'
              ? 'HOÀN TẤT'
              : 'ĐÓNG'
          }}
        </button>

      </div>

    </div>

  </div>
</template>

<script>
export default {
  name: 'Cart',

  data() {
    return {
      items: [],

      loading: true,

      error: '',

      updating: false,

      checkoutLoading: false,

      user: null,

      // =========================
      // THANH TOÁN
      // =========================
      showPaymentModal: false,

      qrImage: '',

      qrImageErrorState: false,

      paymentAmount: 0,

      paymentTransactionCode: '',

      currentOrder: null,

      paymentStatus: 'pending',

      paymentCheckInterval: null
    }
  },

  computed: {

    // =========================
    // TỔNG SỐ LƯỢNG
    // =========================
    totalItems() {

      return this.items.reduce(
        (total, item) => {

          return total +
            Number(
              item.quantity || 0
            )

        },
        0
      )
    },

    // =========================
    // TỔNG TIỀN
    // =========================
    subTotal() {

      return this.items.reduce(
        (total, item) => {

          const price =
            item.game
              ? Number(item.game.price)
              : 0

          const quantity =
            Number(
              item.quantity || 0
            )

          return total +
            (
              price *
              quantity
            )

        },
        0
      )
    }
  },

  mounted() {

    this.loadCart()

  },

  beforeUnmount() {

    this.stopPaymentStatusChecking()

  },

  methods: {

    // =========================
    // LẤY GIỎ HÀNG
    // =========================
    async loadCart() {

      this.loading = true

      this.error = ''

      try {

        const savedUser =
          localStorage.getItem('user')

        if (!savedUser) {

          this.error =
            'Vui lòng đăng nhập để xem giỏ hàng.'

          return
        }

        this.user =
          JSON.parse(savedUser)

        const response =
          await fetch(
            `http://127.0.0.1:8000/api/cart/${this.user.id}`
          )

        const data =
          await response.json()

        if (!response.ok) {

          throw new Error(
            data.message ||
            'Không thể tải giỏ hàng'
          )
        }

        this.items =
          data.items || []

      } catch (error) {

        console.error(error)

        this.error =
          error.message ||
          'Có lỗi xảy ra khi tải giỏ hàng.'

      } finally {

        this.loading = false

      }
    },

    // =========================
    // TĂNG SỐ LƯỢNG
    // =========================
    async increaseQuantity(item) {

      if (
        this.updating ||
        this.checkoutLoading
      ) {
        return
      }

      await this.updateQuantity(
        item,
        Number(item.quantity) + 1
      )
    },

    // =========================
    // GIẢM SỐ LƯỢNG
    // =========================
    async decreaseQuantity(item) {

      if (
        this.updating ||
        this.checkoutLoading
      ) {
        return
      }

      if (
        Number(item.quantity) <= 1
      ) {
        return
      }

      await this.updateQuantity(
        item,
        Number(item.quantity) - 1
      )
    },

    // =========================
    // CẬP NHẬT SỐ LƯỢNG
    // =========================
    async updateQuantity(
      item,
      quantity
    ) {

      if (
        this.updating ||
        this.checkoutLoading
      ) {
        return
      }

      quantity =
        Number(quantity)

      if (
        !Number.isInteger(quantity) ||
        quantity < 1
      ) {

        alert(
          'Số lượng không hợp lệ.'
        )

        return
      }

      this.updating = true

      try {

        const response =
          await fetch(
            'http://127.0.0.1:8000/api/cart/update',
            {
              method: 'PUT',

              headers: {
                'Content-Type':
                  'application/json'
              },

              body: JSON.stringify({
                cart_item_id:
                  item.id,

                quantity:
                  quantity
              })
            }
          )

        const data =
          await response.json()

        if (!response.ok) {

          throw new Error(
            data.message ||
            'Không thể cập nhật số lượng'
          )
        }

        item.quantity =
          quantity

      } catch (error) {

        console.error(error)

        alert(
          error.message ||
          'Không thể cập nhật số lượng.'
        )

      } finally {

        this.updating = false

      }
    },

    // =========================
    // XÓA SẢN PHẨM
    // =========================
    async removeItem(item) {

      if (
        this.updating ||
        this.checkoutLoading
      ) {
        return
      }

      const confirmed =
        confirm(
          `Bạn có chắc muốn xóa "${item.game?.name || 'sản phẩm'}" khỏi giỏ hàng không?`
        )

      if (!confirmed) {
        return
      }

      this.updating = true

      try {

        const response =
          await fetch(
            `http://127.0.0.1:8000/api/cart/remove/${item.id}`,
            {
              method: 'DELETE'
            }
          )

        const data =
          await response.json()

        if (!response.ok) {

          throw new Error(
            data.message ||
            'Không thể xóa sản phẩm'
          )
        }

        this.items =
          this.items.filter(
            cartItem =>
              cartItem.id !== item.id
          )

      } catch (error) {

        console.error(error)

        alert(
          error.message ||
          'Không thể xóa sản phẩm.'
        )

      } finally {

        this.updating = false

      }
    },

    // =========================
    // THANH TOÁN
    // =========================
    async checkout() {

      if (
        this.checkoutLoading ||
        this.updating
      ) {
        return
      }

      if (!this.user) {

        alert(
          'Vui lòng đăng nhập trước khi thanh toán.'
        )

        return
      }

      if (!this.items.length) {

        alert(
          'Giỏ hàng đang trống.'
        )

        return
      }

      const confirmed =
        confirm(
          `Bạn có muốn tạo đơn hàng với tổng số tiền ${this.formatPrice(this.subTotal)} không?`
        )

      if (!confirmed) {
        return
      }

      this.checkoutLoading = true

      this.error = ''

      try {

        // =========================
        // BƯỚC 1
        // TẠO ĐƠN HÀNG
        // =========================
        const orderResponse =
          await fetch(
            'http://127.0.0.1:8000/api/orders',
            {
              method: 'POST',

              headers: {
                'Content-Type':
                  'application/json'
              },

              body: JSON.stringify({
                user_id:
                  this.user.id
              })
            }
          )

        const orderData =
          await orderResponse.json()

        if (!orderResponse.ok) {

          throw new Error(
            orderData.message ||
            'Không thể tạo đơn hàng.'
          )
        }

        const order =
          orderData.order

        // =========================
        // BƯỚC 2
        // TẠO PAYMENT
        // =========================
        const paymentResponse =
          await fetch(
            'http://127.0.0.1:8000/api/payments',
            {
              method: 'POST',

              headers: {
                'Content-Type':
                  'application/json'
              },

              body: JSON.stringify({
                order_id:
                  order.id,

                payment_method:
                  'banking'
              })
            }
          )

        const paymentData =
          await paymentResponse.json()

        if (!paymentResponse.ok) {

          throw new Error(
            paymentData.message ||
            'Không thể tạo yêu cầu thanh toán.'
          )
        }

        const payment =
          paymentData.payment

        // =========================
        // LƯU THÔNG TIN
        // =========================
        this.currentOrder =
          order

        this.paymentAmount =
          Number(
            payment.amount
          )

        this.paymentTransactionCode =
          payment.transaction_code ||
          ''

        this.paymentStatus =
          payment.status ||
          'pending'

        // =========================
        // TẠO QR
        // =========================
        const amount =
          Math.round(
            Number(
              payment.amount
            )
          )

        const orderCode =
          order.order_code

        const addInfo =
          encodeURIComponent(
            orderCode
          )

        const accountName =
          encodeURIComponent(
            'HOANG ANH TUAN'
          )

        this.qrImage =
          `https://img.vietqr.io/image/VCB-1048703459-compact2.png?amount=${amount}&addInfo=${addInfo}&accountName=${accountName}`

        this.qrImageErrorState =
          false

        // =========================
        // HIỆN MODAL
        // =========================
        this.showPaymentModal =
          true

        // =========================
        // BẮT ĐẦU KIỂM TRA PAYMENT
        // =========================
        this.startPaymentStatusChecking(
          order.id
        )

        // Backend đã xử lý giỏ hàng
        this.items = []

      } catch (error) {

        console.error(error)

        alert(
          error.message ||
          'Có lỗi xảy ra trong quá trình thanh toán.'
        )

      } finally {

        this.checkoutLoading =
          false

      }
    },

    // =========================
    // KIỂM TRA TRẠNG THÁI THANH TOÁN
    // =========================
    startPaymentStatusChecking(orderId) {

      this.stopPaymentStatusChecking()

      this.paymentStatus =
        'pending'

      this.paymentCheckInterval =
        setInterval(async () => {

          try {

            const response =
              await fetch(
                `http://127.0.0.1:8000/api/payments/${orderId}`
              )

            const data =
              await response.json()

            if (!response.ok) {
              return
            }

            const payment =
              data.payment

            if (!payment) {
              return
            }

            this.paymentStatus =
              payment.status

            // =========================
            // ĐÃ THANH TOÁN
            // =========================
            if (
              payment.status === 'paid'
            ) {

              this.paymentTransactionCode =
                payment.transaction_code ||
                ''

              this.stopPaymentStatusChecking()

            }

          } catch (error) {

            console.error(
              'Lỗi kiểm tra thanh toán:',
              error
            )

          }

        }, 3000)
    },

    // =========================
    // DỪNG KIỂM TRA THANH TOÁN
    // =========================
    stopPaymentStatusChecking() {

      if (
        this.paymentCheckInterval
      ) {

        clearInterval(
          this.paymentCheckInterval
        )

        this.paymentCheckInterval =
          null
      }
    },

    // =========================
    // QR BỊ LỖI
    // =========================
    qrImageError() {

      this.qrImageErrorState =
        true

    },

    // =========================
    // ĐÓNG QR
    // =========================
    closePaymentModal() {

      this.showPaymentModal =
        false

      this.stopPaymentStatusChecking()

    },

    // =========================
    // FORMAT TIỀN
    // =========================
    formatPrice(price) {

      return Number(
        price || 0
      ).toLocaleString(
        'vi-VN'
      ) + ' ₫'

    }
  }
}
</script>

<style scoped>

.cart-page {
  min-height: 100vh;
  background: #f5f7fb;
  padding-top: 30px;
  padding-bottom: 50px;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
}

/* HEADER */

.cart-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 30px;
}

.cart-header h1 {
  margin: 0;
  font-size: 30px;
  font-weight: 700;
  color: #222;
}

.cart-header h1 i {
  margin-right: 10px;
}

.cart-header span {
  color: #777;
  font-size: 15px;
}

/* CART ITEM */

.cart-item {
  position: relative;
  display: flex;
  align-items: center;
  gap: 18px;
  background: #fff;
  border-radius: 12px;
  padding: 18px;
  margin-bottom: 15px;
  box-shadow:
    0 4px 15px rgba(0, 0, 0, 0.06);
}

.game-image {
  width: 110px;
  height: 80px;
  flex-shrink: 0;
  overflow: hidden;
  border-radius: 8px;
  background: #eee;
}

.game-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.no-image {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 30px;
}

/* GAME INFO */

.game-info {
  flex: 1;
  min-width: 0;
}

.game-info h3 {
  margin: 0 0 7px;
  font-size: 18px;
  font-weight: 700;
  color: #222;
}

.game-info .category {
  margin: 0 0 7px;
  font-size: 13px;
  color: #888;
}

.game-info .price {
  margin: 0;
  font-size: 15px;
  font-weight: 600;
  color: #e63946;
}

/* QUANTITY */

.quantity-box {
  display: flex;
  align-items: center;
  border: 1px solid #ddd;
  border-radius: 7px;
  overflow: hidden;
}

.quantity-box button {
  width: 35px;
  height: 35px;
  border: none;
  background: #f5f5f5;
  font-size: 20px;
  cursor: pointer;
}

.quantity-box button:hover:not(:disabled) {
  background: #e9e9e9;
}

.quantity-box button:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

.quantity-box input {
  width: 50px;
  height: 35px;
  border: none;
  border-left: 1px solid #ddd;
  border-right: 1px solid #ddd;
  text-align: center;
  outline: none;
}

/* TOTAL */

.item-total {
  width: 120px;
  text-align: right;
  font-size: 16px;
  font-weight: 700;
  color: #222;
}

/* REMOVE */

.remove-btn {
  border: none;
  background: transparent;
  color: #dc3545;
  font-size: 22px;
  cursor: pointer;
}

.remove-btn:hover:not(:disabled) {
  color: #b02a37;
}

.remove-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* SUMMARY */

.cart-summary {
  background: #fff;
  border-radius: 12px;
  padding: 25px;
  box-shadow:
    0 4px 15px rgba(0, 0, 0, 0.06);
  position: sticky;
  top: 20px;
}

.cart-summary h2 {
  margin: 0 0 25px;
  font-size: 20px;
  font-weight: 700;
  color: #222;
}

.summary-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 15px;
  color: #666;
}

.summary-row strong {
  color: #222;
}

.cart-summary hr {
  margin: 20px 0;
  border-color: #ddd;
}

.summary-total {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.summary-total span {
  font-size: 16px;
  font-weight: 700;
}

.summary-total strong {
  font-size: 21px;
  color: #e63946;
}

/* CHECKOUT */

.checkout-btn {
  width: 100%;
  border: none;
  border-radius: 8px;
  background: #111827;
  color: #fff;
  padding: 13px 15px;
  font-size: 14px;
  font-weight: 700;
  cursor: pointer;
  transition: 0.2s;
}

.checkout-btn:hover:not(:disabled) {
  background: #000;
}

.checkout-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.checkout-btn i {
  margin-right: 7px;
}

.continue-shopping {
  display: block;
  text-align: center;
  margin-top: 15px;
  color: #555;
  text-decoration: none;
  font-size: 14px;
}

.continue-shopping:hover {
  color: #111;
}

/* EMPTY CART */

.empty-cart {
  background: #fff;
  border-radius: 12px;
  text-align: center;
  padding: 70px 20px;
  box-shadow:
    0 4px 15px rgba(0, 0, 0, 0.06);
}

.empty-cart > i {
  font-size: 75px;
  color: #bbb;
}

.empty-cart h3 {
  margin-top: 20px;
  margin-bottom: 10px;
  font-size: 24px;
}

.empty-cart p {
  color: #777;
  margin-bottom: 25px;
}

.continue-btn {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  padding: 12px 22px;
  border-radius: 8px;
  background: #111827;
  color: #fff;
  text-decoration: none;
  font-weight: 600;
}

.continue-btn:hover {
  background: #000;
  color: #fff;
}

/* PAYMENT OVERLAY */

.payment-overlay {
  position: fixed;
  inset: 0;
  z-index: 9999;
  background: rgba(0, 0, 0, 0.65);

  display: flex;
  align-items: center;
  justify-content: center;

  padding: 20px;

  overflow-y: auto;
}

/* PAYMENT MODAL */

.payment-modal {
  position: relative;

  width: 100%;
  max-width: 500px;

  max-height: 95vh;

  overflow-y: auto;

  background: #fff;

  border-radius: 18px;

  padding: 30px;

  box-shadow:
    0 15px 50px rgba(0, 0, 0, 0.25);
}

/* CLOSE */

.close-payment {
  position: absolute;

  top: 15px;
  right: 15px;

  width: 38px;
  height: 38px;

  border: none;

  border-radius: 50%;

  background: #f1f1f1;

  color: #555;

  font-size: 24px;

  cursor: pointer;
}

.close-payment:hover {
  background: #e5e5e5;
}

/* PAYMENT HEADER */

.payment-header {
  text-align: center;

  margin-bottom: 20px;
}

.payment-header > i {
  font-size: 42px;

  color: #087f5b;
}

.payment-header h2 {
  margin: 8px 0;

  font-size: 21px;

  font-weight: 700;
}

.payment-header p {
  margin: 0;

  color: #777;

  font-size: 14px;
}

/* QR */

.qr-container {
  display: flex;

  justify-content: center;
  align-items: center;

  min-height: 290px;

  margin: 15px 0 20px;
}

.qr-image {
  display: block;

  width: 290px;

  max-width: 100%;

  height: auto;

  border-radius: 10px;
}

.qr-error {
  padding: 20px;

  color: #dc3545;

  font-size: 14px;

  text-align: center;
}

/* PAYMENT INFORMATION */

.payment-information {
  border: 1px solid #e5e5e5;

  border-radius: 10px;

  padding: 15px;

  background: #fafafa;
}

.payment-row {
  display: flex;

  align-items: center;

  justify-content: space-between;

  gap: 15px;

  padding: 8px 0;

  font-size: 14px;
}

.payment-row span {
  color: #777;
}

.payment-row strong {
  color: #222;

  text-align: right;
}

.payment-amount {
  color: #e63946 !important;

  font-size: 17px;
}

/* PAYMENT NOTE */

.payment-note {
  display: flex;

  gap: 10px;

  margin-top: 15px;

  padding: 13px;

  border-radius: 9px;

  background: #fff8e1;

  color: #665c3b;
}

.payment-note > i {
  font-size: 22px;

  flex-shrink: 0;
}

.payment-note strong {
  display: block;

  margin-bottom: 4px;
}

.payment-note p {
  margin: 2px 0;

  font-size: 13px;

  line-height: 1.5;
}

/* WAITING */

.payment-waiting {
  display: flex;

  align-items: center;

  justify-content: center;

  gap: 8px;

  margin: 18px 0;

  padding: 12px;

  border-radius: 8px;

  background: #eef6ff;

  color: #1769aa;

  font-size: 14px;

  font-weight: 600;
}

.payment-waiting i {
  font-size: 22px;
}

/* PAYMENT SUCCESS */

.payment-success {
  display: flex;

  align-items: center;

  justify-content: center;

  gap: 12px;

  margin: 18px 0;

  padding: 15px;

  border-radius: 8px;

  background: #e8f8ef;

  color: #198754;

  font-size: 14px;

  font-weight: 600;
}

.payment-success > i {
  font-size: 32px;

  flex-shrink: 0;
}

.payment-success strong {
  display: block;

  margin-bottom: 3px;

  font-size: 15px;
}

.payment-success p {
  margin: 0;

  font-size: 13px;

  font-weight: 400;
}

/* PAYMENT DONE BUTTON */

.payment-done-btn {
  width: 100%;

  border: none;

  border-radius: 8px;

  padding: 13px;

  background: #111827;

  color: #fff;

  font-size: 14px;

  font-weight: 700;

  cursor: pointer;
}

.payment-done-btn:hover {
  background: #000;
}

/* RESPONSIVE */

@media (max-width: 991px) {

  .cart-summary {
    position: static;
  }

}

@media (max-width: 768px) {

  .cart-item {
    flex-wrap: wrap;
  }

  .game-info {
    width: calc(100% - 130px);

    flex: none;
  }

  .quantity-box {
    margin-left: 128px;
  }

  .item-total {
    width: auto;

    margin-left: auto;
  }

  .remove-btn {
    margin-left: auto;
  }

}

@media (max-width: 576px) {

  .cart-header {
    flex-direction: column;

    align-items: flex-start;

    gap: 8px;
  }

  .cart-item {
    padding: 14px;

    gap: 12px;
  }

  .game-image {
    width: 90px;

    height: 65px;
  }

  .game-info {
    width: calc(100% - 105px);
  }

  .game-info h3 {
    font-size: 16px;
  }

  .quantity-box {
    margin-left: 0;
  }

  .item-total {
    margin-left: 0;

    width: auto;
  }

  .payment-modal {
    padding: 22px 16px;
  }

  .qr-image {
    width: 250px;
  }

  .payment-row {
    flex-direction: column;

    align-items: flex-start;

    gap: 2px;
  }

  .payment-row strong {
    text-align: left;
  }

}

</style>