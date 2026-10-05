<template>
  <div class="home-page">

    <!-- ===================== HERO ===================== -->
    <section class="hero-section">
      <div class="hero-overlay"></div>
      <div class="hero-grid"></div>

      <div class="hero-content">

        <div class="hero-text">

          <div class="hero-badge">
            <span class="badge-dot"></span>
            WELCOME TO LOOTPLAY
          </div>

          <h1>
            KHÁM PHÁ
            <br>
            <span class="gradient-text">THẾ GIỚI GAME</span>
          </h1>

          <p>
            Tìm kiếm, khám phá và sở hữu những tựa game yêu thích
            tại LootPlay. Mua game nhanh chóng và trải nghiệm ngay.
          </p>

          <div class="hero-buttons">

            <router-link to="/games" class="btn-primary">
              <i class="bx bx-joystick"></i>
              KHÁM PHÁ GAME
            </router-link>

            <router-link to="/register" class="btn-secondary">
              <i class="bx bx-user-plus"></i>
              TẠO TÀI KHOẢN
            </router-link>

          </div>

        </div>

        <div class="hero-decoration hero-decoration-one"></div>
        <div class="hero-decoration hero-decoration-two"></div>

      </div>
    </section>


    <!-- ===================== QUICK STATS ===================== -->
    <section class="stats-section">

      <div class="stats-container">

        <div class="stat-card">

          <div class="stat-icon blue">
            <i class="bx bx-game"></i>
          </div>

          <div>
            <strong>{{ games.length }}+</strong>
            <span>Game đang bán</span>
          </div>

        </div>


        <div class="stat-card">

          <div class="stat-icon purple">
            <i class="bx bx-category"></i>
          </div>

          <div>
            <strong>{{ categories.length }}</strong>
            <span>Thể loại game</span>
          </div>

        </div>


        <div class="stat-card">

          <div class="stat-icon cyan">
            <i class="bx bx-cart"></i>
          </div>

          <div>
            <strong>24/7</strong>
            <span>Hỗ trợ khách hàng</span>
          </div>

        </div>


        <div class="stat-card">

          <div class="stat-icon orange">
            <i class="bx bx-shield-check"></i>
          </div>

          <div>
            <strong>100%</strong>
            <span>Game bản quyền</span>
          </div>

        </div>

      </div>

    </section>


    <!-- ===================== CATEGORIES ===================== -->
    <section class="section">

      <div class="section-header">

        <div>

          <div class="section-label">
            <i class="bx bx-category"></i>
            GAME CATEGORY
          </div>

          <h2>Khám phá theo thể loại</h2>

        </div>

        <router-link to="/games" class="see-all">
          XEM TẤT CẢ
          <i class="bx bx-right-arrow-alt"></i>
        </router-link>

      </div>


      <div
        v-if="categories.length"
        class="category-grid"
      >

        <div
          v-for="(category, index) in categories"
          :key="category.id"
          class="category-card"
          @click="goToCategory(category.id)"
        >

          <div
            class="category-icon"
            :class="getCategoryColor(index)"
          >
            <i :class="getCategoryIcon(index)"></i>
          </div>

          <div class="category-info">

            <h3>
              {{ category.name }}
            </h3>

            <p>
              {{ category.description || 'Khám phá game thuộc thể loại này' }}
            </p>

          </div>

          <i class="bx bx-chevron-right category-arrow"></i>

        </div>

      </div>


      <div
        v-else-if="loading"
        class="empty-message"
      >
        Đang tải thể loại game...
      </div>


      <div
        v-else
        class="empty-message"
      >
        Chưa có thể loại game.
      </div>

    </section>


    <!-- ===================== FEATURED GAMES ===================== -->
    <section class="section games-section">

      <div class="section-header">

        <div>

          <div class="section-label">
            <i class="bx bx-star"></i>
            LOOTPLAY STORE
          </div>

          <h2>Game nổi bật</h2>

        </div>

        <router-link to="/games" class="see-all">
          XEM TẤT CẢ
          <i class="bx bx-right-arrow-alt"></i>
        </router-link>

      </div>


      <div
        v-if="loading"
        class="loading-box"
      >
        <i class="bx bx-loader-alt bx-spin"></i>
        Đang tải game...
      </div>


      <div
        v-else-if="error"
        class="error-box"
      >
        <i class="bx bx-error-circle"></i>
        {{ error }}
      </div>


      <div
        v-else-if="featuredGames.length"
        class="games-grid"
      >

        <div
          v-for="game in featuredGames"
          :key="game.id"
          class="game-card"
        >

          <!-- IMAGE -->
          <div class="game-image">

            <img
              v-if="getGameImage(game)"
              :src="getGameImage(game)"
              :alt="game.name"
              @error="handleImageError"
            >

            <div
              v-else
              class="no-image"
            >
              <i class="bx bx-game"></i>
              <span>NO IMAGE</span>
            </div>


            <span class="game-tag">
              {{ getCategoryName(game) }}
            </span>


            <div class="game-overlay">

              <button
                class="quick-view-btn"
                @click="viewGame(game.id)"
              >
                <i class="bx bx-show"></i>
                XEM GAME
              </button>

            </div>

          </div>


          <!-- CONTENT -->
          <div class="game-content">

            <div class="game-header">

              <h3>
                {{ game.name }}
              </h3>

              <span class="game-stock">
                <i class="bx bx-package"></i>
                {{ game.stock }}
              </span>

            </div>


            <p>
              {{ getShortDescription(game.description) }}
            </p>


            <div class="game-footer">

              <strong class="price">
                {{ formatPrice(game.price) }}
              </strong>

              <button
                class="view-button"
                @click="viewGame(game.id)"
              >
                XEM GAME
              </button>

            </div>

          </div>

        </div>

      </div>


      <div
        v-else
        class="empty-message"
      >
        Chưa có game đang bán.
      </div>

    </section>


    <!-- ===================== NEW GAMES ===================== -->
    <section class="new-games-section">

      <div class="section">

        <div class="section-header">

          <div>

            <div class="section-label">
              <i class="bx bx-time-five"></i>
              MỚI NHẤT
            </div>

            <h2>Game mới cập nhật</h2>

          </div>

          <router-link to="/games" class="see-all">
            XEM TẤT CẢ
            <i class="bx bx-right-arrow-alt"></i>
          </router-link>

        </div>


        <div
          v-if="newGames.length"
          class="new-games-grid"
        >

          <div
            v-for="game in newGames"
            :key="game.id"
            class="new-game-card"
            @click="viewGame(game.id)"
          >

            <div class="new-game-image">

              <img
                v-if="getGameImage(game)"
                :src="getGameImage(game)"
                :alt="game.name"
                @error="handleImageError"
              >

              <div
                v-else
                class="no-image"
              >
                <i class="bx bx-game"></i>
              </div>

            </div>


            <div class="new-game-info">

              <span class="new-game-category">
                {{ getCategoryName(game) }}
              </span>

              <h3>
                {{ game.name }}
              </h3>

              <strong>
                {{ formatPrice(game.price) }}
              </strong>

            </div>


            <i class="bx bx-right-arrow-alt new-game-arrow"></i>

          </div>

        </div>


        <div
          v-else
          class="empty-message"
        >
          Chưa có game mới.
        </div>

      </div>

    </section>


    <!-- ===================== WHY LOOTPLAY ===================== -->
    <section class="why-section">

      <div class="section">

        <div class="section-header center">

          <div>

            <div class="section-label center-label">
              <i class="bx bx-shield-quarter"></i>
              WHY LOOTPLAY
            </div>

            <h2>Tại sao chọn LootPlay?</h2>

          </div>

        </div>


        <div class="features-grid">

          <div class="feature-card">

            <div class="feature-icon blue">
              <i class="bx bx-search-alt"></i>
            </div>

            <h3>Dễ dàng tìm game</h3>

            <p>
              Tìm kiếm và khám phá những tựa game phù hợp
              với sở thích của bạn.
            </p>

          </div>


          <div class="feature-card">

            <div class="feature-icon purple">
              <i class="bx bx-cart"></i>
            </div>

            <h3>Mua game nhanh chóng</h3>

            <p>
              Thêm game vào giỏ hàng và thực hiện thanh toán
              một cách đơn giản.
            </p>

          </div>


          <div class="feature-card">

            <div class="feature-icon cyan">
              <i class="bx bx-lock-alt"></i>
            </div>

            <h3>Thanh toán an toàn</h3>

            <p>
              Thông tin đơn hàng và thanh toán được quản lý
              an toàn.
            </p>

          </div>


          <div class="feature-card">

            <div class="feature-icon orange">
              <i class="bx bx-star"></i>
            </div>

            <h3>Đánh giá game</h3>

            <p>
              Xem và chia sẻ đánh giá để lựa chọn game
              phù hợp hơn.
            </p>

          </div>

        </div>

      </div>

    </section>


    <!-- ===================== CTA ===================== -->
    <section class="cta-section">

      <div class="cta-glow left"></div>
      <div class="cta-glow right"></div>

      <div class="cta-content">

        <div class="section-label center-label">
          <i class="bx bx-game"></i>
          READY TO PLAY?
        </div>

        <h2>
          Tìm tựa game tiếp theo của bạn
        </h2>

        <p>
          Khám phá kho game tại LootPlay và bắt đầu
          hành trình gaming của bạn.
        </p>


        <div class="cta-buttons">

          <router-link
            to="/games"
            class="cta-primary"
          >
            <i class="bx bx-joystick"></i>
            KHÁM PHÁ GAME
          </router-link>

          <router-link
            to="/register"
            class="cta-secondary"
          >
            <i class="bx bx-user-plus"></i>
            ĐĂNG KÝ
          </router-link>

        </div>

      </div>

    </section>

  </div>
