<template>
  <div class="login-page">

    <!-- Background orbs -->
    <div class="bg-orb bg-orb-1"></div>
    <div class="bg-orb bg-orb-2"></div>
    <div class="bg-grid"></div>

    <div class="login-wrap">

      <!-- Logo -->
      <a href="/" class="brand-logo">
        <div class="brand-icon">
          <i class="bx bx-joystick"></i>
        </div>
        <span class="brand-name">Loot<span class="accent">Play</span></span>
      </a>

      <!-- Card -->
      <div class="login-card">

        <!-- Header -->
        <div class="card-header">
          <div class="header-icon">
            <i class="bx bx-log-in-circle"></i>
          </div>
          <h1>Đăng Nhập</h1>
          <p>Chào mừng trở lại! Đăng nhập để tiếp tục.</p>
        </div>

        <!-- Form -->
        <form @submit.prevent="login" class="login-form">

          <div class="form-group">
            <label for="loginEmail">Địa chỉ Email</label>
            <div class="input-wrap">
              <i class="bx bx-envelope input-icon"></i>
              <input
                v-model="form.email"
                type="email"
                id="loginEmail"
                placeholder="Nhập email của bạn"
                required
              >
            </div>
          </div>

          <div class="form-group">
            <label for="loginPassword">Mật khẩu</label>
            <div class="input-wrap">
              <i class="bx bx-lock-alt input-icon"></i>
              <input
                v-model="form.password"
                type="password"
                id="loginPassword"
                placeholder="Nhập mật khẩu"
                required
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
            <i class="bx bx-log-in"></i>
            ĐĂNG NHẬP
          </button>

        </form>

        <!-- Footer -->
        <div class="card-footer">
          <span>Chưa có tài khoản?</span>
          <a href="/register" class="link">Đăng ký ngay</a>
        </div>

      </div>

    </div>
  </div>
</template>

<script>
export default {
  name: 'Login',

  data() {
    return {
      form: {
        email: '',
        password: ''
      },

      errorMessage: '',
      successMessage: ''
    }
  },

  methods: {
    async login() {
      this.errorMessage = ''
      this.successMessage = ''

      try {
        const response = await fetch(
          'http://127.0.0.1:8000/api/login',
          {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json'
            },
            body: JSON.stringify({
              email: this.form.email,
              password: this.form.password
            })
          }
        )

        const data = await response.json()

        if (!response.ok) {
          this.errorMessage = data.message || 'Email hoặc mật khẩu không đúng'
          return
        }

        this.successMessage = 'Đăng nhập thành công'

        localStorage.setItem('user', JSON.stringify(data.user))

        setTimeout(() => {
          window.location.href = '/'
        }, 1000)

      } catch (error) {
        this.errorMessage = 'Không thể kết nối đến máy chủ'
      }
    }
  }
}
</script>

<style scoped>
.login-page {
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

/* Background */
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
  background: radial-gradient(circle, rgba(37, 99, 235, 0.15) 0%, transparent 70%);
}

.bg-orb-2 {
  width: 400px;
  height: 400px;
  right: -150px;
  bottom: -100px;
  background: radial-gradient(circle, rgba(124, 58, 237, 0.12) 0%, transparent 70%);
}

.login-wrap {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 420px;
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
.login-card {
  width: 100%;
  background: rgba(17, 24, 39, 0.85);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 36px 32px;
  box-shadow:
    0 25px 50px rgba(0, 0, 0, 0.5),
    0 0 0 1px rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(20px);
}

/* Card Header */
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
.login-form {
  display: flex;
  flex-direction: column;
  gap: 18px;
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

/* Submit button */
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

/* Card footer */
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
</style>