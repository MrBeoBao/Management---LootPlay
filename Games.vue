<template>
    <div class="games-page">

        <!-- HEADER -->
        <section class="games-header">

            <div class="header-content">

                <span class="header-label">
                    LOOTPLAY STORE
                </span>

                <h1>
                    TẤT CẢ GAME
                </h1>

                <p>
                    Khám phá những tựa game hấp dẫn
                    đang có tại LootPlay.
                </p>

            </div>

        </section>


        <!-- GAME LIST -->
        <section class="games-section">

            <div class="section-top">

                <div>
                    <h2>
                        Danh sách game
                    </h2>

                    <p>
                        {{ filteredGames.length }} game
                        <span v-if="searchKeyword">
                            phù hợp với "{{ searchKeyword }}"
                        </span>
                        <span v-else>
                            đang được bán
                        </span>
                    </p>
                </div>


                <div class="filter-area">

                    <!-- SEARCH -->
                    <div class="page-search">

                        <i class="bx bx-search"></i>

                        <input
                            v-model="searchKeyword"
                            type="text"
                            placeholder="Tìm kiếm game..."
                        >

                        <button
                            v-if="searchKeyword"
                            class="clear-search"
                            @click="clearSearch"
                            title="Xóa tìm kiếm"
                        >
                            <i class="bx bx-x"></i>
                        </button>

                    </div>


                    <!-- CATEGORY -->
                    <select
                        v-model="selectedCategory"
                        class="category-select"
                    >
                        <option value="">
                            Tất cả thể loại
                        </option>

                        <option
                            v-for="category in categories"
                            :key="category"
                            :value="category"
                        >
                            {{ category }}
                        </option>

                    </select>

                </div>

            </div>


            <!-- LOADING -->
            <div
                v-if="loading"
                class="loading"
            >
                Đang tải danh sách game...
            </div>


            <!-- ERROR -->
            <div
                v-else-if="errorMessage"
                class="error-box"
            >
                {{ errorMessage }}
            </div>


            <!-- GAMES -->
            <div
                v-else
                class="games-grid"
            >

                <div
                    v-for="game in filteredGames"
                    :key="game.id"
                    class="game-card"
                >

                    <!-- GAME IMAGE -->
                    <div class="game-image">

                        <img
                            :src="getGameImage(game)"
                            :alt="game.name"
                        >

                        <span class="game-category">
                            {{ game.category?.name || 'Game' }}
                        </span>

                    </div>


                    <!-- GAME CONTENT -->
                    <div class="game-content">

                        <h3>
                            {{ game.name }}
                        </h3>

                        <p class="description">
                            {{ game.description }}
                        </p>


                        <!-- GAME INFO -->
                        <div class="game-info">

                            <div class="developer">

                                <span>
                                    Developer
                                </span>

                                <strong>
                                    {{ game.developer }}
                                </strong>

                            </div>


                            <div class="stock">

                                <span>
                                    Còn lại
                                </span>

                                <strong>
                                    {{ game.stock }}
                                </strong>

                            </div>

                        </div>


                        <!-- PRICE + DETAIL -->
                        <div class="game-bottom">

                            <div class="price">
                                {{ formatPrice(game.price) }}
                            </div>


                            <router-link
                                :to="`/games/${game.id}`"
                                class="detail-button"
                            >
                                XEM CHI TIẾT

                                <i class="bx bx-right-arrow-alt"></i>
                            </router-link>

                        </div>

                    </div>

                </div>


                <!-- NO GAME -->
                <div
                    v-if="filteredGames.length === 0"
                    class="no-game"
                >
                    <i class="bx bx-search-alt-2"></i>

                    <strong>
                        Không tìm thấy game phù hợp
                    </strong>

                    <span>
                        Thử tìm kiếm với tên game khác.
                    </span>

                </div>

            </div>

        </section>

    </div>
</template>


<script>