</template>


<script>
import axios from 'axios'

export default {

  name: 'Home',

  data() {
    return {

      games: [],

      categories: [],

      loading: true,

      error: ''

    }
  },


  computed: {

    /*
     * Lấy tối đa 6 game đầu tiên làm game nổi bật.
     */
    featuredGames() {

      return this.games.slice(0, 6)

    },


    /*
     * Lấy tối đa 4 game mới nhất.
     */
    newGames() {

      return [...this.games]
        .sort((a, b) => {

          const dateA = new Date(a.created_at || 0)
          const dateB = new Date(b.created_at || 0)

          return dateB - dateA

        })
        .slice(0, 4)

    }

  },


  mounted() {

    this.getHomeData()

  },


  methods: {

    async getHomeData() {

      this.loading = true
      this.error = ''

      try {

        const response = await axios.get(
          'http://127.0.0.1:8000/api/games'
        )


        /*
         * API có thể trả:
         *
         * [
         *   {...}
         * ]
         *
         * hoặc:
         *
         * {
         *   games: [...]
         * }
         *
         * hoặc:
         *
         * {
         *   data: [...]
         * }
         */

        if (Array.isArray(response.data)) {

          this.games = response.data

        } else if (Array.isArray(response.data.games)) {

          this.games = response.data.games

        } else if (Array.isArray(response.data.data)) {

          this.games = response.data.data

        } else {

          this.games = []

        }


        /*
         * Lấy category từ chính dữ liệu game.
         *
         * Vì GameController đang load:
         * category
         */
        this.buildCategories()

      } catch (error) {

        console.error(
          'Lỗi lấy dữ liệu trang chủ:',
          error
        )

        this.error =
          'Không thể tải dữ liệu game. Vui lòng kiểm tra Backend.'

      } finally {

        this.loading = false

      }

    },


    buildCategories() {

      const categoryMap = new Map()

      this.games.forEach(game => {

        if (
          game.category &&
          game.category.id
        ) {

          if (!categoryMap.has(game.category.id)) {

            categoryMap.set(
              game.category.id,
              game.category
            )

          }

        }

      })


      this.categories = Array.from(
        categoryMap.values()
      )

    },


    getCategoryName(game) {

      if (
        game.category &&
        game.category.name
      ) {

        return game.category.name

      }

      return 'GAME'

    },


    getGameImage(game) {

      if (
        !game.images ||
        !game.images.length
      ) {

        return ''

      }


      const image = game.images[0]


      if (!image) {

        return ''

      }


      if (typeof image === 'string') {

        return image

      }


      return image.image_url || ''

    },


    getShortDescription(description) {

      if (!description) {

        return 'Game hấp dẫn đang có mặt tại LootPlay.'

      }


      if (description.length <= 85) {

        return description

      }


      return description.substring(0, 85) + '...'

    },


    formatPrice(price) {

      if (
        price === null ||
        price === undefined
      ) {

        return 'Liên hệ'

      }


      return Number(price)
        .toLocaleString('vi-VN') + ' ₫'

    },


    viewGame(id) {

      this.$router.push(
        `/games/${id}`
      )

    },


    goToCategory(categoryId) {

      /*
       * Hiện tại Games.vue chưa truyền
       * category lên URL nên tạm thời
       * đưa người dùng tới trang Games.
       */
      this.$router.push({
        path: '/games',
        query: {
          category: categoryId
        }
      })

    },


    getCategoryIcon(index) {

      const icons = [

        'bx bx-crosshair',

        'bx bx-shield',

        'bx bx-car',

        'bx bx-football',

        'bx bx-ghost',

        'bx bx-joystick',

        'bx bx-trophy',

        'bx bx-target-lock'

      ]

      return icons[
        index % icons.length
      ]

    },


    getCategoryColor(index) {

      const colors = [

        'blue',

        'purple',

        'orange',

        'green',

        'cyan',

        'pink'

      ]

      return colors[
        index % colors.length
      ]

    },


    handleImageError(event) {

      event.target.style.display = 'none'

    }

  }

}
</script>


