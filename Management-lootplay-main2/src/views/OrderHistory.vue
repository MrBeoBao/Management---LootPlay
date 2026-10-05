<template>
    <div class="orders-page">

        <!-- HEADER -->
        <section class="orders-header">

            <div class="header-content">

                <span class="header-label">
                    LOOTPLAY STORE
                </span>

                <h1>
                    LỊCH SỬ ĐƠN HÀNG
                </h1>

                <p>
                    Theo dõi các đơn hàng bạn đã mua tại LootPlay.
                </p>

            </div>

        </section>


        <!-- CONTENT -->
        <section class="orders-section">

            <!-- LOADING -->
            <div
                v-if="loading"
                class="loading"
            >
                Đang tải lịch sử đơn hàng...
            </div>


            <!-- ERROR -->
            <div
                v-else-if="errorMessage"
                class="error-box"
            >
                {{ errorMessage }}
            </div>


            <!-- NOT LOGIN -->
            <div
                v-else-if="!user"
                class="empty-box"
            >
                <i class="bx bx-user-x"></i>

                <h3>
                    Bạn chưa đăng nhập
                </h3>

                <p>
                    Vui lòng đăng nhập để xem lịch sử đơn hàng.
                </p>

                <router-link
                    to="/login"
                    class="action-button"
                >
                    ĐĂNG NHẬP
                </router-link>
            </div>


            <!-- EMPTY -->
            <div
                v-else-if="orders.length === 0"
                class="empty-box"
            >
                <i class="bx bx-receipt"></i>

                <h3>
                    Chưa có đơn hàng
                </h3>

                <p>
                    Bạn chưa có đơn hàng nào tại LootPlay.
                </p>

                <router-link
                    to="/games"
                    class="action-button"
                >
                    KHÁM PHÁ GAME
                </router-link>
            </div>


            <!-- ORDERS -->
            <div
                v-else
                class="orders-container"
            >

                <div class="orders-title">

                    <div>
                        <h2>
                            Đơn hàng của bạn
                        </h2>

                        <p>
                            {{ orders.length }} đơn hàng
                        </p>
                    </div>

                </div>


                <div class="orders-list">

                    <div
                        v-for="order in orders"
                        :key="order.id"
                        class="order-card"
                    >

                        <!-- ORDER TOP -->
                        <div class="order-top">

                            <div>

                                <span class="label">
                                    MÃ ĐƠN HÀNG
                                </span>

                                <strong>
                                    {{ order.order_code }}
                                </strong>

                            </div>


                            <div class="order-date">

                                <span class="label">
                                    NGÀY ĐẶT
                                </span>

                                <strong>
                                    {{ formatDate(order.created_at) }}
                                </strong>

                            </div>

                        </div>


                        <!-- ORDER INFO -->
                        <div class="order-info">

                            <div class="info-item">

                                <span>
                                    Tổng tiền
                                </span>

                                <strong class="price">
                                    {{ formatPrice(order.total_amount) }}
                                </strong>

                            </div>


                            <div class="info-item">

                                <span>
                                    Đơn hàng
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


                            <div class="info-item">

                                <span>
                                    Thanh toán
                                </span>

                                <strong
                                    :class="[
                                        'status',
                                        getPaymentStatusClass(order)
                                    ]"
                                >
                                    {{ getPaymentStatus(order) }}
                                </strong>

                            </div>

                        </div>


                        <!-- ORDER BOTTOM -->
                        <div class="order-bottom">

                            <span>
                                {{ getItemCount(order) }} sản phẩm
                            </span>


                            <router-link
                                :to="`/orders/${order.id}`"
                                class="detail-button"
                            >
                                XEM CHI TIẾT

                                <i class="bx bx-right-arrow-alt"></i>
                            </router-link>

                        </div>

                    </div>

                </div>

            </div>

        </section>

    </div>
</template>


<script>