export default {

    name: 'Games',

    data() {

        return {

            games: [],

            loading: true,

            errorMessage: '',

            selectedCategory: '',

            searchKeyword: ''

        }

    },


    computed: {

        categories() {

            const categoryNames = this.games
                .map(game => game.category?.name)
                .filter(Boolean)

            return [...new Set(categoryNames)]

        },


        filteredGames() {

            let result = this.games


            // LỌC THEO TÊN GAME
            if (this.searchKeyword.trim()) {

                const keyword =
                    this.searchKeyword
                        .trim()
                        .toLowerCase()

                result = result.filter(game => {

                    return game.name
                        ?.toLowerCase()
                        .includes(keyword)

                })

            }


            // LỌC THEO THỂ LOẠI
            if (this.selectedCategory) {

                result = result.filter(game => {

                    return game.category?.name ===
                        this.selectedCategory

                })

            }


            return result

        }

    },


    mounted() {

        this.getSearchFromUrl()

        this.getGames()

    },


    watch: {

        '$route.query.search'(newValue) {

            this.searchKeyword = newValue || ''

        }

    },


    methods: {

        getSearchFromUrl() {

            this.searchKeyword =
                this.$route.query.search || ''

        },


        async getGames() {

            this.loading = true

            this.errorMessage = ''


            try {

                const response = await fetch(
                    'http://127.0.0.1:8000/api/games',
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
                        'Không thể lấy danh sách game'

                    return

                }


                this.games = data.games || []

            }


            catch (error) {

                this.errorMessage =
                    'Không thể kết nối đến máy chủ'

            }


            finally {

                this.loading = false

            }

        },


        clearSearch() {

            this.searchKeyword = ''

            this.$router.push({
                path: '/games'
            })

        },


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


            return 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1000&q=85'

        },


        formatPrice(price) {

            return new Intl.NumberFormat(
                'vi-VN'
            ).format(price) + 'đ'

        }

    }

}

</script>


<style scoped>

/* ========================= PAGE ========================= */

.games-page {
    width: 100%;
    min-height: 100vh;
    background: transparent;
    color: #f8fafc;
    font-family: 'Be Vietnam Pro', 'Plus Jakarta Sans', sans-serif;
}


/* ========================= HEADER ========================= */

.games-header {
    position: relative;
    padding: 60px 24px 64px;
    background:
        linear-gradient(
            135deg,
            rgba(10, 15, 30, 0.98) 0%,
            rgba(18, 24, 50, 0.98) 100%
        );
    overflow: hidden;
    border-bottom: 1px solid rgba(59, 130, 246, 0.15);
}

.games-header::before {
    content: '';
    position: absolute;
    inset: 0;

    background-image:
        linear-gradient(
            rgba(59, 130, 246, 0.03) 1px,
            transparent 1px
        ),
        linear-gradient(
            90deg,
            rgba(59, 130, 246, 0.03) 1px,
            transparent 1px
        );

    background-size: 44px 44px;
}

.games-header::after {
    content: '';
    position: absolute;

    width: 500px;
    height: 500px;

    border-radius: 50%;

    right: -180px;
    top: -200px;

    background:
        radial-gradient(
            circle,
            rgba(37, 99, 235, 0.15) 0%,
            transparent 70%
        );
}

.header-content {
    position: relative;
    z-index: 2;

    width: 1240px;
    max-width: calc(100% - 48px);

    margin: 0 auto;
}

.header-label {
    display: inline-flex;
    align-items: center;
    gap: 6px;

    font-size: 11px;
    font-weight: 800;

    letter-spacing: 2px;

    color: #38bdf8;

    text-transform: uppercase;

    margin-bottom: 12px;
}

.header-content h1 {
    margin: 0 0 12px;

    color: #f8fafc;

    font-family:
        'Barlow Condensed',
        'Be Vietnam Pro',
        sans-serif;

    font-size: 48px;
    font-weight: 800;

    text-transform: uppercase;

    letter-spacing: 1px;

    line-height: 1.1;
}

.header-content p {
    margin: 0;

    color: #94a3b8;

    font-size: 15px;

    line-height: 1.7;

    font-weight: 400;
}


/* ========================= SECTION ========================= */

.games-section {
    width: 1240px;
    max-width: calc(100% - 48px);

    margin: 0 auto;

    padding: 48px 0 72px;
}