<style scoped>

/* =========================
   BASE
========================= */

.home-page {

  width: 100%;

  min-height: 100vh;

  background:
    radial-gradient(
      circle at top right,
      rgba(37, 99, 235, 0.08),
      transparent 35%
    ),
    #080d19;

  color: #f8fafc;

  font-family:
    'Be Vietnam Pro',
    'Plus Jakarta Sans',
    sans-serif;

}


/* =========================
   COMMON
========================= */

.section {

  width: 1240px;

  max-width:
    calc(100% - 48px);

  margin: 0 auto;

  padding: 72px 0;

}


.section-header {

  display: flex;

  align-items: flex-end;

  justify-content: space-between;

  gap: 20px;

  margin-bottom: 36px;

}


.section-header.center {

  justify-content: center;

  text-align: center;

}


.section-label {

  display: inline-flex;

  align-items: center;

  gap: 6px;

  margin-bottom: 8px;

  color: #38bdf8;

  font-size: 11px;

  font-weight: 800;

  letter-spacing: 2px;

}


.section-header h2 {

  margin: 0;

  color: #f1f5f9;

  font-size: 32px;

  font-weight: 800;

}


.see-all {

  display: inline-flex;

  align-items: center;

  gap: 5px;

  padding: 8px 14px;

  border: 1px solid
    rgba(59, 130, 246, 0.3);

  border-radius: 8px;

  color: #60a5fa;

  font-size: 12px;

  font-weight: 700;

  text-decoration: none;

  transition: 0.25s;

}


