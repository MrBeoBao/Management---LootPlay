<template>
  <div class="register-page">

    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>
    <div class="bg-orb bg-orb-3"></div>
    <div class="bg-grid"></div>

    <div class="register-wrap">

      <!-- Brand -->
      <a href="/" class="brand-logo">
        <div class="brand-icon">
          <i class="bx bx-joystick"></i>
        </div>
        <span class="brand-name">Loot<span class="accent">Play</span></span>
      </a>

      <!-- Card -->
      <div class="register-card">

        <!-- Header -->
        <div class="card-header">
          <div class="header-icon">
            <i class="bx bx-user-plus"></i>
          </div>
          <h1>Tạo Tài Khoản</h1>
          <p>Tham gia cộng đồng game thủ LootPlay ngay hôm nay.</p>
        </div>

        <!-- Registration form -->
        <form v-if="!showVerify" @submit.prevent="sendCode" class="register-form">

          <div class="form-row">
            <div class="form-group">
              <label>Họ và tên</label>
              <div class="input-wrap">
                <i class="bx bx-user input-icon"></i>
                <input
                  v-model="form.name"
                  type="text"
                  placeholder="Nhập họ và tên"
                  required
                >
              </div>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Địa chỉ Email</label>
              <div class="input-wrap">
                <i class="bx bx-envelope input-icon"></i>
                <input
                  v-model="form.email"
                  type="email"
                  placeholder="Nhập email"
                  required
                >
              </div>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Số điện thoại</label>
              <div class="input-wrap">
                <i class="bx bx-phone input-icon"></i>
                <input
                  v-model="form.phone"
                  type="text"
                  placeholder="Nhập số điện thoại"
                >
              </div>
            </div>
          </div>

          <div class="form-row form-row-2">
            <div class="form-group">
              <label>Mật khẩu</label>
              <div class="input-wrap">
                <i class="bx bx-lock-alt input-icon"></i>
                <input
                  v-model="form.password"
                  type="password"
                  placeholder="Mật khẩu"
                  required
                >
              </div>
            </div>

            <div class="form-group">
              <label>Nhập lại mật khẩu</label>
              <div class="input-wrap">
                <i class="bx bx-lock input-icon"></i>
                <input
                  v-model="form.confirmPassword"
                  type="password"
                  placeholder="Xác nhận mật khẩu"
                  required
                >
              </div>
            </div>
          </div>

          <div v-if="errorMessage" class="alert alert-error">
            <i class="bx bx-error-circle"></i>
            {{ errorMessage }}
          </div>

          <button type="submit" class="submit-btn">
            <i class="bx bx-send"></i>
            ĐĂNG KÝ NGAY
          </button>

        </form>

        <!-- Verification form -->
        <form v-else @submit.prevent="verifyCode" class="register-form">

          <div class="verify-header">
            <div class="verify-icon">
              <i class="bx bx-mail-send"></i>
            </div>
            <h3>Xác nhận Email</h3>
            <p>Mã xác nhận đã được gửi đến<br><strong>{{ form.email }}</strong></p>
          </div>

          <div class="form-group">
            <label>Mã xác nhận (6 số)</label>
            <div class="input-wrap">
              <i class="bx bx-key input-icon"></i>
              <input
                v-model="verificationCode"
                type="text"
                maxlength="6"
                placeholder="Nhập mã 6 số"
                required
                class="code-input"
              >
            </div>
          </div>

          <div v-if="errorMessage" class="alert alert-error">
            <i class="bx bx-error-circle"></i>
            {{ errorMessage }}
          </div>

          <div v-if="successMessage" class="alert alert-success">
            <i class="bx bx-check-circle"></i>
            {{ successMessage }}
          </div>

          <button type="submit" class="submit-btn">
            <i class="bx bx-check-shield"></i>
            XÁC NHẬN
          </button>

          <button
            type="button"
            class="back-btn"
            @click="showVerify = false"
          >
            <i class="bx bx-arrow-back"></i>
            QUAY LẠI
          </button>

        </form>

        <!-- Footer -->
        <div class="card-footer">
          <span>Đã có tài khoản?</span>
          <a href="/login" class="link">Đăng nhập ngay</a>
        </div>

      </div>

    </div>
  </div>
