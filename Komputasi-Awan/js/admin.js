const form = document.getElementById('questionForm');
const questionTypeSelect = document.getElementById("questionType");
const pgOptions = document.getElementById("pg-options");
const essayAnswer = document.getElementById("essay-answer");
const multiChoice = document.getElementById("multi-choice");
const correctAnswerPG = document.getElementById("correct-answer-pg");

// Tampilkan input sesuai jenis soal
questionTypeSelect.addEventListener("change", function () {
  const tipe = this.value;

  // Reset semua
  pgOptions.style.display = "none";
  essayAnswer.style.display = "none";
  multiChoice.style.display = "none";
  correctAnswerPG.style.display = "none";

  if (tipe === "pilihanGanda") {
    pgOptions.style.display = "block";
    correctAnswerPG.style.display = "block";
  } else if (tipe === "essay") {
    essayAnswer.style.display = "block";
  } else if (tipe === "multiChoice") {
    pgOptions.style.display = "block";
    multiChoice.style.display = "block";
  }
});

// Proses submit form
form.addEventListener('submit', function (e) {
  e.preventDefault();

  // Normalisasi tipe
  let tipeAsli = questionTypeSelect.value;
  let tipe = tipeAsli === 'pilihanGanda' ? 'pg' : (tipeAsli === 'essay' ? 'esai' : 'multi');

  const soalBaru = {
    question: document.getElementById('question').value,
    score: parseInt(document.getElementById('score').value),
    tipe: tipe
  };

  if (tipe === 'pg') {
    soalBaru.optionA = document.getElementById('optionA').value;
    soalBaru.optionB = document.getElementById('optionB').value;
    soalBaru.optionC = document.getElementById('optionC').value;
    soalBaru.optionD = document.getElementById('optionD').value;
    soalBaru.correctAnswer = document.getElementById('correctAnswer').value.toUpperCase();
  } else if (tipe === 'esai') {
    soalBaru.correctEssay = document.getElementById('correctEssay').value;
  } else if (tipe === 'multi') {
    soalBaru.optionA = document.getElementById('optionA').value;
    soalBaru.optionB = document.getElementById('optionB').value;
    soalBaru.optionC = document.getElementById('optionC').value;
    soalBaru.optionD = document.getElementById('optionD').value;
    soalBaru.correctMulti = document.getElementById('correctMulti').value.toUpperCase();
  }

  const dataLama = JSON.parse(localStorage.getItem('questions')) || [];
  dataLama.push(soalBaru);
  localStorage.setItem('questions', JSON.stringify(dataLama));

  alert("Soal berhasil disimpan!");
  tampilkanSoal();
  form.reset();
});

// Tampilkan daftar soal
function tampilkanSoal() {
  const data = JSON.parse(localStorage.getItem('questions')) || [];
  const tbody = document.querySelector('#questionTable tbody');
  tbody.innerHTML = "";

  data.forEach((soal, index) => {
    const row = document.createElement('tr');
    row.innerHTML = `
      <td>${index + 1}</td>
      <td>${soal.tipe}</td>
      <td>${soal.question}</td>
      <td>${soal.optionA || '-'}</td>
      <td>${soal.optionB || '-'}</td>
      <td>${soal.optionC || '-'}</td>
      <td>${soal.optionD || '-'}</td>
      <td>${soal.correctAnswer || soal.correctEssay || soal.correctMulti || '-'}</td>
      <td>${soal.score}</td>
      <td>
        <button onclick="editSoal(${index})">Edit</button>
        <button onclick="hapusSoal(${index})">Hapus</button>
      </td>
    `;
    tbody.appendChild(row);
  });
}

// Hapus soal
function hapusSoal(index) {
  const data = JSON.parse(localStorage.getItem('questions')) || [];
  if (confirm('Yakin ingin menghapus soal ini?')) {
    data.splice(index, 1);
    localStorage.setItem('questions', JSON.stringify(data));
    tampilkanSoal();
  }
}

// Edit soal
function editSoal(index) {
  const data = JSON.parse(localStorage.getItem('questions')) || [];
  const soal = data[index];

  document.getElementById('question').value = soal.question;
  document.getElementById('score').value = soal.score;

  // Normalisasi tipe balik
  let tipe = soal.tipe === 'pg' ? 'pilihanGanda' : (soal.tipe === 'esai' ? 'essay' : 'multiChoice');
  questionTypeSelect.value = tipe;
  questionTypeSelect.dispatchEvent(new Event('change'));

  if (soal.tipe === 'pg') {
    document.getElementById('optionA').value = soal.optionA;
    document.getElementById('optionB').value = soal.optionB;
    document.getElementById('optionC').value = soal.optionC;
    document.getElementById('optionD').value = soal.optionD;
    document.getElementById('correctAnswer').value = soal.correctAnswer;
  } else if (soal.tipe === 'esai') {
    document.getElementById('correctEssay').value = soal.correctEssay;
  } else if (soal.tipe === 'multi') {
    document.getElementById('optionA').value = soal.optionA;
    document.getElementById('optionB').value = soal.optionB;
    document.getElementById('optionC').value = soal.optionC;
    document.getElementById('optionD').value = soal.optionD;
    document.getElementById('correctMulti').value = soal.correctMulti;
  }

  // Hapus data lama agar bisa simpan ulang setelah diedit
  data.splice(index, 1);
  localStorage.setItem('questions', JSON.stringify(data));
  tampilkanSoal();
}

document.addEventListener("DOMContentLoaded", () => {
  tampilkanSoal();
  questionTypeSelect.dispatchEvent(new Event('change'));
});

