<template>
    <div class="detail-page">

        <!-- HEADER -->
        <section class="detail-header">

            <div class="header-content">

                <router-link
                    to="/orders"
                    class="back-button"
                >
                    <i class="bx bx-left-arrow-alt"></i>
                    LỊCH SỬ ĐƠN HÀNG
                </router-link>

                <span class="header-label">
                    LOOTPLAY STORE
                </span>

                <h1>
                    CHI TIẾT ĐƠN HÀNG
                </h1>

                <p v-if="order">
                    {{ order.order_code }}
                </p>

            </div>

        </section>


        <!-- CONTENT -->
        <section class="detail-section">

            <!-- LOADING -->
            <div
                v-if="loading"
                class="loading"
            >
                Đang tải thông tin đơn hàng...
            </div>


            <!-- ERROR -->
            <div
                v-else-if="errorMessage"
                class="error-box"
            >
                {{ errorMessage }}

                <router-link
                    to="/orders"
                    class="back-error"
                >
                    Quay lại lịch sử đơn hàng
                </router-link>
            </div>


            <!-- DETAIL -->
            <div
                v-else-if="order"
                class="detail-container"
            >

                <!-- ORDER INFORMATION -->
                <div class="order-summary">

                    <div class="summary-item">

                        <span>
                            Mã đơn hàng
                        </span>

                        <strong>
                            {{ order.order_code }}
                        </strong>

                    </div>


                    <div class="summary-item">

                        <span>
                            Ngày đặt
                        </span>

                        <strong>
                            {{ formatDate(order.created_at) }}
                        </strong>

                    </div>


                    <div class="summary-item">

                        <span>
                            Trạng thái đơn
                        </span>

                        <strong
                            :class="[
                                'status',
                                getOrderStatusClass(order.status)
                            ]"
                        >
                            {{ getOrderStatus(order.status) }}
                        </strong>

                    </div>


                    <div class="summary-item">

                        <span>
                            Thanh toán
                        </span>

                        <strong
                            :class="[
                                'status',
                                getPaymentStatusClass()
                            ]"
                        >
                            {{ getPaymentStatus() }}
                        </strong>

                    </div>

                </div>


                <!-- PRODUCTS -->
                <div class="products-card">

                    <div class="card-header">

                        <h2>
                            Sản phẩm đã mua
                        </h2>

                        <span>
                            {{ getItemCount() }} sản phẩm
                        </span>

                    </div>


                    <div class="products-list">

                        <div
                            v-for="item in order.order_details"
                            :key="item.id"
                            class="product-item"
                        >

                            <!-- IMAGE -->
                            <div class="product-image">

                                <img
                                    :src="getGameImage(item.game)"
                                    :alt="item.game?.name"
                                >

                            </div>


                            <!-- INFO -->
                            <div class="product-info">

                                <h3>
                                    {{ item.game?.name || 'Game' }}
                                </h3>

                                <p>
                                    {{ item.game?.developer || 'LootPlay' }}
                                </p>

                                <span>
                                    Số lượng: {{ item.quantity }}
                                </span>

                            </div>


                            <!-- PRICE -->
                            <div class="product-price">

                                <span>
                                    Đơn giá
                                </span>

                                <strong>
                                    {{ formatPrice(item.price) }}
                                </strong>

                                <small>
                                    Thành tiền:
                                    {{
                                        formatPrice(
                                            Number(item.price) *
                                            Number(item.quantity)
                                        )
                                    }}
                                </small>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- PAYMENT -->
                <div
                    v-if="order.payment"
                    class="payment-card"
                >

                    <div class="card-header">

                        <h2>
                            Thông tin thanh toán
                        </h2>

                    </div>


                    <div class="payment-info">

                        <div>

                            <span>
                                Phương thức
                            </span>

                            <strong>
                                {{ order.payment.payment_method }}
                            </strong>

                        </div>


                        <div>

                            <span>
                                Mã giao dịch
                            </span>

                            <strong>
                                {{ order.payment.transaction_code || '---' }}
                            </strong>

                        </div>


                        <div>

                            <span>
                                Trạng thái
                            </span>

                            <strong
                                :class="[
                                    'status',
                                    getPaymentStatusClass()
                                ]"
                            >
                                {{ getPaymentStatus() }}
                            </strong>

                        </div>


                        <div v-if="order.payment.paid_at">

                            <span>
                                Thời gian thanh toán
                            </span>

                            <strong>
                                {{ formatDateTime(order.payment.paid_at) }}
                            </strong>

                        </div>

                    </div>

                </div>


                <!-- TOTAL -->
                <div class="total-card">

                    <div>

                        <span>
                            Tổng cộng
                        </span>

                        <strong>
                            {{ formatPrice(order.total_amount) }}
                        </strong>

                    </div>

                </div>


                <!-- ACTION -->
                <div class="bottom-action">

                    <router-link
                        to="/orders"
                        class="back-orders"
                    >
                        <i class="bx bx-left-arrow-alt"></i>
                        QUAY LẠI LỊCH SỬ
                    </router-link>

                </div>

            </div>

        </section>

    </div>
