<template>
    <div class="game-detail-page">

        <!-- LOADING -->

        <div v-if="loading" class="loading">
            Đang tải thông tin game...
        </div>


        <!-- ERROR -->

        <div v-else-if="errorMessage" class="error-box">
            {{ errorMessage }}
        </div>


        <!-- GAME DETAIL -->

        <div v-else-if="game" class="detail-container">

            <!-- BREADCRUMB -->

            <div class="breadcrumb">

                <router-link to="/">
                    Trang chủ
                </router-link>

                <i class="bx bx-chevron-right"></i>

                <router-link to="/games">
                    Games
                </router-link>

                <i class="bx bx-chevron-right"></i>

                <span>
                    {{ game.name }}
                </span>

            </div>


            <!-- MAIN GAME -->

            <div class="game-main">

                <!-- IMAGE -->

                <div class="game-image-section">

                    <div class="game-image">

                        <img :src="getGameImage(game)" :alt="game.name">

                        <span class="category-badge">
                            {{ game.category?.name || 'GAME' }}
                        </span>

                    </div>

                </div>


                <!-- INFORMATION -->

                <div class="game-info-section">

                    <span class="game-label">
                        {{ game.category?.name || 'GAME' }}
                    </span>


                    <h1>
                        {{ game.name }}
                    </h1>


                    <div class="game-meta">

                        <span>
                            <i class="bx bx-calendar"></i>

                            {{ formatDate(game.release_date) }}
                        </span>

                        <span>
                            <i class="bx bx-code-alt"></i>

                            {{ game.developer || 'Đang cập nhật' }}
                        </span>

                        <span>
                            <i class="bx bx-show"></i>

                            {{ formatViews(game.views) }} lượt xem
                        </span>

                    </div>


                    <p class="short-description">
                        {{ game.description }}
                    </p>


                    <!-- PRICE -->

                    <div class="price-box">

                        <span class="price-label">
                            Giá bán
                        </span>

                        <strong>
                            {{ formatPrice(game.price) }}
                        </strong>

                    </div>


                    <!-- STOCK -->

                    <div class="stock-box">

                        <i class="bx bx-package"></i>

                        <span>
                            Còn {{ game.stock }} sản phẩm
                        </span>

                    </div>


                    <!-- ACTION -->

                    <div class="action-buttons">

                        <button class="cart-button" @click="addToCart" :disabled="addingToCart || game.stock <= 0">

                            <i v-if="addingToCart" class="bx bx-loader-alt bx-spin"></i>

                            <i v-else class="bx bx-cart"></i>

                            {{ addingToCart
                                ? 'ĐANG THÊM...'
                                : 'THÊM VÀO GIỎ HÀNG'
                            }}

                        </button>


                        <button class="buy-button" @click="buyNow">

                            MUA NGAY

                        </button>

                    </div>


                    <!-- MESSAGE -->

                    <div v-if="message" class="message" :class="{
                        'message-success': messageType === 'success',
                        'message-error': messageType === 'error'
                    }">
                        {{ message }}
                    </div>

                </div>

            </div>


            <!-- INTRODUCTION -->

            <section class="content-card">

                <div class="section-title">

                    <i class="bx bx-book-open"></i>

                    <h2>
                        Giới thiệu game
                    </h2>

                </div>


                <p class="content-text">
                    {{ game.description }}
                </p>


                <p class="content-text">

                    {{ game.name }} là một tựa game được phát hành
                    trên hệ thống LootPlay. Người chơi có thể
                    xem thông tin game, nhà phát triển, nhà phát hành,
                    ngày phát hành và tình trạng sản phẩm tại đây.

                </p>

            </section>


            <!-- GAME INFORMATION -->

            <section class="content-card">

                <div class="section-title">

                    <i class="bx bx-info-circle"></i>

                    <h2>
                        Thông tin game
                    </h2>

                </div>


                <div class="information-table">

                    <!-- TÊN GAME -->

                    <div class="information-row">

                        <span>
                            Tên game
                        </span>

                        <strong>
                            {{ game.name }}
                        </strong>

                    </div>


                    <!-- THỂ LOẠI -->

                    <div class="information-row">

                        <span>
                            Thể loại
                        </span>

                        <strong>
                            {{ game.category?.name || 'Đang cập nhật' }}
                        </strong>

                    </div>


                    <!-- DEVELOPER -->

                    <div class="information-row">

                        <span>
                            Developer
                        </span>

                        <strong>
                            {{ game.developer || 'Đang cập nhật' }}
                        </strong>

                    </div>


                    <!-- PUBLISHER -->

                    <div class="information-row">

                        <span>
                            Publisher
                        </span>

                        <strong>
                            {{ game.publisher || 'Đang cập nhật' }}
                        </strong>

                    </div>


                    <!-- NGÀY PHÁT HÀNH -->

                    <div class="information-row">

                        <span>
                            Ngày phát hành
                        </span>

                        <strong>
                            {{ formatDate(game.release_date) }}
                        </strong>

                    </div>


                    <!-- PHIÊN BẢN -->

                    <div class="information-row">

                        <span>
                            Phiên bản
                        </span>

                        <strong>
                            {{ game.version || 'Đang cập nhật' }}
                        </strong>

                    </div>


                    <!-- LƯỢT XEM -->

                    <div class="information-row">

                        <span>
                            Lượt xem
                        </span>

                        <strong>
                            {{ formatViews(game.views) }}
                        </strong>

                    </div>


                    <!-- TỒN KHO -->

                    <div class="information-row">

                        <span>
                            Số lượng còn lại
                        </span>

                        <strong>
                            {{ game.stock }}
                        </strong>

                    </div>


                    <!-- GIÁ -->

                    <div class="information-row">

                        <span>
                            Giá bán
                        </span>

                        <strong>
                            {{ formatPrice(game.price) }}
                        </strong>

                    </div>


                    <!-- TÌNH TRẠNG -->

                    <div class="information-row">

                        <span>
                            Tình trạng
                        </span>

                        <strong v-if="game.stock > 0" class="active-status">
                            Đang bán
                        </strong>

                        <strong v-else class="out-stock-status">
                            Hết hàng
                        </strong>

                    </div>

                </div>

            </section>


            <!-- CATEGORY -->

            <section class="content-card">

                <div class="section-title">

                    <i class="bx bx-category"></i>

                    <h2>
                        Thể loại
                    </h2>

                </div>


                <div class="category-list">

                    <span class="category-tag">

                        {{ game.category?.name || 'Game' }}

                    </span>

                </div>

            </section>


            <!-- BACK -->

            <div class="back-section">

                <router-link to="/games" class="back-button">

                    <i class="bx bx-left-arrow-alt"></i>

                    QUAY LẠI DANH SÁCH GAME

                </router-link>

            </div>

        </div>

    </div>
