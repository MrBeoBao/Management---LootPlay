<template>
  <div class="min-vh-100 d-flex flex-column align-items-center justify-content-center"
    style="background-color: #eef1f7;">

    <!-- Logo -->
    <div class="text-center mb-4">
      <div class="d-inline-flex align-items-center gap-2">
        <div class="rounded-3 bg-warning d-flex align-items-center justify-content-center"
          style="width: 42px; height: 42px;">
          <i class="bx bx-joystick text-white fs-4"></i>
        </div>

        <span class="fs-4 fw-bold text-dark">
          Loot<span class="text-warning">Play</span>
        </span>
      </div>
    </div>

    <!-- Card đăng nhập -->
    <div class="card border-0 shadow-sm rounded-4 p-2"
      style="width: 100%; max-width: 400px;">

      <div class="card-body px-4 py-4">

        <!-- Icon + Tiêu đề -->
        <div class="text-center mb-4">
          <div
            class="rounded-circle bg-warning bg-opacity-10 d-inline-flex align-items-center justify-content-center mb-3"
            style="width: 70px; height: 70px;">

            <i class="bx bx-user text-warning"
              style="font-size: 2.2rem;"></i>
          </div>

          <h5 class="fw-bold text-dark mb-1">
            Đăng Nhập LootPlay
          </h5>

          <p class="text-muted small mb-0">
            Chào mừng bạn trở lại! Vui lòng đăng nhập tài khoản.
          </p>
        </div>

        <form @submit.prevent="dangnhapTK">

          <!-- Email -->
          <div class="mb-3">
            <label for="loginEmail"
              class="form-label fw-semibold small">
              Địa Chỉ Email
            </label>

            <div class="input-group input-group-sm">

              <span class="input-group-text bg-white border-end-0 text-muted">
                <i class="bx bx-envelope"></i>
              </span>

              <input
                v-model="dangNhap.email"
                type="email"
                class="form-control border-start-0 ps-0"
                id="loginEmail"
                placeholder="Nhập email"
                required
              />

            </div>
          </div>

          <!-- Mật khẩu -->
          <div class="mb-2">

            <label for="loginPassword"
              class="form-label fw-semibold small">
              Mật Khẩu
            </label>

            <div class="input-group input-group-sm">

              <span class="input-group-text bg-white border-end-0 text-muted">
                <i class="bx bx-lock-alt"></i>
              </span>

              <input
                v-model="dangNhap.mat_khau"
                :type="hienMK ? 'text' : 'password'"
                class="form-control border-start-0 border-end-0 ps-0"
                id="loginPassword"
                placeholder="Nhập mật khẩu"
                required
              />

              <span
                class="input-group-text bg-white border-start-0 text-muted"
                style="cursor: pointer;"
                @click="hienMK = !hienMK"
              >
                <i :class="hienMK ? 'bx bx-hide' : 'bx bx-show'"></i>
              </span>

            </div>
          </div>

          <!-- Quên mật khẩu -->
          <div class="text-end mb-4">

            <router-link
              to="/quen-mat-khau"
              class="text-warning small text-decoration-none fw-semibold"
            >
              <i class="bx bx-help-circle me-1"></i>
              Quên mật khẩu?
            </router-link>

          </div>

          <!-- Nút đăng nhập -->
          <div class="d-grid mb-3">

            <button
              type="submit"
              class="btn btn-warning fw-bold text-white"
              style="background: linear-gradient(135deg, #f5a623, #e08c00);
                     border: none;
                     letter-spacing: 0.5px;"
            >
              <i class="bx bx-log-in-circle me-2"></i>
              ĐĂNG NHẬP
            </button>

          </div>

        </form>

      </div>

      <!-- Footer -->
      <div class="card-footer bg-transparent border-0 text-center pb-3">

        <span class="text-muted small">
          Chưa có tài khoản?
        </span>

        <router-link
          to="/dang-ky"
          class="text-warning small text-decoration-none fw-semibold"
        >
          Đăng ký ngay
        </router-link>

      </div>

    </div>

  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "DangNhap",

  data() {
    return {
      hienMK: false,

      dangNhap: {
        email: "",
        mat_khau: ""
      }
    };
  },

  methods: {

    dangnhapTK() {

      axios.post(
        'http://127.0.0.1:8000/api/dang-nhap',
        this.dangNhap
      )

      .then((res) => {

        console.log(res.data);

        this.$toast.success(
          res.data.thong_bao
        );

        localStorage.setItem(
          'nguoi_dung',
          JSON.stringify(res.data.nguoi_dung)
        );

        this.$router.push('/dashboard');

      })

      .catch((error) => {

        console.log(error);

        if (error.response && error.response.data) {

          const errors = error.response.data.errors;

          if (errors) {

            const firstKey = Object.keys(errors)[0];

            this.$toast.error(
              errors[firstKey][0]
            );

          } else {

            this.$toast.error(
              error.response.data.thong_bao ||
              'Đăng nhập thất bại!'
            );

          }

        } else {

          this.$toast.error(
            'Không kết nối được với Backend Laravel!'
          );

        }

      });

    }

  }

};
</script>