</template>

<script>
export default {
  name: 'Register',

  data() {
    return {
      form: {
        name: '',
        email: '',
        phone: '',
        password: '',
        confirmPassword: ''
      },

      verificationCode: '',
      showVerify: false,
      errorMessage: '',
      successMessage: ''
    }
  },

  methods: {
    async sendCode() {
      this.errorMessage = ''
      this.successMessage = ''

      if (this.form.password !== this.form.confirmPassword) {
        this.errorMessage = 'Mật khẩu nhập lại không khớp'
        return
      }

      try {
        const response = await fetch(
          'http://127.0.0.1:8000/api/register/send-code',
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: JSON.stringify({
              name: this.form.name,
              email: this.form.email,
              password: this.form.password,
              phone: this.form.phone
            })
          }
        )

        const data = await response.json()

        if (!response.ok) {
          this.errorMessage = data.message || 'Có lỗi xảy ra'
          return
        }

        this.showVerify = true
        this.successMessage = 'Mã xác nhận đã được gửi đến email của bạn'

      } catch (error) {
        this.errorMessage = 'Không thể kết nối đến máy chủ'
      }
    },

    async verifyCode() {
      this.errorMessage = ''
      this.successMessage = ''

      try {
        const response = await fetch(
          'http://127.0.0.1:8000/api/register/verify-code',
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: JSON.stringify({
              name: this.form.name,
              email: this.form.email,
              password: this.form.password,
              phone: this.form.phone,
              code: this.verificationCode
            })
          }
        )

        const data = await response.json()

        if (!response.ok) {
          this.errorMessage = data.message || 'Mã xác nhận không đúng'
          return
        }

        this.successMessage = 'Đăng ký tài khoản thành công'

        setTimeout(() => {
          window.location.href = '/login'
        }, 1500)

      } catch (error) {
        this.errorMessage = 'Không thể kết nối đến máy chủ'
      }
    }
  }
}
</script>

<style scoped>
.register-page {
  min-height: 100vh;
  background: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  position: relative;
  overflow: hidden;
  font-family: var(--font-main, 'Plus Jakarta Sans', sans-serif);
}

.bg-grid {
  position: fixed;
  inset: 0;
  background-image:
    linear-gradient(rgba(59, 130, 246, 0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(59, 130, 246, 0.03) 1px, transparent 1px);
  background-size: 44px 44px;
  pointer-events: none;
}

.bg-orb {
  position: fixed;
  border-radius: 50%;
  pointer-events: none;
}

.bg-orb-1 {
  width: 500px;
  height: 500px;
  left: -200px;
  top: -100px;
  background: radial-gradient(circle, rgba(37, 99, 235, 0.12) 0%, transparent 70%);
}

.bg-orb-2 {
  width: 400px;
  height: 400px;
  right: -150px;
  bottom: -100px;
  background: radial-gradient(circle, rgba(124, 58, 237, 0.1) 0%, transparent 70%);
}

.bg-orb-3 {
  width: 300px;
  height: 300px;
  right: 30%;
  top: -80px;
  background: radial-gradient(circle, rgba(6, 182, 212, 0.07) 0%, transparent 70%);
}

.register-wrap {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 500px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 24px;
}

/* Brand */
.brand-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
}

.brand-icon {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #2563eb, #7c3aed);
  border-radius: 10px;
  color: #fff;
  font-size: 20px;
  box-shadow: 0 0 15px rgba(37, 99, 235, 0.4);
}

.brand-name {
  font-family: 'Rajdhani', sans-serif;
  font-size: 26px;
  font-weight: 800;
  color: #f1f5f9;
}