</template>


<script>

export default {

    name: 'GameDetail',


    data() {

        return {

            game: null,

            loading: true,

            errorMessage: '',

            message: '',

            messageType: '',

            addingToCart: false

        }

    },


    mounted() {

        this.getGame()

    },


    methods: {

        /* =========================
           GET GAME
        ========================= */

        async getGame() {

            this.loading = true

            this.errorMessage = ''


            const id = this.$route.params.id


            try {

                const response = await fetch(

                    `http://127.0.0.1:8000/api/games/${id}`,

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
                        'Không tìm thấy game'

                    return

                }


                this.game = data.game

            }


            catch (error) {

                console.error(error)

                this.errorMessage =
                    'Không thể kết nối đến máy chủ'

            }


            finally {

                this.loading = false

            }

        },


        /* =========================
           GET GAME IMAGE
        ========================= */

        getGameImage(game) {

            if (

                game.images &&

                game.images.length > 0

            ) {

                const primaryImage =

                    game.images.find(

                        image => image.is_primary == 1

                    )


                if (primaryImage) {

                    return primaryImage.image_url

                }


                return game.images[0].image_url

            }


            return 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1200&q=85'

        },


        /* =========================
           FORMAT PRICE
        ========================= */

        formatPrice(price) {

            return new Intl.NumberFormat(

                'vi-VN'

            ).format(price) + 'đ'

        },


        /* =========================
           FORMAT DATE
        ========================= */

        formatDate(date) {

            if (!date) {

                return 'Đang cập nhật'

            }


            const parts = date.split('-')


            if (parts.length !== 3) {

                return date

            }


            return `${parts[2]}/${parts[1]}/${parts[0]}`

        },


        /* =========================
           FORMAT VIEWS
        ========================= */

        formatViews(views) {

            if (

                views === null ||

                views === undefined

            ) {

                return '0'

            }


            return new Intl.NumberFormat(

                'vi-VN'

            ).format(views)

        },


        /* =========================
           ADD TO CART
        ========================= */

        async addToCart() {

            this.message = ''

            this.messageType = ''


            if (!this.game) {

                return

            }


            if (this.game.stock <= 0) {

                this.message =
                    'Game hiện đã hết hàng.'

                this.messageType = 'error'

                return

            }


            const savedUser =
                localStorage.getItem('user')


            if (!savedUser) {

                this.message =
                    'Vui lòng đăng nhập trước khi thêm game vào giỏ hàng.'

                this.messageType = 'error'

                return

            }


            let user

            try {

                user = JSON.parse(savedUser)

            }

            catch (error) {

                localStorage.removeItem('user')

                this.message =
                    'Phiên đăng nhập không hợp lệ. Vui lòng đăng nhập lại.'

                this.messageType = 'error'

                return

            }


            if (!user || !user.id) {

                this.message =
                    'Không tìm thấy thông tin tài khoản. Vui lòng đăng nhập lại.'

                this.messageType = 'error'

                return

            }


            this.addingToCart = true


            try {

                const response = await fetch(

                    'http://127.0.0.1:8000/api/cart/add',

                    {

                        method: 'POST',

                        headers: {

                            'Content-Type':
                                'application/json',

                            'Accept':
                                'application/json'

                        },

                        body: JSON.stringify({

                            user_id: user.id,

                            game_id: this.game.id,

                            quantity: 1

                        })

                    }

                )


                const data =
                    await response.json()


                if (!response.ok) {

                    this.message =
                        data.message ||
                        'Không thể thêm game vào giỏ hàng'

                    this.messageType = 'error'

                    return

                }


                this.message =
                    'Đã thêm game vào giỏ hàng thành công.'

                this.messageType = 'success'

            }


            catch (error) {

                console.error(error)

                this.message =
                    'Không thể kết nối đến máy chủ.'

                this.messageType = 'error'

            }


            finally {

                this.addingToCart = false

            }

        },


        /* =========================
           BUY NOW
        ========================= */

        buyNow() {

            this.message =
                'Tính năng mua game sẽ được phát triển ở bước tiếp theo.'

            this.messageType = 'success'

        }

    }

}

