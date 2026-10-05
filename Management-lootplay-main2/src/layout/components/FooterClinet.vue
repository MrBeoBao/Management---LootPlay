<template>
  <footer class="footer">
    <div class="footer-inner">

      <!-- Logo + tagline -->
      <div class="footer-brand">
        <div class="footer-logo">
          <div class="footer-logo-icon">
            <i class="bx bx-joystick"></i>
          </div>
          <span class="footer-logo-text">Loot<span class="accent">Play</span></span>
        </div>
        <p class="footer-tagline">
          Cửa hàng game & phần mềm số 1 Việt Nam.<br>
          Bản quyền – Uy tín – Giao hàng tức thì.
        </p>
        <div class="social-links">
          <a href="#" class="social-link" aria-label="Facebook"><i class="bx bxl-facebook"></i></a>
          <a href="#" class="social-link" aria-label="Discord"><i class="bx bxl-discord"></i></a>
          <a href="#" class="social-link" aria-label="YouTube"><i class="bx bxl-youtube"></i></a>
          <a href="#" class="social-link" aria-label="Telegram"><i class="bx bxl-telegram"></i></a>
        </div>
      </div>

      <!-- Quick links -->
      <div class="footer-col">
        <h4>Cửa Hàng</h4>
        <ul>
          <li><a href="/games"><i class="bx bx-joystick"></i> Games</a></li>
          <li><a href="/software"><i class="bx bx-code-block"></i> Phần Mềm</a></li>
          <li><a href="/forum"><i class="bx bx-conversation"></i> Diễn Đàn</a></li>
          <li><a href="/faq"><i class="bx bx-help-circle"></i> FAQs</a></li>
        </ul>
      </div>

      <!-- Account -->
      <div class="footer-col">
        <h4>Tài Khoản</h4>
        <ul>
          <li><a href="/login"><i class="bx bx-log-in"></i> Đăng Nhập</a></li>
          <li><a href="/register"><i class="bx bx-user-plus"></i> Đăng Ký</a></li>
          <li><a href="/cart"><i class="bx bx-shopping-bag"></i> Giỏ Hàng</a></li>
        </ul>
      </div>

      <!-- Trust badges -->
      <div class="footer-col">
        <h4>Cam Kết</h4>
        <ul class="trust-list">
          <li>
            <div class="trust-badge">
              <i class="bx bx-shield-quarter"></i>
              <div>
                <strong>100% Bản Quyền</strong>
                <span>Game & phần mềm chính hãng</span>
              </div>
            </div>
          </li>
          <li>
            <div class="trust-badge">
              <i class="bx bx-bolt-circle"></i>
              <div>
                <strong>Giao Key Tức Thì</strong>
                <span>Tự động 24/7 sau khi thanh toán</span>
              </div>
            </div>
          </li>
          <li>
            <div class="trust-badge">
              <i class="bx bx-support"></i>
              <div>
                <strong>Hỗ Trợ Kỹ Thuật</strong>
                <span>Đội ngũ nhiệt tình, giải quyết nhanh</span>
              </div>
            </div>
          </li>
        </ul>
      </div>

    </div>

    <!-- Bottom bar -->
    <div class="footer-bottom">
      <div class="footer-bottom-inner">
        <p>© 2026 LootPlay. Bảo lưu mọi quyền.</p>
        <div class="footer-bottom-links">
          <a href="#">Chính Sách Bảo Mật</a>
          <span>•</span>
          <a href="#">Điều Khoản Sử Dụng</a>
          <span>•</span>
          <a href="#">Cookie</a>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer {
  background: linear-gradient(180deg, rgba(10, 14, 23, 0.95) 0%, #070b13 100%);
  border-top: 1px solid rgba(59, 130, 246, 0.15);
  padding-top: 64px;
  font-family: var(--font-main, 'Plus Jakarta Sans', sans-serif);
}

.footer-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 24px 48px;
  display: grid;
  grid-template-columns: 1.5fr 1fr 1fr 1.6fr;
  gap: 40px;
}

/* Brand */
.footer-brand { }

.footer-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 14px;
}

.footer-logo-icon {
  width: 38px;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #2563eb, #7c3aed);
  border-radius: 10px;
  color: #fff;
  font-size: 20px;
  box-shadow: 0 0 15px rgba(37, 99, 235, 0.4);
}

.footer-logo-text {
  font-family: 'Rajdhani', sans-serif;
  font-size: 24px;
  font-weight: 800;
  color: #e2e8f0;
}

.accent {
  background: linear-gradient(135deg, #38bdf8, #a78bfa);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.footer-tagline {
  font-size: 13px;
  color: #64748b;
  line-height: 1.7;
  margin: 0 0 20px;
}

.social-links {
  display: flex;
  gap: 10px;
}

.social-link {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.08);
  color: #94a3b8;
  font-size: 17px;
  text-decoration: none;
  transition: all 0.2s ease;
}

.social-link:hover {
  background: linear-gradient(135deg, #2563eb, #7c3aed);
  border-color: transparent;
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 6px 14px rgba(37, 99, 235, 0.35);
}

/* Columns */
.footer-col h4 {
  font-size: 13px;
  font-weight: 700;
  color: #f1f5f9;
  letter-spacing: 1px;
  text-transform: uppercase;
  margin: 0 0 18px;
  padding-bottom: 10px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
}

.footer-col ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.footer-col ul li a {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 13px;
  color: #64748b;
  text-decoration: none;
  transition: all 0.2s ease;
  font-weight: 500;
}

.footer-col ul li a i {
  font-size: 15px;
  color: #334155;
  transition: color 0.2s ease;
}

.footer-col ul li a:hover {
  color: #60a5fa;
  transform: translateX(4px);
}

.footer-col ul li a:hover i {
  color: #60a5fa;
}

/* Trust list */
.trust-list {
  gap: 14px !important;
}

.trust-badge {
  display: flex;
  align-items: center;
  gap: 10px;
}

.trust-badge > i {
  font-size: 22px;
  color: #2563eb;
  flex-shrink: 0;
}

.trust-badge div {
  display: flex;
  flex-direction: column;
}

.trust-badge strong {
  font-size: 12px;
  font-weight: 700;
  color: #e2e8f0;
  display: block;
}

.trust-badge span {
  font-size: 11px;
  color: #64748b;
}

/* Bottom bar */
.footer-bottom {
  border-top: 1px solid rgba(255, 255, 255, 0.06);
}

.footer-bottom-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 18px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.footer-bottom p {
  margin: 0;
  font-size: 12px;
  color: #475569;
}

.footer-bottom-links {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 12px;
  color: #475569;
}

.footer-bottom-links a {
  color: #64748b;
  text-decoration: none;
  transition: color 0.2s;
}

.footer-bottom-links a:hover {
  color: #60a5fa;
}

@media (max-width: 1024px) {
  .footer-inner {
    grid-template-columns: 1fr 1fr;
    gap: 32px;
  }
}

@media (max-width: 640px) {
  .footer-inner {
    grid-template-columns: 1fr;
  }
  .footer-bottom-inner {
    flex-direction: column;
    gap: 10px;
    text-align: center;
  }
}
</style>