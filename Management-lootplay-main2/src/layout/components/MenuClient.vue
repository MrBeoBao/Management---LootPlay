<template>
    <nav class="menu">
        <div class="menu-container">

            <!-- Logo -->
            <router-link to="/" class="logo">
                <div class="logo-icon">
                    <i class="bx bx-game"></i>
                </div>

                <span class="logo-text">
                    Loot<span>Play</span>
                </span>
            </router-link>

            <!-- Menu -->
            <div class="menu-links">

                <router-link
                    to="/"
                    class="menu-link"
                    :class="{ active: $route.path === '/' }"
                >
                    <i class="bx bx-home-alt"></i>
                    <span>Trang Chủ</span>
                </router-link>

                <router-link
                    to="/games"
                    class="menu-link"
                    :class="{ active: $route.path.startsWith('/games') }"
                >
                    <i class="bx bx-joystick"></i>
                    <span>Games</span>
                </router-link>

                <!-- DIỄN ĐÀN -->
                <a
                    href="#"
                    class="menu-link"
                    @click.prevent
                >
                    <i class="bx bx-message-square-detail"></i>
                    <span>Diễn Đàn</span>
                </a>

                <!-- FAQS -->
                <a
                    href="#"
                    class="menu-link"
                    @click.prevent
                >
                    <i class="bx bx-help-circle"></i>
                    <span>FAQs</span>
                </a>

            </div>

            <!-- Right -->
            <div class="menu-right">

                <!-- Sale -->
                <div class="sale-badge">
                    SALE UP TO 70%
                </div>

                <!-- Search -->
                <div class="search-box">

                    <input
                        v-model="searchKeyword"
                        type="text"
                        placeholder="Tìm kiếm game..."
                        @keyup.enter="searchGame"
                    >

                    <button
                        class="search-button"
                        @click="searchGame"
                        title="Tìm kiếm game"
                    >
                        <i class="bx bx-search"></i>
                    </button>

                </div>

            </div>

        </div>
    </nav>
</template>

<script>
export default {
    name: 'MenuClient',

    data() {
        return {
            searchKeyword: ''
        }
    },

    methods: {

        searchGame() {
            const keyword = this.searchKeyword.trim()

            if (!keyword) {
                return
            }

            this.$router.push({
                path: '/games',
                query: {
                    search: keyword
                }
            })
        }

    }
}
</script>

<style scoped>

.menu {
    width: 100%;
    height: 76px;

    background: rgba(10, 14, 23, 0.97);

    border-bottom: 1px solid rgba(59, 130, 246, 0.25);

    font-family: var(--font-main, sans-serif);
}

.menu-container {
    width: 100%;
    max-width: 1280px;
    height: 100%;

    margin: 0 auto;
    padding: 0 24px;

    display: flex;
    align-items: center;
    justify-content: space-between;
}

/* =========================
   LOGO
========================= */

.logo {
    display: flex;
    align-items: center;
    gap: 10px;

    text-decoration: none;

    flex-shrink: 0;
}

.logo-icon {
    width: 44px;
    height: 44px;

    display: flex;
    align-items: center;
    justify-content: center;

    border-radius: 12px;

    background: linear-gradient(
        135deg,
        #2563eb,
        #7c3aed
    );

    color: #ffffff;

    font-size: 25px;

    box-shadow:
        0 6px 18px rgba(37, 99, 235, 0.35);
}

.logo-text {
    font-size: 28px;
    font-weight: 800;

    color: #f1f5f9;

    letter-spacing: -0.5px;
}

.logo-text span {
    background: linear-gradient(
        90deg,
        #38bdf8,
        #a78bfa
    );

    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

    background-clip: text;
}

/* =========================
   MENU LINKS
========================= */

.menu-links {
    display: flex;
    align-items: center;
    gap: 8px;
}

.menu-link {
    position: relative;

    display: inline-flex;
    align-items: center;

    gap: 7px;

    padding: 10px 14px;

    color: #94a3b8;

    text-decoration: none;

    font-size: 15px;
    font-weight: 600;

    border-radius: 8px;

    transition: all 0.25s ease;
}

.menu-link i {
    font-size: 18px;
}

.menu-link:hover {
    color: #f1f5f9;

    background: rgba(59, 130, 246, 0.08);
}

.menu-link.active {
    color: #f1f5f9;
}

.menu-link.active::after {
    content: '';

    position: absolute;

    left: 14px;
    right: 14px;
    bottom: -20px;

    height: 2px;

    background: linear-gradient(
        90deg,
        #2563eb,
        #7c3aed
    );

    border-radius: 2px;

    box-shadow:
        0 0 10px rgba(59, 130, 246, 0.6);
}

/* =========================
   RIGHT
========================= */

.menu-right {
    display: flex;
    align-items: center;
    gap: 12px;
}

/* =========================
   SALE
========================= */

.sale-badge {
    padding: 8px 16px;

    border-radius: 20px;

    background: rgba(245, 158, 11, 0.08);

    border: 1px solid rgba(245, 158, 11, 0.35);

    color: #fbbf24;

    font-size: 11px;
    font-weight: 800;

    letter-spacing: 0.5px;

    white-space: nowrap;
}

/* =========================
   SEARCH
========================= */

.search-box {
    height: 42px;

    display: flex;
    align-items: center;

    background: rgba(255, 255, 255, 0.05);

    border: 1px solid rgba(255, 255, 255, 0.1);

    border-radius: 10px;

    overflow: hidden;

    transition: all 0.25s ease;
}

.search-box:focus-within {
    background: rgba(59, 130, 246, 0.08);

    border-color: rgba(59, 130, 246, 0.6);

    box-shadow:
        0 0 0 3px rgba(59, 130, 246, 0.08);
}

.search-box input {
    width: 180px;
    height: 100%;

    padding: 0 12px;

    background: transparent;

    border: none;
    outline: none;

    color: #f1f5f9;

    font-size: 13px;
}

.search-box input::placeholder {
    color: #64748b;
}

.search-button {
    width: 42px;
    height: 42px;

    display: flex;
    align-items: center;
    justify-content: center;

    background: transparent;

    border: none;

    color: #94a3b8;

    font-size: 20px;

    cursor: pointer;

    transition: all 0.25s ease;
}

.search-button:hover {
    color: #ffffff;

    background: rgba(59, 130, 246, 0.15);
}

/* =========================
   RESPONSIVE
========================= */

@media (max-width: 1200px) {

    .search-box input {
        width: 140px;
    }

    .menu-links {
        gap: 2px;
    }

    .menu-link {
        padding: 10px 9px;
    }
}

@media (max-width: 1100px) {

    .sale-badge {
        display: none;
    }

    .search-box input {
        width: 160px;
    }
}

@media (max-width: 900px) {

    .logo-text {
        font-size: 23px;
    }

    .logo-icon {
        width: 40px;
        height: 40px;

        font-size: 22px;
    }

    .menu-link span {
        display: none;
    }

    .menu-link {
        padding: 10px;
    }

    .menu-link i {
        font-size: 21px;
    }

    .menu-link.active::after {
        left: 8px;
        right: 8px;
        bottom: -19px;
    }

    .search-box input {
        width: 130px;
    }
}

@media (max-width: 650px) {

    .menu-container {
        padding: 0 14px;
    }

    .menu-links {
        gap: 0;
    }

    .search-box input {
        display: none;
    }

    .search-box {
        width: 42px;
    }

    .search-button {
        width: 42px;
    }
}

@media (max-width: 550px) {

    .logo-text {
        font-size: 20px;
    }

    .menu-right {
        gap: 6px;
    }
}

</style>