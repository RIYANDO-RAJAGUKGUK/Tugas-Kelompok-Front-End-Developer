function prosesPembayaran() {
  const metodeTerpilih = document.querySelector('input[name="payment"]:checked').value;
  const hasil = document.getElementById("hasil-pembayaran");

  hasil.textContent = `Anda memilih metode pembayaran: ${metodeTerpilih}. Proses rental sedang diproses...`;
}