</template>


<script>

export default {

    name: 'OrderDetail',

    data() {

        return {

            order: null,

            loading: true,

            errorMessage: ''

        }

    },


    mounted() {

        this.getOrderDetail()

    },


    methods: {

        async getOrderDetail() {

            this.loading = true

            this.errorMessage = ''


            try {

                const orderId =
                    this.$route.params.id


                const response = await fetch(
                    `http://127.0.0.1:8000/api/orders/detail/${orderId}`,
                    {
                        method: 'GET',

                        headers: {
                            'Accept': 'application/json'
                        }
                    }
                )


                const data = await response.json()


                if (!response.ok) {

                    this.errorMessage =
                        data.message ||
                        'Không thể lấy thông tin đơn hàng'

                    return

                }


                this.order =
                    data.order || null


            }


            catch (error) {

                this.errorMessage =
                    'Không thể kết nối đến máy chủ'

            }


            finally {

                this.loading = false

            }

        },


        getGameImage(game) {

            if (
                game &&
                game.images &&
                game.images.length > 0
            ) {

                return game.images[0].image_url

            }


            return 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1000&q=85'

        },


        getItemCount() {

            if (
                !this.order ||
                !this.order.order_details
            ) {

                return 0

            }


            return this.order.order_details.reduce(
                (total, item) => {

                    return total +
                        Number(item.quantity || 0)

                },
                0
            )

        },


        getOrderStatus(status) {

            const statusMap = {

                pending: 'Chờ thanh toán',

                paid: 'Đã thanh toán',

                completed: 'Hoàn thành',

                cancelled: 'Đã hủy',

                canceled: 'Đã hủy'

            }

            return statusMap[status] || status

        },


        getOrderStatusClass(status) {

            if (
                status === 'paid' ||
                status === 'completed'
            ) {

                return 'success'

            }

            if (
                status === 'cancelled' ||
                status === 'canceled'
            ) {

                return 'danger'

            }

            return 'warning'

        },


        getPaymentStatus() {

            if (
                !this.order ||
                !this.order.payment
            ) {

                return 'Chưa thanh toán'

            }


            if (
                this.order.payment.status === 'paid'
            ) {

                return 'Đã thanh toán'

            }


            return 'Chờ thanh toán'

        },


        getPaymentStatusClass() {

            if (
                this.order &&
                this.order.payment &&
                this.order.payment.status === 'paid'
            ) {

                return 'success'

            }

            return 'warning'

        },


        formatPrice(price) {

            return new Intl.NumberFormat(
                'vi-VN'
            ).format(price) + 'đ'

        },


        formatDate(date) {

            if (!date) {
                return ''
            }

            return new Date(date).toLocaleDateString(
                'vi-VN',
                {
                    day: '2-digit',
                    month: '2-digit',
                    year: 'numeric'
                }
            )

        },


        formatDateTime(date) {

            if (!date) {
                return ''
            }

            return new Date(date).toLocaleString(
                'vi-VN',
                {
                    day: '2-digit',
                    month: '2-digit',
                    year: 'numeric',
                    hour: '2-digit',
                    minute: '2-digit'
                }
            )

        }

    }

}

</script>


<style scoped>

.detail-page {
    width: 100%;
    min-height: 100vh;

    color: #f8fafc;

    font-family:
        'Be Vietnam Pro',
        'Plus Jakarta Sans',
        sans-serif;
}


/* HEADER */

.detail-header {
    padding: 40px 24px 55px;

    background:
        linear-gradient(
            135deg,
            rgba(10, 15, 30, 0.98),
            rgba(18, 24, 50, 0.98)
        );

    border-bottom:
        1px solid rgba(59, 130, 246, 0.15);
}

.header-content {
    width: 1100px;
    max-width: calc(100% - 48px);

    margin: auto;
}

.back-button {
    display: inline-flex;

    align-items: center;

    gap: 5px;

    margin-bottom: 35px;

    color: #64748b;

    text-decoration: none;

    font-size: 12px;
    font-weight: 600;

    transition: color 0.2s ease;
}

.back-button:hover {
    color: #60a5fa;
}

.header-label {
    display: block;

    margin-bottom: 10px;

    color: #38bdf8;

    font-size: 11px;
    font-weight: 800;

    letter-spacing: 2px;
}

.header-content h1 {
    margin: 0 0 10px;

    color: #f8fafc;

    font-size: 42px;
    font-weight: 800;
}

.header-content p {
    margin: 0;

    color: #64748b;

    font-size: 14px;
}


/* SECTION */

.detail-section {
    width: 1100px;
    max-width: calc(100% - 48px);

    margin: auto;

    padding: 45px 0 80px;
}


