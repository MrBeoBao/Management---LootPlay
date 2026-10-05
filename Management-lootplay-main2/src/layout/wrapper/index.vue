<template>
  <div class="wrapper-shell">
    <div class="sticky-header-container">
      <HeaderClient />
      <MenuClient />
    </div>

    <main class="page-wrapper">
      <router-view />
    </main>

    <FooterClinet />
  </div>
</template>

<script>
import HeaderClient from '../components/HeaderClient.vue'
import MenuClient from '../components/MenuClient.vue'
import FooterClinet from '../components/FooterClinet.vue'

export default {
  name: 'LayoutWrapper',
  components: {
    HeaderClient,
    MenuClient,
    FooterClinet
  }
}
</script>

<style>
@import "../../assets/css/bootstrap.min.css";
@import "../../assets/css/bootstrap-extended.css";
@import "../../assets/css/icons.css";

:root {
  --font-main: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
  --font-gaming: 'Rajdhani', sans-serif;
  
  --bg-dark: #0a0e17;
  --bg-surface: #0f172a;
  --bg-card: rgba(17, 24, 39, 0.85);
  --bg-card-hover: rgba(30, 41, 59, 0.95);
  
  --border-subtle: rgba(255, 255, 255, 0.08);
  --border-glow: rgba(59, 130, 246, 0.4);
  
  --primary: #3b82f6;
  --primary-gradient: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
  --secondary-gradient: linear-gradient(135deg, #06b6d4 0%, #3b82f6 100%);
  --accent-pink: linear-gradient(135deg, #ec4899 0%, #8b5cf6 100%);
  --accent-amber: linear-gradient(135deg, #f59e0b 0%, #ef4444 100%);
  
  --text-main: #f8fafc;
  --text-secondary: #94a3b8;
  --text-muted: #64748b;
  
  --shadow-glow: 0 0 25px rgba(37, 99, 235, 0.25);
  --shadow-card: 0 10px 30px -10px rgba(0, 0, 0, 0.5);
}

* {
  box-sizing: border-box;
}

html, body, #app {
  margin: 0;
  min-height: 100%;
  font-family: var(--font-main);
  background-color: var(--bg-dark);
  color: var(--text-main);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  overflow-x: hidden;
  background: var(--bg-dark);
}

/* Custom modern scrollbar */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #0a0e17;
}

::-webkit-scrollbar-thumb {
  background: #1e293b;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #3b82f6;
}

.wrapper-shell {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-dark);
  background-image: 
    radial-gradient(circle at 15% 10%, rgba(37, 99, 235, 0.08) 0%, transparent 40%),
    radial-gradient(circle at 85% 60%, rgba(124, 58, 237, 0.08) 0%, transparent 40%);
  background-attachment: fixed;
}

.sticky-header-container {
  position: sticky;
  top: 0;
  z-index: 1000;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
}

.page-wrapper {
  flex: 1;
  width: 100%;
  display: flex;
  flex-direction: column;
}
</style>