.accent {
  background: linear-gradient(135deg, #38bdf8, #a78bfa);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Card */
.register-card {
  width: 100%;
  background: rgba(17, 24, 39, 0.85);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 36px 32px;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.5), 0 0 0 1px rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(20px);
}

.card-header {
  text-align: center;
  margin-bottom: 28px;
}

.header-icon {
  width: 56px;
  height: 56px;
  margin: 0 auto 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(37, 99, 235, 0.15), rgba(124, 58, 237, 0.15));
  border: 1px solid rgba(59, 130, 246, 0.25);
  border-radius: 16px;
  color: #60a5fa;
  font-size: 26px;
}

.card-header h1 {
  margin: 0 0 6px;
  font-size: 22px;
  font-weight: 800;
  color: #f1f5f9;
}

.card-header p {
  margin: 0;
  font-size: 13px;
  color: #64748b;
}

/* Form */
.register-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-row { width: 100%; }

.form-row-2 {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 7px;
}

.form-group label {
  font-size: 13px;
  font-weight: 600;
  color: #94a3b8;
}

.input-wrap {
  position: relative;
}

.input-icon {
  position: absolute;
  left: 13px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 17px;
  color: #475569;
  pointer-events: none;
}

.input-wrap input {
  width: 100%;
  box-sizing: border-box;
  padding: 12px 14px 12px 40px;
  background: rgba(30, 41, 59, 0.6);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  color: #f1f5f9;
  font-size: 14px;
  font-family: var(--font-main, sans-serif);
  outline: none;
  transition: all 0.2s ease;
}

.input-wrap input::placeholder {
  color: #475569;
}

.input-wrap input:focus {
  border-color: #3b82f6;
  background: rgba(30, 41, 59, 0.8);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
}

.code-input {
  letter-spacing: 4px;
  font-size: 16px !important;
  font-weight: 700 !important;
  text-align: center;
}

/* Verify header */
.verify-header {
  text-align: center;
  margin-bottom: 24px;
}

.verify-icon {
  width: 56px;
  height: 56px;
  margin: 0 auto 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, rgba(6, 182, 212, 0.15), rgba(37, 99, 235, 0.15));
  border: 1px solid rgba(6, 182, 212, 0.25);
  border-radius: 16px;
  color: #22d3ee;
  font-size: 26px;
}

.verify-header h3 {
  margin: 0 0 6px;
  font-size: 18px;
  font-weight: 700;
  color: #f1f5f9;
}

.verify-header p {
  margin: 0;
  font-size: 13px;
  color: #64748b;
  line-height: 1.6;
}

.verify-header strong {
  color: #38bdf8;
}

/* Alerts */
.alert {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 11px 14px;
  border-radius: 10px;
  font-size: 13px;
  font-weight: 500;
}

.alert i { font-size: 16px; }

.alert-error {
  background: rgba(239, 68, 68, 0.1);
  border: 1px solid rgba(239, 68, 68, 0.25);
  color: #f87171;
}

.alert-success {
  background: rgba(34, 197, 94, 0.1);
  border: 1px solid rgba(34, 197, 94, 0.25);
  color: #4ade80;
}

/* Buttons */
.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  padding: 14px;
  background: linear-gradient(135deg, #2563eb, #7c3aed);
  border: none;
  border-radius: 10px;
  color: #fff;
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 0.5px;
  cursor: pointer;
  transition: all 0.25s ease;
  box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
  font-family: var(--font-main, sans-serif);
  margin-top: 4px;
}

.submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(37, 99, 235, 0.55);
}

.back-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  width: 100%;
  padding: 12px;
  background: rgba(255, 255, 255, 0.04);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 10px;
  color: #94a3b8;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  font-family: var(--font-main, sans-serif);
}

.back-btn:hover {
  background: rgba(255, 255, 255, 0.08);
  color: #e2e8f0;
}

/* Footer */
.card-footer {
  text-align: center;
  margin-top: 22px;
  font-size: 13px;
  color: #64748b;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
}

.link {
  color: #60a5fa;
  font-weight: 700;
  text-decoration: none;
  transition: color 0.2s ease;
}

.link:hover {
  color: #38bdf8;
  text-decoration: underline;
}

@media (max-width: 480px) {
  .register-card { padding: 28px 20px; }
  .form-row-2 { grid-template-columns: 1fr; }
}
</style>