.see-all:hover {

  background:
    rgba(59, 130, 246, 0.12);

  border-color: #3b82f6;

  transform:
    translateX(3px);

}


/* =========================
   HERO
========================= */

.hero-section {

  position: relative;

  min-height: 560px;

  display: flex;

  align-items: center;

  overflow: hidden;

  background-image:
    url(
      "https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1800&q=85"
    );

  background-size: cover;

  background-position: center;

}


.hero-overlay {

  position: absolute;

  inset: 0;

  background:
    linear-gradient(
      105deg,
      rgba(4, 8, 18, 0.98) 0%,
      rgba(8, 15, 30, 0.94) 48%,
      rgba(8, 15, 30, 0.62) 100%
    );

}


.hero-grid {

  position: absolute;

  inset: 0;

  background-image:
    linear-gradient(
      rgba(59, 130, 246, 0.035) 1px,
      transparent 1px
    ),
    linear-gradient(
      90deg,
      rgba(59, 130, 246, 0.035) 1px,
      transparent 1px
    );

  background-size: 44px 44px;

}


.hero-content {

  position: relative;

  z-index: 2;

  width: 1240px;

  max-width:
    calc(100% - 48px);

  margin: 0 auto;

}


.hero-text {

  max-width: 680px;

}


.hero-badge {

  display: inline-flex;

  align-items: center;

  gap: 8px;

  padding: 7px 16px;

  margin-bottom: 24px;

  border:
    1px solid
    rgba(59, 130, 246, 0.35);

  border-radius: 30px;

  background:
    rgba(37, 99, 235, 0.15);

  color: #93c5fd;

  font-size: 11px;

  font-weight: 800;

  letter-spacing: 2px;

}