</script>


<style scoped>

/* ========================= PAGE ========================= */
.game-detail-page {
  min-height: 100vh;
  background: transparent;
  padding-bottom: 60px;
  font-family: var(--font-main, 'Plus Jakarta Sans', sans-serif);
  color: #f8fafc;
}

.detail-container {
  width: 1240px;
  max-width: calc(100% - 48px);
  margin: 0 auto;
}

/* ========================= BREADCRUMB ========================= */
.breadcrumb {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 7px;
  padding: 22px 0;
  font-size: 12px;
}

.breadcrumb a {
  color: #3b82f6;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
}

.breadcrumb a:hover {
  color: #60a5fa;
  text-decoration: underline;
}

.breadcrumb i {
  font-size: 15px;
  color: #334155;
}

.breadcrumb span {
  color: #475569;
}

/* ========================= MAIN GAME ========================= */
.game-main {
  display: grid;
  grid-template-columns: 1.1fr 1fr;
  gap: 28px;
  padding: 22px;
  background: rgba(17, 24, 39, 0.75);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 18px;
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(12px);
}

/* ========================= IMAGE ========================= */
.game-image {
  position: relative;
  width: 100%;
  min-height: 380px;
  overflow: hidden;
  border-radius: 12px;
  background: #0f172a;
}

