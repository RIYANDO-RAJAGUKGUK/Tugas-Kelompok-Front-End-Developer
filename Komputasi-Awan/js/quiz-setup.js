document.getElementById('quizSetupForm').addEventListener('submit', function (e) {
  e.preventDefault();

  const namaSiswa = document.getElementById('namaSiswa').value.trim();
  const jumlahPG = parseInt(document.getElementById('jumlahPG').value);
  const jumlahEsai = parseInt(document.getElementById('jumlahEsai').value);

  const semuaSoal = JSON.parse(localStorage.getItem('questions')) || [];

  // Pisahkan soal PG dan Esai
  const soalPG = semuaSoal.filter(s => s.tipe === 'pg');
  const soalEsai = semuaSoal.filter(s => s.tipe === 'esai');

  // Acak dan ambil jumlah yang diminta
  const soalTerpilihPG = shuffleArray(soalPG).slice(0, jumlahPG);
  const soalTerpilihEsai = shuffleArray(soalEsai).slice(0, jumlahEsai);

  const soalFinal = [...soalTerpilihPG, ...soalTerpilihEsai];

  // Simpan ke sessionStorage
  sessionStorage.setItem('namaSiswa', namaSiswa);
  sessionStorage.setItem('soalKuis', JSON.stringify(soalFinal));

  // Redirect ke halaman quiz
  window.location.href = 'quiz.html';
});

// Fungsi untuk mengacak array
function shuffleArray(array) {
  let currentIndex = array.length, randomIndex;

  while (currentIndex !== 0) {
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // Tukar elemen
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }

  return array;
}