.badge-dot {

  width: 7px;

  height: 7px;

  border-radius: 50%;

  background: #22d3ee;

  animation:
    blink 1.5s infinite;

}


@keyframes blink {

  0%,
  100% {
    opacity: 1;
  }

  50% {
    opacity: 0.3;
  }

}


.hero-text h1 {

  margin: 0 0 20px;

  font-size: 68px;

  font-weight: 900;

  line-height: 1.05;

  letter-spacing: 1px;

}


.gradient-text {

  background:
    linear-gradient(
      90deg,
      #38bdf8,
      #818cf8,
      #c084fc,
      #ec4899
    );

  -webkit-background-clip: text;

  -webkit-text-fill-color:
    transparent;

}


.hero-text p {

  max-width: 560px;

  margin: 0 0 32px;

  color: #94a3b8;

  font-size: 16px;

  line-height: 1.8;

}


.hero-buttons {

  display: flex;

  flex-wrap: wrap;

  gap: 12px;

}


.btn-primary,
.btn-secondary {

  display: inline-flex;

  align-items: center;

  gap: 8px;

  padding: 14px 24px;

  border-radius: 10px;

  font-size: 13px;

  font-weight: 700;

  text-decoration: none;

  transition: 0.25s;

}


.btn-primary {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #7c3aed
    );

  color: white;

  box-shadow:
    0 8px 25px
    rgba(37, 99, 235, 0.4);

}


.btn-primary:hover {

  transform:
    translateY(-2px);

  box-shadow:
    0 12px 30px
    rgba(37, 99, 235, 0.55);

}


.btn-secondary {

  border:
    1px solid
    rgba(255,255,255,0.15);

  background:
    rgba(255,255,255,0.06);

  color: #f1f5f9;

}


.btn-secondary:hover {

  background:
    rgba(255,255,255,0.12);

  transform:
    translateY(-2px);

}


.hero-decoration {

  position: absolute;

  border-radius: 50%;

  pointer-events: none;

}


.hero-decoration-one {

  width: 400px;

  height: 400px;

  right: 5%;

  top: -100px;

  background:
    radial-gradient(
      circle,
      rgba(37, 99, 235, 0.22),
      transparent 70%
    );

}


.hero-decoration-two {

  width: 300px;

  height: 300px;

  right: 20%;

  bottom: -120px;

  background:
    radial-gradient(
      circle,
      rgba(124, 58, 237, 0.2),
      transparent 70%
    );

}


/* =========================
   STATS
========================= */

.stats-section {

  padding: 24px 24px;

  background:
    #0b1220;

  border-bottom:
    1px solid
    rgba(255,255,255,0.06);

}


.stats-container {

  width: 1240px;

  max-width:
    100%;

  margin: 0 auto;

  display: grid;

  grid-template-columns:
    repeat(4, 1fr);

  gap: 16px;

}


.stat-card {

  display: flex;

  align-items: center;

  gap: 14px;

  padding: 18px;

  border:
    1px solid
    rgba(255,255,255,0.06);

  border-radius: 12px;

  background:
    rgba(17,24,39,0.65);

}


.stat-icon {

  width: 46px;

  height: 46px;

  flex-shrink: 0;

  display: flex;

  align-items: center;

  justify-content: center;

  border-radius: 12px;

  color: white;

  font-size: 22px;

}


.stat-icon.blue {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #38bdf8
    );

}


.stat-icon.purple {

  background:
    linear-gradient(
      135deg,
      #7c3aed,
      #a78bfa
    );

}


.stat-icon.cyan {

  background:
    linear-gradient(
      135deg,
      #0891b2,
      #22d3ee
    );

}


.stat-icon.orange {

  background:
    linear-gradient(
      135deg,
      #ea580c,
      #f97316
    );

}


.stat-card strong {

  display: block;

  color: #f8fafc;

  font-size: 19px;

  font-weight: 800;

}


.stat-card span {

  display: block;

  margin-top: 3px;

  color: #64748b;

  font-size: 12px;

}


/* =========================
   CATEGORY
========================= */

.category-grid {

  display: grid;

  grid-template-columns:
    repeat(4, 1fr);

  gap: 16px;

}


