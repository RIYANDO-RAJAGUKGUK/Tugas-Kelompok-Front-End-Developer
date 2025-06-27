function toggleTheme() {
  document.body.classList.toggle("dark");
}

function validateForm() {
  const tgl = document.getElementById("tanggalLahir").value;
  const pass = document.getElementById("password").value;
  const konfirmasi = document.getElementById("konfirmasiPassword").value;
  const emailValid = validateEmail();
  let valid = true;

  document.getElementById("tanggalError").textContent = "";
  document.getElementById("passwordError").textContent = "";

  if (!tgl) {
    document.getElementById("tanggalError").textContent = "Tanggal lahir wajib diisi.";
    valid = false;
  }

  if (pass || konfirmasi) {
    if (pass !== konfirmasi) {
      document.getElementById("passwordError").textContent = "Password tidak cocok.";
      valid = false;
    } else if (pass.length < 6) {
      document.getElementById("passwordError").textContent = "Password minimal 6 karakter.";
      valid = false;
    }
  }

  return valid && emailValid;
}

function validateEmail() {
  const email = document.getElementById("email").value;
  const error = document.getElementById("emailError");
  error.textContent = "";

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!email) {
    error.textContent = "Email wajib diisi.";
    return false;
  } else if (!emailRegex.test(email)) {
    error.textContent = "Format email tidak valid.";
    return false;
  }

  return true;
}

function logout() {
  alert("Anda telah logout.");
  window.location.href = "login.html";
}

// Fungsi tandai sebagai favorit
function tandaiFavorit() {
  const nama = document.getElementById("nama").value;
  const email = document.getElementById("email").value;

  const favorit = {
    nama,
    email,
    tanggal: new Date().toLocaleDateString()
  };

  const favoritSebelumnya = JSON.parse(localStorage.getItem("favoritProfil")) || [];
  favoritSebelumnya.push(favorit);

  localStorage.setItem("favoritProfil", JSON.stringify(favoritSebelumnya));
  alert("Data profil telah ditandai sebagai favorit.");
}

document.addEventListener("DOMContentLoaded", function () {
  const container = document.getElementById("daftar-disukai");
  if (!container) return; 

  const propertiDisukai = JSON.parse(localStorage.getItem("disukai")) || [];

  if (propertiDisukai.length === 0) {
    container.innerHTML = "<p>Belum ada properti yang disukai.</p>";
    return;
  }

  container.innerHTML = propertiDisukai.map(p => `
    <div class="card">
      <img src="${p.gambar}" alt="${p.nama}" style="width:200px;">
      <h3>${p.nama}</h3>
      <p>Harga: Rp ${p.harga}</p>
      <p>Lokasi: ${p.lokasi}</p>
    </div>
  `).join("");
});







