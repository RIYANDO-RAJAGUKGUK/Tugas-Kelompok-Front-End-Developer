const propertiList = [
  {
    id: 1,
    nama: "New Apartment Nice View",
    harga: 34900,
    lokasi: "Belmont Gardens, Chicago",
    tipe: "Apartemen Disewakan",
    luas: "3450 ft²",
    gambar: "./assets/images/property-1.jpg"
  },
  {
    id: 2,
    nama: "Modern Apartments",
    harga: 34900,
    lokasi: "Belmont Gardens, Chicago",
    tipe: "Apartemen Disewakan",
    luas: "3450 ft²",
    gambar: "./assets/images/property-2.jpg"
  },
  {
    id: 3,
    nama: "Comfortable Apartments",
    harga: 34900,
    lokasi: "Belmont Gardens, Chicago",
    tipe: "Apartemen Disewakan",
    luas: "3450 ft²",
    gambar: "./assets/images/property-3.jpg"
  },
  {
    id: 4,
    nama: "Luxury Villa in Rego Park",
    harga: 34900,
    lokasi: "Belmont Gardens, Chicago",
    tipe: "Apartemen Disewakan",
    luas: "3450 ft²",
    gambar: "./assets/images/property-4.jpg"
  }
];

function tambahKeKeranjang(id) {
  const properti = propertiList.find(p => p.id === id);
  if (!properti) {
    alert("Properti tidak ditemukan!");
    return;
  }

  let keranjang = JSON.parse(localStorage.getItem("keranjang")) || [];
  keranjang.unshift(properti);
  localStorage.setItem("keranjang", JSON.stringify(keranjang));

  alert(`"${properti.nama}" berhasil ditambahkan ke keranjang!`);
  window.location.href = "keranjang.html";
}