.category-card {

  position: relative;

  display: flex;

  align-items: center;

  gap: 14px;

  padding: 18px 16px;

  border:
    1px solid
    rgba(255,255,255,0.07);

  border-radius: 14px;

  background:
    rgba(17,24,39,0.65);

  cursor: pointer;

  transition: 0.25s;

  overflow: hidden;

}


.category-card:hover {

  transform:
    translateY(-4px);

  border-color:
    rgba(59,130,246,0.35);

  box-shadow:
    0 12px 30px
    rgba(0,0,0,0.25);

}


.category-icon {

  width: 48px;

  height: 48px;

  flex-shrink: 0;

  display: flex;

  align-items: center;

  justify-content: center;

  border-radius: 12px;

  color: white;

  font-size: 21px;

}


.category-icon.blue {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #38bdf8
    );

}


.category-icon.purple {

  background:
    linear-gradient(
      135deg,
      #7c3aed,
      #a78bfa
    );

}


.category-icon.orange {

  background:
    linear-gradient(
      135deg,
      #ea580c,
      #f97316
    );

}


.category-icon.green {

  background:
    linear-gradient(
      135deg,
      #059669,
      #10b981
    );

}


.category-icon.cyan {

  background:
    linear-gradient(
      135deg,
      #0891b2,
      #06b6d4
    );

}


.category-icon.pink {

  background:
    linear-gradient(
      135deg,
      #db2777,
      #f472b6
    );

}


.category-info {

  min-width: 0;

  flex: 1;

}


.category-info h3 {

  margin: 0 0 4px;

  color: #f1f5f9;

  font-size: 15px;

  font-weight: 700;

}


.category-info p {

  margin: 0;

  overflow: hidden;

  color: #64748b;

  font-size: 11px;

  white-space: nowrap;

  text-overflow: ellipsis;

}


.category-arrow {

  color: #334155;

  font-size: 20px;

  transition: 0.2s;

}


.category-card:hover
.category-arrow {

  color: #60a5fa;

  transform:
    translateX(3px);

}


/* =========================
   GAMES
========================= */

.games-section {

  padding-top: 30px;

  border-top:
    1px solid
    rgba(255,255,255,0.05);

}


.games-grid {

  display: grid;

  grid-template-columns:
    repeat(3, 1fr);

  gap: 20px;

}


.game-card {

  overflow: hidden;

  border:
    1px solid
    rgba(255,255,255,0.08);

  border-radius: 16px;

  background:
    rgba(17,24,39,0.75);

  transition: 0.3s;

}


.game-card:hover {

  transform:
    translateY(-6px);

  border-color:
    rgba(59,130,246,0.3);

  box-shadow:
    0 20px 40px
    rgba(0,0,0,0.35);

}


.game-image {

  position: relative;

  height: 210px;

  overflow: hidden;

  background: #111827;

}


.game-image img {

  width: 100%;

  height: 100%;

  display: block;

  object-fit: cover;

  transition:
    transform 0.4s;

}


.game-card:hover
.game-image img {

  transform:
    scale(1.07);

}


.no-image {

  width: 100%;

  height: 100%;

  display: flex;

  flex-direction: column;

  align-items: center;

  justify-content: center;

  gap: 5px;

  background:
    #111827;

  color: #475569;

}


.no-image i {

  font-size: 40px;

}


.no-image span {

  font-size: 11px;

}


.game-tag {

  position: absolute;

  top: 12px;

  left: 12px;

  padding: 5px 10px;

  border-radius: 6px;

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #38bdf8
    );

  color: white;

  font-size: 10px;

  font-weight: 800;

}


.game-overlay {

  position: absolute;

  inset: 0;

  display: flex;

  align-items: center;

  justify-content: center;

  background:
    rgba(0,0,0,0.55);

  opacity: 0;

  transition: 0.3s;

}


.game-card:hover
.game-overlay {

  opacity: 1;

}


.quick-view-btn {

  display: flex;

  align-items: center;

  gap: 7px;

  padding: 10px 18px;

  border: none;

  border-radius: 8px;

  background: white;

  color: #111827;

  font-size: 12px;

  font-weight: 700;

  cursor: pointer;

}


.game-content {

  padding: 18px;

}


