document.addEventListener("DOMContentLoaded", tampilkanKeranjang);

function tampilkanKeranjang() {
  const container = document.getElementById("keranjang-container");
  const totalEl = document.getElementById("total-harga");


  const keranjang = JSON.parse(localStorage.getItem("keranjang")) || [];

  container.innerHTML = "";

  if (keranjang.length === 0) {
    container.innerHTML = '<p class="empty">Keranjang Anda masih kosong.</p>';
    totalEl.textContent = "";
    return;
  }

  let total = 0;

  keranjang.forEach((item, index) => {
    const angkaHarga = typeof item.harga === "string"
      ? Number(item.harga.replace(/[^\d]/g, ""))
      : item.harga;

    total += angkaHarga;

    const div = document.createElement("div");
    div.className = "item";
    div.innerHTML = `
      <img src="${item.gambar}" alt="${item.nama}">
      <div class="item-info">
        <h2>${item.nama}</h2>
        <p>Harga: ${formatRupiah(angkaHarga)}</p>
      </div>
      <button class="hapus-btn" onclick="hapusItem(${index})" title="Hapus item">🗑️</button>
    `;
    container.appendChild(div);
  });

  totalEl.textContent = "Total Harga: " + formatRupiah(total);
}

function hapusItem(index) {
  const keranjang = JSON.parse(localStorage.getItem("keranjang")) || [];
  keranjang.splice(index, 1);
  localStorage.setItem("keranjang", JSON.stringify(keranjang));
  tampilkanKeranjang();
}

function formatRupiah(angka) {
  return "$ " + angka.toLocaleString("id-ID");
}

function bayarSekarang() {
  alert("Terima kasih! Pembayaran Anda sedang diproses.");
}

function bayarSekarang() {
    const metodeDiv = document.getElementById("metode-pembayaran");
    metodeDiv.style.display = "block";
  }

  function konfirmasiPembayaran() {
    const metodeDipilih = document.querySelector('input[name="metode"]:checked');
    if (metodeDipilih) {
      alert("Anda memilih metode: " + metodeDipilih.value + "\nTerima kasih atas pembeliannya!");
    } else {
      alert("Silakan pilih salah satu metode pembayaran.");
    }
  }