.section-top {
    display: flex;

    justify-content: space-between;
    align-items: center;

    gap: 25px;

    margin-bottom: 28px;

    padding-bottom: 20px;

    border-bottom:
        1px solid rgba(255, 255, 255, 0.07);
}

.section-top h2 {
    margin: 0 0 4px;

    font-size: 22px;
    font-weight: 700;

    color: #f1f5f9;
}

.section-top p {
    margin: 0;

    color: #64748b;

    font-size: 13px;
}


/* ========================= FILTER ========================= */

.filter-area {
    display: flex;
    align-items: center;
    gap: 10px;
}


/* ========================= PAGE SEARCH ========================= */

.page-search {
    position: relative;

    width: 230px;
}

.page-search > i {
    position: absolute;

    left: 13px;
    top: 50%;

    transform: translateY(-50%);

    color: #64748b;

    font-size: 18px;

    pointer-events: none;
}

.page-search input {
    width: 100%;

    box-sizing: border-box;

    padding: 10px 38px 10px 40px;

    background: rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.12);

    border-radius: 10px;

    color: #e2e8f0;

    font-size: 13px;

    outline: none;

    font-family:
        var(--font-main, sans-serif);

    transition: all 0.2s ease;
}

.page-search input::placeholder {
    color: #64748b;
}

.page-search input:focus {
    border-color: #3b82f6;

    box-shadow:
        0 0 0 3px rgba(59, 130, 246, 0.12);
}

.clear-search {
    position: absolute;

    right: 8px;
    top: 50%;

    transform: translateY(-50%);

    width: 25px;
    height: 25px;

    display: flex;
    align-items: center;
    justify-content: center;

    border: none;

    background: transparent;

    color: #64748b;

    cursor: pointer;

    border-radius: 6px;
}

.clear-search:hover {
    color: #ffffff;

    background: rgba(255, 255, 255, 0.08);
}


/* ========================= CATEGORY ========================= */

.category-select {
    min-width: 190px;

    padding: 10px 14px;

    background: rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.12);

    border-radius: 10px;

    color: #e2e8f0;

    font-size: 13px;
    font-weight: 500;

    outline: none;

    cursor: pointer;

    transition: border-color 0.2s ease;

    font-family:
        var(--font-main, sans-serif);
}

.category-select:focus {
    border-color: #3b82f6;

    box-shadow:
        0 0 0 3px rgba(59, 130, 246, 0.12);
}

.category-select option {
    background: #111827;
    color: #f1f5f9;
}


/* ========================= GAME GRID ========================= */

.games-grid {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 20px;
}

.game-card {
    overflow: hidden;

    background: rgba(17, 24, 39, 0.7);

    border:
        1px solid rgba(255, 255, 255, 0.08);

    border-radius: 16px;

    transition: all 0.3s ease;

    backdrop-filter: blur(10px);
}

.game-card:hover {
    transform: translateY(-6px);

    border-color:
        rgba(59, 130, 246, 0.35);

    box-shadow:
        0 20px 40px rgba(0, 0, 0, 0.4),
        0 0 0 1px rgba(59, 130, 246, 0.12);
}


/* ========================= IMAGE ========================= */

.game-image {
    position: relative;

    width: 100%;
    height: 220px;

    overflow: hidden;

    background: #0f172a;
}

.game-image img {
    width: 100%;
    height: 100%;

    display: block;

    object-fit: cover;

    transition:
        transform 0.4s ease;
}

.game-card:hover .game-image img {
    transform: scale(1.07);
}

.game-category {
    position: absolute;

    left: 12px;
    top: 12px;

    padding: 5px 10px;

    border-radius: 6px;

    background:
        linear-gradient(
            135deg,
            #2563eb,
            #38bdf8
        );

    color: #fff;

    font-size: 10px;
    font-weight: 800;

    letter-spacing: 0.6px;

    box-shadow:
        0 2px 8px rgba(37, 99, 235, 0.4);
}


/* ========================= CONTENT ========================= */

.game-content {
    padding: 18px;
}