.game-header {

  display: flex;

  align-items: flex-start;

  justify-content: space-between;

  gap: 10px;

  margin-bottom: 8px;

}


.game-header h3 {

  margin: 0;

  color: #f1f5f9;

  font-size: 17px;

  font-weight: 700;

}


.game-stock {

  flex-shrink: 0;

  color: #64748b;

  font-size: 11px;

}


.game-content > p {

  min-height: 40px;

  margin: 0 0 16px;

  color: #64748b;

  font-size: 13px;

  line-height: 1.55;

}


.game-footer {

  display: flex;

  align-items: center;

  justify-content: space-between;

  padding-top: 14px;

  border-top:
    1px solid
    rgba(255,255,255,0.07);

}


.price {

  color: #60a5fa;

  font-size: 19px;

  font-weight: 800;

}


.view-button {

  padding: 8px 14px;

  border:
    1px solid
    rgba(59,130,246,0.3);

  border-radius: 8px;

  background:
    rgba(59,130,246,0.1);

  color: #60a5fa;

  font-size: 11px;

  font-weight: 700;

  cursor: pointer;

  transition: 0.2s;

}


.view-button:hover {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #7c3aed
    );

  border-color: transparent;

  color: white;

}


/* =========================
   NEW GAMES
========================= */

.new-games-section {

  background:
    rgba(15,23,42,0.5);

  border-top:
    1px solid
    rgba(255,255,255,0.06);

  border-bottom:
    1px solid
    rgba(255,255,255,0.06);

}


.new-games-grid {

  display: grid;

  grid-template-columns:
    repeat(2, 1fr);

  gap: 16px;

}


.new-game-card {

  position: relative;

  display: flex;

  align-items: center;

  gap: 16px;

  padding: 14px;

  border:
    1px solid
    rgba(255,255,255,0.07);

  border-radius: 12px;

  background:
    rgba(17,24,39,0.65);

  cursor: pointer;

  transition: 0.25s;

}


.new-game-card:hover {

  transform:
    translateY(-3px);

  border-color:
    rgba(59,130,246,0.3);

}


.new-game-image {

  width: 120px;

  height: 80px;

  flex-shrink: 0;

  overflow: hidden;

  border-radius: 8px;

}


.new-game-image img {

  width: 100%;

  height: 100%;

  object-fit: cover;

}


.new-game-info {

  min-width: 0;

  flex: 1;

}


.new-game-category {

  color: #38bdf8;

  font-size: 10px;

  font-weight: 800;

  text-transform: uppercase;

}


.new-game-info h3 {

  margin: 5px 0;

  overflow: hidden;

  color: #f1f5f9;

  font-size: 16px;

  font-weight: 700;

  white-space: nowrap;

  text-overflow: ellipsis;

}


.new-game-info strong {

  color: #60a5fa;

  font-size: 14px;

}


.new-game-arrow {

  color: #334155;

  font-size: 20px;

}


.new-game-card:hover
.new-game-arrow {

  color: #60a5fa;

}


/* =========================
   WHY
========================= */

.why-section {

  background:
    rgba(8,13,25,0.7);

}


.features-grid {

  display: grid;

  grid-template-columns:
    repeat(4, 1fr);

  gap: 20px;

}


.feature-card {

  padding: 28px 22px;

  border:
    1px solid
    rgba(255,255,255,0.07);

  border-radius: 16px;

  background:
    rgba(17,24,39,0.6);

  text-align: center;

  transition: 0.25s;

}


.feature-card:hover {

  transform:
    translateY(-5px);

  border-color:
    rgba(59,130,246,0.25);

}


.feature-icon {

  width: 58px;

  height: 58px;

  margin:
    0 auto 16px;

  display: flex;

  align-items: center;

  justify-content: center;

  border-radius: 15px;

  color: white;

  font-size: 25px;

}


.feature-icon.blue {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #38bdf8
    );

}


.feature-icon.purple {

  background:
    linear-gradient(
      135deg,
      #7c3aed,
      #a78bfa
    );

}


.feature-icon.cyan {

  background:
    linear-gradient(
      135deg,
      #0891b2,
      #06b6d4
    );

}


.feature-icon.orange {

  background:
    linear-gradient(
      135deg,
      #ea580c,
      #f97316
    );

}