.game-image img {
  width: 100%;
  height: 100%;
  min-height: 380px;
  display: block;
  object-fit: cover;
}

.category-badge {
  position: absolute;
  left: 14px;
  top: 14px;
  padding: 6px 12px;
  border-radius: 6px;
  background: linear-gradient(135deg, #2563eb, #38bdf8);
  color: #fff;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: 0.6px;
  box-shadow: 0 3px 10px rgba(37, 99, 235, 0.45);
}

/* ========================= GAME INFO SECTION ========================= */
.game-info-section {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.game-label {
  display: inline-block;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: 2px;
  color: #38bdf8;
  text-transform: uppercase;
  margin-bottom: 8px;
}

.game-info-section h1 {
  margin: 0 0 14px;
  color: #f1f5f9;
  font-family: 'Rajdhani', 'Plus Jakarta Sans', sans-serif;
  font-size: 32px;
  font-weight: 800;
  line-height: 1.2;
}

/* ========================= META ========================= */
.game-meta {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 14px;
  margin-bottom: 18px;
}

.game-meta span {
  display: flex;
  align-items: center;
  gap: 5px;
  color: #64748b;
  font-size: 12px;
  font-weight: 500;
}

.game-meta i {
  color: #3b82f6;
  font-size: 15px;
}

/* ========================= DESCRIPTION ========================= */
.short-description {
  margin: 0 0 18px;
  color: #64748b;
  font-size: 14px;
  line-height: 1.8;
  padding: 16px;
  background: rgba(30, 41, 59, 0.5);
  border-radius: 10px;
  border-left: 3px solid #3b82f6;
}

/* ========================= PRICE ========================= */
.price-box {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 18px;
  background: rgba(37, 99, 235, 0.07);
  border: 1px solid rgba(37, 99, 235, 0.2);
  border-radius: 12px;
  margin-bottom: 14px;
}

.price-label {
  color: #64748b;
  font-size: 13px;
  font-weight: 500;
}

.price-box strong {
  font-size: 28px;
  font-weight: 800;
  background: linear-gradient(135deg, #38bdf8, #a78bfa);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* ========================= STOCK ========================= */
.stock-box {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 18px;
  font-size: 13px;
  color: #64748b;
}

.stock-box i {
  color: #22c55e;
  font-size: 18px;
}

/* ========================= BUTTONS ========================= */
.action-buttons {
  display: flex;
  gap: 10px;
  margin-top: 4px;
}

.action-buttons button {
  min-height: 46px;
  padding: 0 20px;
  border-radius: 10px;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: all 0.25s ease;
  display: flex;
  align-items: center;
  gap: 7px;
  font-family: var(--font-main, sans-serif);
}

.cart-button {
  flex: 1;
  background: linear-gradient(135deg, #2563eb, #38bdf8);
  border: 1px solid transparent;
  color: #fff;
  box-shadow: 0 6px 18px rgba(37, 99, 235, 0.35);
}

.cart-button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 10px 24px rgba(37, 99, 235, 0.5);
}

.cart-button:disabled {
  background: rgba(37, 99, 235, 0.25);
  border-color: rgba(37, 99, 235, 0.1);
  color: rgba(255, 255, 255, 0.4);
  cursor: not-allowed;
  box-shadow: none;
}

.buy-button {
  padding: 0 22px !important;
  background: linear-gradient(135deg, #7c3aed, #a78bfa);
  border: 1px solid transparent;
  color: #fff;
  box-shadow: 0 6px 18px rgba(124, 58, 237, 0.35);
}

.buy-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 24px rgba(124, 58, 237, 0.5);
}

/* ========================= MESSAGE ========================= */
.message {
  margin-top: 14px;
  padding: 11px 14px;
  border-radius: 10px;
  font-size: 13px;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 7px;
}

.message-success {
  background: rgba(34, 197, 94, 0.1);
  border: 1px solid rgba(34, 197, 94, 0.25);
  color: #4ade80;
}

.message-error {
  background: rgba(239, 68, 68, 0.1);
  border: 1px solid rgba(239, 68, 68, 0.25);
  color: #f87171;
}

/* ========================= CONTENT CARD ========================= */
.content-card {
  margin-top: 20px;
  padding: 26px;
  background: rgba(17, 24, 39, 0.7);
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 16px;
  backdrop-filter: blur(10px);
}

.section-title {
  display: flex;
  align-items: center;
  gap: 10px;
  padding-bottom: 14px;
  margin-bottom: 18px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.section-title i {
  color: #38bdf8;
  font-size: 22px;
}

.section-title h2 {
  margin: 0;
  color: #f1f5f9;
  font-size: 18px;
  font-weight: 700;
}

.content-text {
  margin: 0 0 14px;
  color: #64748b;
  font-size: 14px;
  line-height: 1.85;
}

.content-text:last-child { margin-bottom: 0; }

/* ========================= INFORMATION TABLE ========================= */
.information-table {
  border: 1px solid rgba(255, 255, 255, 0.07);
  border-radius: 12px;
  overflow: hidden;
}

.information-row {
  display: grid;
  grid-template-columns: 200px 1fr;
  min-height: 48px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.06);
  transition: background 0.15s ease;
}

.information-row:last-child { border-bottom: none; }
.information-row:hover { background: rgba(30, 41, 59, 0.4); }

.information-row span {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  background: rgba(15, 23, 42, 0.5);
  color: #64748b;
  font-size: 13px;
  font-weight: 500;
  border-right: 1px solid rgba(255, 255, 255, 0.06);
}

.information-row strong {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  color: #e2e8f0;
  font-size: 13px;
  font-weight: 600;
}

.active-status {
  color: #4ade80 !important;
}

.out-stock-status {
  color: #f87171 !important;
}

/* ========================= CATEGORY ========================= */
.category-list {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.category-tag {
  padding: 7px 14px;
  border-radius: 8px;
  background: rgba(59, 130, 246, 0.1);
  border: 1px solid rgba(59, 130, 246, 0.25);
  color: #60a5fa;
  font-size: 12px;
  font-weight: 700;
}

/* ========================= BACK ========================= */
.back-section {
  display: flex;
  justify-content: center;
  margin-top: 28px;
}

.back-button {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  color: #94a3b8;
  font-size: 12px;
  font-weight: 700;
  text-decoration: none;
  transition: all 0.2s ease;
  letter-spacing: 0.4px;
}

.back-button:hover {
  background: rgba(59, 130, 246, 0.1);
  border-color: rgba(59, 130, 246, 0.3);
  color: #60a5fa;
  transform: translateX(-3px);
}

/* ========================= LOADING ========================= */
.loading {
  padding: 100px 20px;
  text-align: center;
  color: #38bdf8;
  font-size: 15px;
  font-weight: 500;
}

/* ========================= ERROR ========================= */
.error-box {
  width: 1240px;
  max-width: calc(100% - 48px);
  margin: 50px auto;
  padding: 24px;
  border-radius: 14px;
  background: rgba(239, 68, 68, 0.08);
  border: 1px solid rgba(239, 68, 68, 0.25);
  color: #f87171;
  text-align: center;
  font-size: 14px;
}

/* ========================= RESPONSIVE ========================= */
@media (max-width: 900px) {
  .game-main { grid-template-columns: 1fr; }
  .game-image { min-height: 300px; }
  .game-image img { min-height: 300px; }
}

@media (max-width: 600px) {
  .game-main { padding: 16px; }
  .content-card { padding: 18px; }
  .game-info-section h1 { font-size: 24px; }
  .action-buttons { flex-direction: column; }
  .information-row { grid-template-columns: 1fr; }
  .information-row span { border-right: none; border-bottom: 1px solid rgba(255, 255, 255, 0.06); }
}

</style>