.game-content h3 {
    margin: 0 0 8px;

    font-size: 18px;
    font-weight: 700;

    color: #f1f5f9;
}

.description {
    height: 38px;

    margin: 0 0 16px;

    color: #64748b;

    font-size: 13px;

    line-height: 1.5;

    overflow: hidden;
}


/* ========================= INFO ========================= */

.game-info {
    display: flex;

    justify-content: space-between;

    padding: 12px 0;

    border-top:
        1px solid rgba(255, 255, 255, 0.07);

    border-bottom:
        1px solid rgba(255, 255, 255, 0.07);
}

.game-info span {
    display: block;

    margin-bottom: 3px;

    color: #475569;

    font-size: 10px;
    font-weight: 600;

    letter-spacing: 0.5px;

    text-transform: uppercase;
}

.game-info strong {
    color: #94a3b8;

    font-size: 12px;
    font-weight: 600;
}


/* ========================= BOTTOM ========================= */

.game-bottom {
    display: flex;

    align-items: center;

    justify-content: space-between;

    margin-top: 16px;
}

.price {
    font-size: 19px;

    font-weight: 800;

    background:
        linear-gradient(
            135deg,
            #38bdf8,
            #a78bfa
        );

    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

    background-clip: text;
}

.detail-button {
    display: flex;

    align-items: center;

    gap: 5px;

    padding: 8px 13px;

    border-radius: 8px;

    background:
        rgba(59, 130, 246, 0.1);

    border:
        1px solid rgba(59, 130, 246, 0.25);

    color: #60a5fa;

    font-size: 11px;
    font-weight: 700;

    text-decoration: none;

    cursor: pointer;

    transition: all 0.2s ease;

    letter-spacing: 0.4px;
}

.detail-button:hover {
    background:
        linear-gradient(
            135deg,
            #2563eb,
            #7c3aed
        );

    border-color: transparent;

    color: #fff;

    box-shadow:
        0 4px 14px rgba(37, 99, 235, 0.4);

    transform: translateY(-1px);
}


/* ========================= LOADING ========================= */

.loading {
    padding: 80px 20px;

    text-align: center;

    color: #38bdf8;

    font-size: 15px;

    font-weight: 500;
}


/* ========================= ERROR ========================= */

.error-box {
    padding: 24px;

    border-radius: 12px;

    background:
        rgba(239, 68, 68, 0.08);

    border:
        1px solid rgba(239, 68, 68, 0.25);

    color: #f87171;

    text-align: center;

    font-size: 14px;
}


/* ========================= NO GAME ========================= */

.no-game {
    grid-column: 1 / -1;

    min-height: 250px;

    padding: 60px 20px;

    display: flex;

    flex-direction: column;

    align-items: center;

    justify-content: center;

    gap: 8px;

    background:
        rgba(17, 24, 39, 0.5);

    border:
        1px dashed rgba(255, 255, 255, 0.1);

    border-radius: 16px;

    text-align: center;

    color: #64748b;

    font-size: 15px;
}

.no-game i {
    font-size: 38px;

    color: #475569;

    margin-bottom: 8px;
}

.no-game strong {
    color: #94a3b8;

    font-size: 16px;
}

.no-game span {
    color: #475569;

    font-size: 13px;
}


/* ========================= RESPONSIVE ========================= */

@media (max-width: 1000px) {

    .section-top {
        align-items: flex-start;
    }

    .filter-area {
        flex-direction: column;
        align-items: stretch;
    }

    .page-search {
        width: 220px;
    }

    .category-select {
        width: 220px;
    }

}


@media (max-width: 900px) {

    .games-grid {
        grid-template-columns:
            repeat(2, 1fr);
    }

}


@media (max-width: 700px) {

    .section-top {
        flex-direction: column;
        align-items: stretch;
    }

    .filter-area {
        width: 100%;
    }

    .page-search,
    .category-select {
        width: 100%;
    }

}


@media (max-width: 600px) {

    .games-grid {
        grid-template-columns: 1fr;
    }

    .header-content h1 {
        font-size: 32px;
    }

}

</style>