export default {

    name: 'OrderHistory',

    data() {

        return {

            user: null,

            orders: [],

            loading: true,

            errorMessage: ''

        }

    },


    mounted() {

        this.loadUser()

    },


    methods: {

        loadUser() {

            try {

                const userData =
                    localStorage.getItem('user')

                if (!userData) {

                    this.user = null
                    this.loading = false

                    return

                }

                this.user = JSON.parse(userData)

                this.getOrders()

            }

            catch (error) {

                this.user = null
                this.loading = false

                this.errorMessage =
                    'Thông tin đăng nhập không hợp lệ'

            }

        },


        async getOrders() {

            this.loading = true
            this.errorMessage = ''


            try {

                const response = await fetch(
                    `http://127.0.0.1:8000/api/orders/${this.user.id}`,
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
                        'Không thể lấy lịch sử đơn hàng'

                    return

                }


                this.orders =
                    data.orders || []

            }


            catch (error) {

                this.errorMessage =
                    'Không thể kết nối đến máy chủ'

            }


            finally {

                this.loading = false

            }

        },


        getItemCount(order) {

            if (
                !order.order_details ||
                !Array.isArray(order.order_details)
            ) {

                return 0

            }

            return order.order_details.reduce(
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

            if (status === 'paid' || status === 'completed') {

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


        getPaymentStatus(order) {

            if (!order.payment) {

                return 'Chưa thanh toán'

            }

            if (order.payment.status === 'paid') {

                return 'Đã thanh toán'

            }

            return 'Chờ thanh toán'

        },


        getPaymentStatusClass(order) {

            if (
                order.payment &&
                order.payment.status === 'paid'
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

        }

    }

}

</script>


<style scoped>

.orders-page {
    width: 100%;
    min-height: 100vh;
    color: #f8fafc;
    font-family:
        'Be Vietnam Pro',
        'Plus Jakarta Sans',
        sans-serif;
}


/* HEADER */

.orders-header {
    padding: 60px 24px 64px;

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
    width: 1240px;
    max-width: calc(100% - 48px);
    margin: auto;
}

.header-label {
    display: inline-block;

    margin-bottom: 12px;

    color: #38bdf8;

    font-size: 11px;
    font-weight: 800;

    letter-spacing: 2px;
}

.header-content h1 {
    margin: 0 0 12px;

    color: #f8fafc;

    font-size: 44px;
    font-weight: 800;
}

.header-content p {
    margin: 0;

    color: #94a3b8;

    font-size: 15px;
}


/* SECTION */

.orders-section {
    width: 1100px;
    max-width: calc(100% - 48px);

    margin: auto;

    padding: 50px 0 80px;
}


/* TITLE */

.orders-title {
    margin-bottom: 24px;

    padding-bottom: 18px;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.07);
}

.orders-title h2 {
    margin: 0 0 5px;

    color: #f1f5f9;

    font-size: 22px;
}

.orders-title p {
    margin: 0;

    color: #64748b;

    font-size: 13px;
}


/* ORDER */

.orders-list {
    display: flex;

    flex-direction: column;

    gap: 16px;
}

.order-card {
    padding: 22px;

    background:
        rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.08);

    border-radius: 15px;

    transition: all 0.25s ease;
}

.order-card:hover {
    border-color:
        rgba(59, 130, 246, 0.3);

    transform: translateY(-2px);
}


/* TOP */

.order-top {
    display: flex;

    justify-content: space-between;

    gap: 20px;

    padding-bottom: 18px;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.07);
}

.label {
    display: block;

    margin-bottom: 5px;

    color: #475569;

    font-size: 10px;
    font-weight: 700;

    letter-spacing: 0.7px;
}

.order-top strong {
    color: #e2e8f0;

    font-size: 14px;
}

.order-date {
    text-align: right;
}


/* INFO */

.order-info {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 20px;

    padding: 20px 0;
}

.info-item span {
    display: block;

    margin-bottom: 6px;

    color: #64748b;

    font-size: 12px;
}

.info-item strong {
    font-size: 14px;
}

.price {
    color: #38bdf8;
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

    color: #4ade80;
}

.status.warning {
    background:
        rgba(234, 179, 8, 0.1);

    color: #facc15;
}

.status.danger {
    background:
        rgba(239, 68, 68, 0.1);

    color: #f87171;
}


/* BOTTOM */

.order-bottom {
    display: flex;

    align-items: center;

    justify-content: space-between;

    padding-top: 16px;

    border-top:
        1px solid rgba(255, 255, 255, 0.07);

    color: #64748b;

    font-size: 12px;
}

.detail-button,
.action-button {
    display: inline-flex;

    align-items: center;

    gap: 5px;

    padding: 9px 14px;

    border-radius: 8px;

    background:
        rgba(59, 130, 246, 0.1);

    border:
        1px solid rgba(59, 130, 246, 0.25);

    color: #60a5fa;

    text-decoration: none;

    font-size: 11px;
    font-weight: 700;

    transition: all 0.2s ease;
}

.detail-button:hover,
.action-button:hover {
    background:
        linear-gradient(
            135deg,
            #2563eb,
            #7c3aed
        );

    color: #fff;

    border-color: transparent;
}


/* EMPTY */

.empty-box {
    padding: 80px 20px;

    display: flex;

    flex-direction: column;

    align-items: center;

    text-align: center;

    background:
        rgba(17, 24, 39, 0.5);

    border:
        1px dashed rgba(255, 255, 255, 0.1);

    border-radius: 16px;
}

.empty-box i {
    margin-bottom: 15px;

    color: #475569;

    font-size: 48px;
}

.empty-box h3 {
    margin: 0 0 8px;

    color: #94a3b8;
}

.empty-box p {
    margin: 0 0 20px;

    color: #475569;

    font-size: 13px;
}


/* LOADING */

.loading {
    padding: 80px;

    text-align: center;

    color: #38bdf8;
}


/* ERROR */

.error-box {
    padding: 24px;

    border-radius: 12px;

    text-align: center;

    color: #f87171;

    background:
        rgba(239, 68, 68, 0.08);

    border:
        1px solid rgba(239, 68, 68, 0.2);
}


/* RESPONSIVE */

@media (max-width: 700px) {

    .header-content h1 {
        font-size: 32px;
    }

    .order-top {
        flex-direction: column;
    }

    .order-date {
        text-align: left;
    }

    .order-info {
        grid-template-columns: 1fr;
    }

    .order-bottom {
        flex-direction: column;

        align-items: flex-start;

        gap: 12px;
    }

}

</style>