.feature-card h3 {

  margin:
    0 0 8px;

  color: #f1f5f9;

  font-size: 16px;

}


.feature-card p {

  margin: 0;

  color: #64748b;

  font-size: 13px;

  line-height: 1.6;

}


/* =========================
   CTA
========================= */

.cta-section {

  position: relative;

  padding: 80px 24px;

  overflow: hidden;

  background:
    linear-gradient(
      135deg,
      #0f172a,
      #090d18
    );

  text-align: center;

}


.cta-content {

  position: relative;

  z-index: 2;

  max-width: 700px;

  margin: auto;

}


.cta-content h2 {

  margin:
    10px 0 12px;

  color: #f8fafc;

  font-size: 40px;

  font-weight: 800;

}


.cta-content p {

  margin:
    0 0 30px;

  color: #64748b;

  font-size: 15px;

}


.cta-buttons {

  display: flex;

  justify-content: center;

  gap: 14px;

  flex-wrap: wrap;

}


.cta-primary,
.cta-secondary {

  display: inline-flex;

  align-items: center;

  gap: 8px;

  padding: 14px 28px;

  border-radius: 10px;

  font-size: 13px;

  font-weight: 700;

  text-decoration: none;

  transition: 0.25s;

}


.cta-primary {

  background:
    linear-gradient(
      135deg,
      #2563eb,
      #7c3aed
    );

  color: white;

}


.cta-secondary {

  border:
    1px solid
    rgba(255,255,255,0.12);

  background:
    rgba(255,255,255,0.05);

  color: #94a3b8;

}


.cta-primary:hover,
.cta-secondary:hover {

  transform:
    translateY(-2px);

}


.cta-glow {

  position: absolute;

  width: 400px;

  height: 400px;

  border-radius: 50%;

}


.cta-glow.left {

  left: -180px;

  top: 50%;

  transform:
    translateY(-50%);

  background:
    radial-gradient(
      circle,
      rgba(37,99,235,0.2),
      transparent 70%
    );

}


.cta-glow.right {

  right: -180px;

  top: 50%;

  transform:
    translateY(-50%);

  background:
    radial-gradient(
      circle,
      rgba(124,58,237,0.2),
      transparent 70%
    );

}


/* =========================
   LOADING / ERROR
========================= */

.loading-box,
.error-box,
.empty-message {

  padding: 40px;

  border:
    1px solid
    rgba(255,255,255,0.06);

  border-radius: 12px;

  background:
    rgba(17,24,39,0.6);

  color: #64748b;

  text-align: center;

}


.loading-box i {

  margin-right: 8px;

  color: #38bdf8;

  font-size: 20px;

}


.error-box {

  color: #f87171;

}


.error-box i {

  margin-right: 6px;

}


/* =========================
   RESPONSIVE
========================= */

@media (max-width: 1100px) {

  .stats-container {

    grid-template-columns:
      repeat(2, 1fr);

  }

  .category-grid {

    grid-template-columns:
      repeat(2, 1fr);

  }

  .features-grid {

    grid-template-columns:
      repeat(2, 1fr);

  }

}


@media (max-width: 900px) {

  .hero-text h1 {

    font-size: 50px;

  }

  .games-grid {

    grid-template-columns:
      repeat(2, 1fr);

  }

  .new-games-grid {

    grid-template-columns: 1fr;

  }

}


@media (max-width: 640px) {

  .section {

    max-width:
      calc(100% - 30px);

    padding: 50px 0;

  }

  .hero-section {

    min-height: 520px;

  }

  .hero-content {

    max-width:
      calc(100% - 30px);

  }

  .hero-text h1 {

    font-size: 38px;

  }

  .hero-text p {

    font-size: 14px;

  }

  .hero-buttons {

    flex-direction: column;

  }

  .btn-primary,
  .btn-secondary {

    justify-content: center;

  }

  .stats-container {

    grid-template-columns: 1fr;

  }

  .category-grid {

    grid-template-columns: 1fr;

  }

  .games-grid {

    grid-template-columns: 1fr;

  }

  .features-grid {

    grid-template-columns: 1fr;

  }

  .section-header {

    flex-direction: column;

    align-items: flex-start;

  }

  .new-game-image {

    width: 90px;

    height: 70px;

  }

  .cta-content h2 {

    font-size: 30px;

  }

}

</style>