/* SUMMARY */

.order-summary {
    display: grid;

    grid-template-columns:
        repeat(4, 1fr);

    gap: 15px;

    margin-bottom: 20px;
}

.summary-item {
    padding: 18px;

    background:
        rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.08);

    border-radius: 12px;
}

.summary-item span {
    display: block;

    margin-bottom: 7px;

    color: #64748b;

    font-size: 11px;
}

.summary-item strong {
    color: #e2e8f0;

    font-size: 13px;
}


/* CARDS */

.products-card,
.payment-card,
.total-card {
    margin-bottom: 18px;

    padding: 22px;

    background:
        rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.08);

    border-radius: 14px;
}

.card-header {
    display: flex;

    align-items: center;

    justify-content: space-between;

    padding-bottom: 17px;

    margin-bottom: 5px;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.07);
}

.card-header h2 {
    margin: 0;

    color: #f1f5f9;

    font-size: 18px;
}

.card-header span {
    color: #64748b;

    font-size: 12px;
}


/* PRODUCT */

.product-item {
    display: flex;

    align-items: center;

    gap: 18px;

    padding: 18px 0;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.06);
}

.product-item:last-child {
    border-bottom: none;
}

.product-image {
    width: 100px;
    height: 65px;

    flex-shrink: 0;

    overflow: hidden;

    border-radius: 8px;

    background: #0f172a;
}

.product-image img {
    width: 100%;
    height: 100%;

    object-fit: cover;
}

.product-info {
    flex: 1;
}

.product-info h3 {
    margin: 0 0 5px;

    color: #e2e8f0;

    font-size: 15px;
}

.product-info p {
    margin: 0 0 7px;

    color: #64748b;

    font-size: 11px;
}

.product-info span {
    color: #94a3b8;

    font-size: 11px;
}

.product-price {
    min-width: 150px;

    text-align: right;
}

.product-price span,
.product-price small {
    display: block;

    color: #64748b;

    font-size: 10px;
}

.product-price strong {
    display: block;

    margin: 3px 0;

    color: #38bdf8;

    font-size: 14px;
}


/* PAYMENT */

.payment-info {
    display: grid;

    grid-template-columns:
        repeat(2, 1fr);

    gap: 18px;

    padding-top: 15px;
}

.payment-info span {
    display: block;

    margin-bottom: 5px;

    color: #64748b;

    font-size: 11px;
}

.payment-info strong {
    color: #cbd5e1;

    font-size: 13px;
}


/* STATUS */

.status {
    display: inline-flex;

    padding: 5px 9px;

    border-radius: 6px;

    font-size: 11px !important;
}

.status.success {
    background:
        rgba(34, 197, 94, 0.1);

    color: #4ade80 !important;
}

.status.warning {
    background:
        rgba(234, 179, 8, 0.1);

    color: #facc15 !important;
}

.status.danger {
    background:
        rgba(239, 68, 68, 0.1);

    color: #f87171 !important;
}


/* TOTAL */

.total-card {
    display: flex;

    justify-content: flex-end;
}

.total-card > div {
    min-width: 230px;

    text-align: right;
}

.total-card span {
    display: block;

    margin-bottom: 5px;

    color: #64748b;

    font-size: 12px;
}

.total-card strong {
    color: #38bdf8;

    font-size: 25px;
}


/* BOTTOM */

.bottom-action {
    display: flex;

    justify-content: flex-start;
}

.back-orders,
.back-error {
    display: inline-flex;

    align-items: center;

    gap: 6px;

    padding: 10px 15px;

    border-radius: 8px;

    color: #60a5fa;

    background:
        rgba(59, 130, 246, 0.1);

    border:
        1px solid rgba(59, 130, 246, 0.2);

    text-decoration: none;

    font-size: 11px;
    font-weight: 700;
}

.back-orders:hover,
.back-error:hover {
    color: #fff;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #7c3aed
        );
}


/* LOADING */

.loading {
    padding: 80px;

    text-align: center;

    color: #38bdf8;
}


/* ERROR */

.error-box {
    display: flex;

    flex-direction: column;

    align-items: center;

    gap: 15px;

    padding: 60px;

    text-align: center;

    color: #f87171;

    background:
        rgba(239, 68, 68, 0.08);

    border:
        1px solid rgba(239, 68, 68, 0.2);

    border-radius: 14px;
}


/* RESPONSIVE */

@media (max-width: 900px) {

    .order-summary {
        grid-template-columns:
            repeat(2, 1fr);
    }

}

@media (max-width: 650px) {

    .header-content h1 {
        font-size: 30px;
    }

    .order-summary {
        grid-template-columns: 1fr;
    }

    .product-item {
        align-items: flex-start;

        flex-wrap: wrap;
    }

    .product-price {
        width: 100%;

        text-align: left;
    }

    .payment-info {
        grid-template-columns: 1fr;
    }

}

</style>